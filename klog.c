#include "types.h"
#include "defs.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "klog.h"


struct {
  struct spinlock lock;
  struct logentry entries[KLOG_SIZE];
  int head;  // Next write position
  int count; // Number of entries
  uint ticks; // System uptime counter
} klog;

void
klog_init(void)
{
  initlock(&klog.lock, "klog");
  klog.head = 0;
  klog.count = 0;
  klog.ticks = 0;
}

void
klog_add(int type, int pid, int extra)
{
  acquire(&klog.lock);
  
  klog.entries[klog.head].timestamp = klog.ticks++;
  klog.entries[klog.head].event_type = type;
  klog.entries[klog.head].pid = pid;
  klog.entries[klog.head].extra = extra;
  
  klog.head = (klog.head + 1) % KLOG_SIZE;
  if(klog.count < KLOG_SIZE)
    klog.count++;
  
  release(&klog.lock);
}

void
klog_dump(void)
{
  cprintf("\n=== KERNEL LOG DUMP ===\n");
  int i;
  int start = (klog.head - klog.count + KLOG_SIZE) % KLOG_SIZE;
  
  for(i = 0; i < klog.count; i++){
    int idx = (start + i) % KLOG_SIZE;
    cprintf("[%d] type=%d pid=%d extra=%d\n",
            klog.entries[idx].timestamp,
            klog.entries[idx].event_type,
            klog.entries[idx].pid,
            klog.entries[idx].extra);
  }
}

int
klog_getlogs(struct logentry *buf, int max)
{
  struct proc *curproc = myproc();
  struct logentry temp[256];
  
  acquire(&klog.lock);
  int n = klog.count < max ? klog.count : max;
  if(n > 256) n = 256;  // Safety limit
  
  int start = (klog.head - n + KLOG_SIZE) % KLOG_SIZE;
  
  // Copy to kernel temp buffer
  for(int i = 0; i < n; i++){
    int idx = (start + i) % KLOG_SIZE;
    temp[i] = klog.entries[idx];
  }
  
  release(&klog.lock);
  
  // Copy entire buffer to user space
  if(copyout(curproc->pgdir, (uint)buf, (char*)temp, n * sizeof(struct logentry)) < 0){
    return -1;
  }
  
  return n;
}

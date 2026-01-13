#include "types.h"
#include "stat.h"
#include "user.h"

int main(void)
{
  struct logentry *entries = malloc(256 * sizeof(struct logentry));
  
  if(entries == 0){
    printf(1, "klogs: out of memory\n");
    exit();
  }
  
  int n = getklogs(entries, 256);
  
  if(n < 0){
    printf(1, "klogs: failed to get kernel logs\n");
    free(entries);
    exit();
  }
  
  // Event type names
  char *event_names[] = {"SYSCALL", "TRAP", "FORK", "EXIT", "SCHED"};
  
  printf(1, "\n========== Kernel Flight Recorder ==========\n");
  printf(1, "Total entries: %d\n\n", n);
  
  printf(1, "Time  | Event      | PID  | Info\n");
  printf(1, "------|------------|------|-----\n");
  
  for(int i = 0; i < n; i++){
    char *event_name = "UNKNOWN";
    if(entries[i].event_type >= 0 && entries[i].event_type < 5){
      event_name = event_names[entries[i].event_type];
    }
    
    printf(1, "%d | %s | %d | %d\n", 
           entries[i].timestamp, 
           event_name,
           entries[i].pid, 
           entries[i].extra);
  }
  
  free(entries);
  exit();
}

// Kernel logging system (flight recorder)

// Kernel logging system (flight recorder)

#ifndef KLOG_H
#define KLOG_H

#define KLOG_SIZE 128  // Number of log entries to keep

// struct logentry is defined in types.h

void klog_init(void);
void klog_add(int type, int pid, int extra);
void klog_dump(void);
int klog_getlogs(struct logentry *buf, int max);

#endif

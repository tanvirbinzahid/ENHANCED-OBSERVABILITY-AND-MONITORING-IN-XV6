#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  struct pstat procs[64];
  struct kstat ks;
  int n, i;
  
  // Get kernel stats
  if(getkernelstats(&ks) < 0){
    printf(2, "Error getting kernel stats\n");
    exit();
  }
  
  // Get process stats
  n = getprocstats(procs, 64);
  if(n < 0){
    printf(2, "Error getting process stats\n");
    exit();
  }
  
  // Display dashboard
  printf(1, "\n========== xv6 System Dashboard ==========\n");
  printf(1, "Uptime: %d ticks | CPU Temp: %d C | CPU Load: %d%%\n", 
         ks.uptime, ks.cputemp, ks.cpuload);
  printf(1, "Active Processes: %d\n", ks.numproc);
  printf(1, "==========================================\n\n");
  
  printf(1, "PID | Name       | State     | Memory\n");
  printf(1, "----+------------+-----------+--------\n");
  
  for(i = 0; i < n; i++){
    printf(1, "%d | %s | %s | %d\n",
           procs[i].pid,
           procs[i].name,
           procs[i].state,
           procs[i].sz);
  }
  
  printf(1, "\n");
  
  // Temperature warning
  if(ks.cputemp > 80){
    printf(1, "WARNING: CPU temperature high!\n");
  }
  
  exit();
}

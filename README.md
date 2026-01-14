
<!-- ========================================================= -->
<!-- CYBER-ACADEMIC README FOR XV6 OBSERVABILITY AND SYSDASH   -->
<!-- ========================================================= -->

<p align="center">
<pre>

██╗░░██╗███████╗██████╗░███╗░░██╗███████╗██╗░░░░░  ███████╗██╗░░░░░██╗░██████╗░██╗░░██╗████████╗
██║░██╔╝██╔════╝██╔══██╗████╗░██║██╔════╝██║░░░░░  ██╔════╝██║░░░░░██║██╔════╝░██║░░██║╚══██╔══╝
█████═╝░█████╗░░██████╔╝██╔██╗██║█████╗░░██║░░░░░  █████╗░░██║░░░░░██║██║░░██╗░███████║░░░██║░░░
██╔═██╗░██╔══╝░░██╔══██╗██║╚████║██╔══╝░░██║░░░░░  ██╔══╝░░██║░░░░░██║██║░░╚██╗██╔══██║░░░██║░░░
██║░╚██╗███████╗██║░░██║██║░╚███║███████╗███████╗  ██║░░░░░███████╗██║╚██████╔╝██║░░██║░░░██║░░░
╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚══════╝  ╚═╝░░░░░╚══════╝╚═╝░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░

██████╗░███████╗░█████╗░░█████╗░██████╗░██████╗░███████╗██████╗░  
██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗  
██████╔╝█████╗░░██║░░╚═╝██║░░██║██████╔╝██║░░██║█████╗░░██████╔╝  
██╔══██╗██╔══╝░░██║░░██╗██║░░██║██╔══██╗██║░░██║██╔══╝░░██╔══██╗  
██║░░██║███████╗╚█████╔╝╚█████╔╝██║░░██║██████╔╝███████╗██║░░██║  
╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝░░╚═╝╚═════╝░╚══════╝╚═╝░░╚═╝  
</pre>
<sub>Kernel Flight Recorder + System Telemetry Dashboard for MIT xv6</sub>
</p>

---

<p align="center">
<img src="https://img.shields.io/badge/build-qemu--x86-green?style=for-the-badge">
<img src="https://img.shields.io/badge/architecture-xv6%20kernel-blue?style=for-the-badge">
<img src="https://img.shields.io/badge/observability-flight--recorder-purple?style=for-the-badge">
<img src="https://img.shields.io/badge/dashboard-sysdash-orange?style=for-the-badge">
<img src="https://img.shields.io/badge/mode-cyberpunk%2Bacademic-teal?style=for-the-badge">
<img src="https://img.shields.io/badge/status-production--grade-lightgrey?style=for-the-badge">
</p>

---

# 🧭 SYSTEM OVERVIEW (TLDR)

**Mission:** Provide **high-fidelity runtime visibility** inside xv6 with **minimal kernel disruption**.

**Functional Stack (brief):**

- **Flight Recorder:** bounded circular event logs
- **Kernel Hooks:** syscall, trap, scheduler, fork, exit
- **Sysdash Telemetry:** CPU temp, load, uptime, process table
- **Syscalls:** safe kernel→user access (`getklogs`, `getprocstats`, `getkernelstats`)
- **Synthetic Sensors:** demonstration-grade thermal & load model

This hybrid design mixes **systems-grade rigor** with **cyberpunk terminal UX**.

---

# ⚙ ARCHITECTURE GLANCE (COMPRESSED)

```
USERSPACE:   klogs | sysdash
                 ╲    ╱
                  syscalls
                     ↓
 KERNEL:   getklogs / getprocstats / getkernelstats
                     ↓
           Flight Recorder + Telemetry Model
                     ↓
         Hooks(syscall/trap/fork/exit/sched)
```

---

# 💾 EVENT TYPES + SEMANTICS (BRIEF)

| Event | Source | Extra |
|---|---|---|
| SYSCALL | syscall.c | syscall #
| TRAP | trap.c | trap #
| CTXSWITCH | proc.c | — |
| FORK | proc.c | child PID |
| EXIT | proc.c | — |

Events are timestamped, O(1), overwrite-on-full (black-box semantics).

---

# 📊 SYSDASH: LIVE TELEMETRY

Monitors:

- `uptime (ticks)`
- `cpu_load (%)`
- `cpu_temp (°C)`
- `active_processes`
- process table: `{pid, name, state, mem_bytes}`

### **Sample Output With Thermal Warning**

```
┌──────────────────────────────────────────────────────────────┐
│ UPTIME: 55620 ticks | TEMP: 93°C | LOAD: 84% | PROC: 5       │
│ STATUS: !! WARNING: HIGH CORE TEMPERATURE !!                 │
├──────────────────────────────────────────────────────────────┤
│ PID | NAME  | STATE    | MEM                                 │
│ 1   | init  | RUNNING  | 4096                                │
│ 4   | sh    | SLEEP    | 8192                                │
│ 7   | stress| RUNNING  | 10240                               │
└──────────────────────────────────────────────────────────────┘
```

**High Temp Threshold (Demo Use):** `> 90°C` triggers warning banner.  
(This is **synthetic**, not querying hardware sensors.)

---

# 🌡 CPU TEMP + LOAD MODEL (BRIEF BUT INFORMATIVE)

- updated per-timer-tick inside `trap.c`
- `busy_ticks++` if `p->state == RUNNING`
- `idle_ticks++` otherwise
- `cpuload = busy_ticks / (busy+idle) × 100`
- `cputemp++` on busy until cap (`95°C`)
- `cputemp--` on idle until baseline (`35°C`)

This creates a **responsive but stable signal** for demonstration.

---

# 🧩 KERNEL CALL SURFACE (SAFE EXPORT)

```c
int getklogs(struct logentry *buf, int max);
int getprocstats(struct pstat *buf, int max);
int getkernelstats(struct kstat *ks);
```

Safety properties (condensed):

- bounded user buffers
- validated pointers
- deterministic copy-out
- no heap allocations

---

# 🎛 BUILD & EXECUTION (FAST)

```sh
make && make qemu
```

Inside xv6 shell:

```sh
$ klogs     # prints recent flight events
$ sysdash   # prints live system telemetry
```

---

# 🧠 WHY THIS WORKS (ACADEMIC MINI-JUSTIFICATION)

This system satisfies:

✔ **Temporal Observability**: execution history via event logs  
✔ **Real-time Monitoring**: continuous telemetry snapshot  
✔ **Bounded Footprint**: fixed memory, constant overhead  
✔ **Safe Introspection**: controlled kernel/user bridge  
✔ **Pedagogical Value**: maps to modern OS observability APIs

---

# 🛰 FUTURE WORK (SHORTFORM)

- per-CPU logging
- persistent dumps on panic
- event filtering by PID/type
- `/proc`-style FS
- web dashboard bridge
- RISC-V backend

---

# 🔗 DOCUMENTATION

📄 **Final Project Report:** `Final Project Report.pdf`

---

# 👤 AUTHOR

**Tanvir Bin Zahid**  
Kernel & Systems Developer

---

# 📜 LICENSE

MIT License


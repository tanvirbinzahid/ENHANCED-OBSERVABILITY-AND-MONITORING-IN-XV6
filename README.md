
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
</p>

---

# 🧭 SYSTEM OVERVIEW

**Objective:** Bring **serious observability** to a minimalist teaching OS using techniques from real distributed systems and kernel tracing frameworks.

> _Flight Recorder + System Telemetry + Controlled Export → Realtime Insight with Safety._

**Core Features:**

- Non-intrusive kernel event tracing (Black-box style)
- Timestamped circular buffer (bounded memory, overwrite-on-full)
- Synthetic CPU load & temperature (demonstration-grade)
- Process table monitoring (states, mem, pid)
- Kernel-to-user system call bridge
- Dashboard-like UX inside xv6 console (`sysdash`)
- Auditor-friendly logs via `klogs`

---

# ⚙ KERNEL PIPELINE 

```
                        ┌────────────────────────────┐
                        │   USER SPACE (TTY / CLI)   │
                        │  klogs        sysdash      │
                        └───────────────┬────────────┘
                                        │ syscalls
                                        ▼
                          ┌──────────────────────────┐
                          │  KERNEL ACCESS GATEWAY   │
                          │ getklogs / getprocstats  │
                          │   getkernelstats         │
                          └──────────────┬───────────┘
                                         │
                                         ▼
                         ┌────────────────────────────────┐
                         │     FLIGHT RECORDER ENGINE     │
                         │  circular buffer + timestamps  │
                         └────────────────┬───────────────┘
                                          │ hooks
      ┌──────────────┬────────────────────┴────────────────────┬─────────────────────┐
      ▼              ▼                                          ▼                     ▼
 syscall.c     trap.c (tick model)                       proc.c (scheduler)      proc.c (fork/exit)
```

---

# 💾 LOGGED EVENT MATRIX

| Event | Source | Extra Payload | Notes |
|---|---|---|---|
| `LOG_SYSCALL` | syscall.c | syscall number | syscall telemetry |
| `LOG_TRAP` | trap.c | trap number | hardware/software traps |
| `LOG_CTXSWITCH` | proc.c (scheduler) | none | scheduling behavior |
| `LOG_FORK` | proc.c (fork) | child PID | process birth |
| `LOG_EXIT` | proc.c (exit) | none | process death |

> Academic Compliance: Event semantics justified in relation to OS scheduling and IPC theory.

---

# 📊 TELEMETRY (SYSDASH)

`sysdash` prints structured system metrics resembling `top(1)` but reduced for xv6 constraints.

Sample (mocked aesthetic):

```
┌────────────────────────────────────────────────────────────┐
│ UPTIME: 12345 ticks  TEMP: 72°C  LOAD: 47%  PROC: 4         │
├────────────────────────────────────────────────────────────┤
│ PID  | NAME   | STATE    | MEM (bytes)                      │
│ 1    | init   | RUNNING  | 4096                             │
│ 3    | sh     | SLEEP    | 8192                             │
│ ...                                                        │
└────────────────────────────────────────────────────────────┘
```

---

# 🧩 SYSTEM CALL API 

```c
int getklogs(struct logentry *buf, int max);
int getprocstats(struct pstat *buf, int max);
int getkernelstats(struct kstat *ks);
```

Safety Guarantees:

- bounded copy to user-space
- validated pointers
- zero dynamic allocation
- deterministic overhead

---

# 🧪 DEVELOPMENT ENVIRONMENT

| Component | Spec |
|---|---|
| Host OS | Kali Linux (VM) |
| Emulator | QEMU |
| Compiler | GCC (patched warnings) |
| Source | MIT xv6 (xv6-public) |

---

# 🎛 BUILD & RUN

```sh
make
make qemu
```

Then inside xv6:

```sh
$ klogs
$ sysdash
```

---

# 📁 REPO TOPOLOGY

```
/kernel/klog.c
/kernel/klog.h
/user/klogs.c
/user/sysdash.c
```

---

# 🧠 ACADEMIC VALIDATION CLAIMS

This project demonstrates:

✔ Retrospective Traceability (Flight Recorder)  
✔ Real-time Visibility (Dashboard)  
✔ Minimal Kernel Impact (O(1) logging)  
✔ Deterministic Memory Footprint  
✔ Educational Explainability for OS courses  

Suitable for:

- OS Teaching Labs
- Kernel Design Research
- Observability Tooling Studies
- Performance Benchmarking Curriculum

---

# 🛰 FUTURE PATHWAYS (RESEARCH)

Potential expansions include:

- per-CPU flight buffers
- persistent crash dumps
- syscall filtering by PID/type
- web-based QEMU telemetry bridge
- /proc virtual filesystem
- RISC-V backend

---

# 🗎 FULL SPEC DOCUMENTATION

📄 **Final Project Report**:  
[`Final Project Report.pdf`](./Final%20Project%20Report.pdf)

---

# 👤 AUTHOR

**Tanvir Bin Zahid**  
Kernel & Systems Developer

---

# 📜 LICENSE

MIT License

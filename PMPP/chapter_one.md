# CHAPTER ONE
## Programming Massively Parallel Processors, 4th Edition by Wen-mei W. Hwu, David B. Kirk, Izzat El Hajj

Would've been better if the Duke Library had the 5th Edition, but alas.

### Start

- Microprocessors originally targeted strong single-thread (sequential) performance, though modern CPUs are multicore and run many threads (e.g. Intel & AMD x86)
- *FLOPS: Floating-Point Operations Per-Second. A throughput metric for floating-point compute capability*
- *Clock Frequency: How many cycles a CPU performs per-second*
- Energy consumption & heat dissipation issues limited clock frequency and calculations per-cycle, leading to multicore chips that use multiple processing cores to increase total processing power
- To leverage this new model, we need multiple instruction sequences whether from the same application or different applications that can simultaneously execute on all of these cores
- *Von Neumann Architecture: Computer design where instructions and data are stored in the same memory space. This means the CPU fetches both instructions and data from the same memory, using the same pathways. Typically consists of three main components: CPU, memory, and I/O devices* -> definition from Geeksforgeeks
- The vast majority of software applications are written as sequential programs that are executed by processors whose design was envisioned by von Neumann
- The execution is as follows: "step" through code using a program counter (or instruction pointer), that contains the memory address of the next instruction to be executed by the processor. The sequence of instruction execution activities resulting from this sequential, stepwise execution of an application is referred to as a thread of execution, or simply *thread*.
- Historically, hardware advances enabled improvements in sequential software applications, but since sequential applications run on a single core, and the performance of a single core doesn't increase much from generation to generation, this is no longer the case.
- Instead, performance improvements are leveraged by parallel applications which use multiple threads.
- Two trajectories for microprocessor design:
1. Multicore CPUs. Strong emphasis on low-latency execution and high single-thread performance, while still supporting parallel execution across cores.
2. Many-thread GPUs. Strong emphasis on high throughput by running many threads/tasks at once.
- Reasons for the peak performance gap between multicore & multithread-focused architectures:
1. Reducing latency (common CPU focus) is much more expensive than increasing throughput (common GPU focus) in terms of power & chip area. CPUs spend more transistors on low-latency control logic and caching, while GPUs spend more on arithmetic throughput.
2. Memory system design. GPUs are built for very high-bandwidth parallel memory access, while CPUs are tuned for low-latency access patterns and general-purpose workloads.
- *Amdahl's Law: The level of speedup achievable is limited by the parallelizable portion of the application*
- Challenges of parallelization:
1. Many real-world problems are naturally sequential, and parallelizing them is non-trivial
2. Execution speed is limited by memory access latency & throughput
3. Execution speed of parallel programs is limited by data dependencies and load imbalance
4. Some applications are synchronization-heavy (opposite: embarrassingly parallelizable) -> causes threads to sit idle while waiting for other threads to finish. 
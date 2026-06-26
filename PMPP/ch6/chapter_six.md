- CUDA device global memory is DRAM wich is slow, so memory coalescing is important
- DRAM capacitors have gotten smaller to increase data storage, but as a consequence access latency has not improved
- Accessing one DRAM location accesses an entire burst of consecutive locations around it which can be quickly delivered in parallel, we aim to make use of said bursts
- Strategy one: rearrange how threads are mapped to data
- Strategy two: rearrange data layout
- Strategy three: transfer data from global to shared memory and use shared memory for computation (corner turning)
- When hiding memory latency we can utilize coalescing
- DRAM is organized into channels, buses, and banks
- Processors contain >= 1 channel (usually 1-8)
- Channels control memory w/ a bus that connects a set of DRAM banks to the processor
- DDR (double data rate) buses perform 2 data transfers per-cycle
- Channels have enough buses to utilize the transfer bandwith of the bus
- If R is the ratio of cell access latency & data transfer, we need >= R+7 banks
- When it's not worth it to parallelize we use thread coarsening -> assigning a thread multiple units of work
- Main pitfalls:
1. Make sure thread coarsening is necessary
2. Don't coarsen so much that you underutilize hardware
3. Avoid increasing resource consumption S.T. is harms occupancy
- Optimizations checklist:
1. Maximize occupancy
2. Enable coalesced global memory access
3. Minimize control divergence
4. Tiling of reused data
5. Privatization 
6. Thread coarsening
- We can identify computational bottlenecks with a prolifer
1. No, because each index is used exactly once, so its useless to cache indices since they can't be reused across threads.
2. On paper -- essentially, we're just continuously accruing the partial sums of P-values across the elements loaded in each tile phase. Bigger tile size equals more sharing.
3. If we don't use the first syncthread, we might start calculating the indices before we have finished caching them which could result in us accessing a cache value that hasn't been loaded yet. If we don't use the second syncthread, we might not have finished calculating the P values before we iterate through the next tile's loading phase.
4. Because we might need to share the values fetched from global memory between threads, e.g. for matrix multiplication, and we can't share values across each thread's registers
5. 1/32
6. 512,000 
7. 1,000 times
8. a. N times
8. b. once
9. a. Kernels AI: 36 FLOPS per thread, 28 bytes per thread. 36 FLOPS/28 bytes = 1.286 FLOPS/B. The  kernel has peak of 200/100 = 2 FLOPS/B > 1.2 FLOPS/B, so it's memory bound.
9. b. 300 GFLOPS/250 GB/second = 1.2 FLOPS/B < 1.286 FLOPS/B, so it's compute bound
10. a. BLOCK_WIDTH=1, trivial execution because each tile is of size one, so threadIdx.x and threadIdx.y are both always 0, causing lines 10 and 11 to access the same value and since there's only one thread, there is no race condition. 
10. b. Missing syncthreads() between loading on line 10 and reading on line 11, add it there and it should execute correctly for all values
11. a. i is an automatic non-array variable so it will be in the register of each thread, given there are 8 blocks of 128 threads, 8 * 128 =1,024 versions of i
11. b. Same as a, x[] will be stored in local memory for all 1,024 threads so 1,024 versions.
11. c. y_s is shared so 8 versions between 8 blocks
11. d. same as y_s, 8 versions
11. e. 128 floats * 4 bytes for b_s + 4 bytes for y_s = 516 bytes
11. f. 5 multiplications, 4 additions = 9 FLOPs per thread, 24 bytes of memory accesses (3 times) -> 9/24 = 0.375 OP/B
12. a. 64 threads * 32 blocks =2,048 threads, 2048 * 27 =55,296 registers. Only 4KB of shared memory used per SM so we can achieve full occupancy
12. b. The kernel uses 256 threads/block, 31 registers/thread, and 8 KB of shared memory/SM. 256 * 32 =8,192 threads, we can't fit all of these threads in the SM, but shared memory is fine. We can fit 8 blocks of 2,048 threads though, so we can still achieve full occupancy. 
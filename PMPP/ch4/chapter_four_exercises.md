1. a. 128/32 = 4. 
1. b. What is the number of warps in the grid? 1024 + 128 - 1 =1,151, 1151/128 = 8.992 which gets truncated to 8 as an int. If there are 8 blocks in the grid, and each grid has 4 warps, 8 * 4 = 32
1. c. i. 3 active warps across 8 blocks = 24
1. c. ii. 2 warps across 8 blocks = 16
1. c. iii. 100%
1. c. iv. 25%
1. c. v.  75%
1. d. i. 32
1. d. ii. 32
1. d. iii. 50%
1. e. i. 3
1. e. ii. 2
2. 4 * 512 = 2048
3. One warp 
4. 17.1%
5. No, there's no guarantee the threads will properly synchronize without __syncthreads().
6. c
7. all possible, c, b, and a at 50% occupancy while the rest would be at 100%
8. a. 2048/128 = 16 blocks needed which is fine. Across 2048 threads, we would need 61440 registers which is also fine so yes, full occupancy.
8. b.2048/32 we would need 64 blocks, so we can't achieve full occupancy. There are enough registers here.
8. c. 8 blocks is fine, but roughly 69K registers we don't have enough registers for full occupancy
9. That's impossible. A 32x32 thread block couldn't fit into a CUDA device which only allows 512 threads per block. 
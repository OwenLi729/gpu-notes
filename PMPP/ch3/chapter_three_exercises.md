1c. 2D arrays are usually flattened to be row-major in memory. In RowMulKernel, the P[row*Width + col] fetches consecutive memory addresses (coalesced memory access) which increases the efficiency of memory transactions. However, in ColMulKernel, we iterate the row, which means we're writing with a stride of Width as row increments and this decreases the efficiency of our memory transactions. 
3a. 16 * 32 = 512 threads
3b. 19 * 5 * 512 = 48,640 threads
3c. 19 * 5 = 95 blocks
3d. 150 * 300 = 45,000 threads
4a. 400 * 20 + 10 =8,010
4b. 500 * 10 + 20 = 5,020
5. 1,000,000 + 8,000 + 10 = 1,008,010

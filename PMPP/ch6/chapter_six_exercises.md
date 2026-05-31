1. See C file 
2. Multiples of 32
3. a. coalesced
3. b. not applicable
3. c. coalesced -- j is the same for all threads at any given point and i is consecutive between consecutive threads
3. d. uncoalesced -- i is different between threads so by multiplying i by 4,  we have strided memory accesses
3. e. not applicable
3. f. not applicable
3. g. coalesced
3. h. not applicable
3. i. uncoalesced -- same as d
4. a. 2 FLOP/8B = 0.25 FLOP/B. Saving the P value is negligible to overall arithmetic intensity
4. b. M and N tiles are both loaded once, containing 32^2 = 1024 floats each, 2048 total. Each float is 4 bytes, so 8192 bytes is for the total global load. 2 FLOP line 24 looped over TILE_WIDTH = 32 is 64 FLOPs per-thread. Assuming block width is identical to tile width, this would give 1024 threads per block, so 1024 * 64 = 65536 FLOPs per phase. 65536 FLOP/8192B = 8 FLOP/B.
4. c. Each phase: 4B to load into Mds, then we load Nds COARSE_FACTOR number of times, so 4B * 4 = 16B. Finally, we save the COARSE_FACTOR P values, so 4B * 4 = 16B, but this only happens once after all tile phases complete, so this is negligible. Overall: 16B + 4B = 20 bytes in global memory accesses. For floating point operations, there's 2 on line 36, conducted TILE_WIDTH * COARSE_FACTOR = 2 * 4 * 32 = 256. 256/20 = 12.8 OP/B 




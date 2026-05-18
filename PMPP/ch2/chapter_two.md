# CHAPTER TWO
## Programming Massively Parallel Processors, 4th Edition by Wen-mei W. Hwu, David B. Kirk, Izzat El Hajj

- Data Parallelization: when computations on different parts of the dataset can be done in parallel/independently
- Cuda C is structured for a host(CPU) and one or more devices(GPU). Each source file can have a mixture of host & device code, device code can be added to any source file
- Device code includes clearly marked functions or *kernels* whose code is executed in a data-parallel manner.
- Execution: starts with host code, when the kernel is called, many threads are launched on the GPU to execute it. these threads are collectively referred to as a grid and enable parallel execution.
- The grids are organized into thread blocks, each block is of the same size. 
- The number of threads in a block can be accessed with the built in variable blockDim, & specified by the host when the kernel is called
- Structure: threads -> blocks -> grids
- Other built in variables: threadIdx & blockIdx, self explanatory.
- See Fig 2.11 in textbook for __global__, __host__, and __device__ semantics
- When executing in parallel, we need to first modify the function:
1. Allocate device memory to hold variables
2. Call the kernels
3. Copy result from device memory to host memory & deallocate variables from device memory
- The following functions in CUDA are used to do this: cudaMalloc() allocates object in device global memory. cudaFree() frees object from device memory. cudaMemCpy() performs memory data transfer. See CUDA docs for parameters and details.
- Calling Kernel Functions: <<<x, y>>> where x is the number of blocks, y the number of threads per block
- NVCC compiles CUDA C code into binary PTX files and executes on device. Host code is comoiled by standard C compilers
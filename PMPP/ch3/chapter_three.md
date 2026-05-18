# CHAPTER THREE
## Programming Massively Parallel Processors, 4th Edition by Wen-mei W. Hwu, David B. Kirk, Izzat El Hajj

### Recap:
- Threads are organized into blocks which are organized into grids
- A kernel is a __global__ function that, when called with <<<gridDim, blockDim>>>, launches a grid of threads on the GPU. Then, a scheduler processes the blocks that compose the grid.
- So, each kernel launches a grid of threads, and that singular grid is composed of many blocks of threads.
- __device__ and __host__ functions are executed by the GPU and CPU threads (respectively) that called them
- We can access the dimensions of the grids and blocks using gridDim and blockDim built in variables
### Start:
- Execution configuration parameters are all of type dim3 (x,y,z)
- But vecAddKernel allows us to pass in int or float parameters and CUDA handles the conversion
- Choice of 1D, 2D, or 3D thread organizations should be based on data modality
- Example: pictures are a 2D array of pixels, using a 2D grid consisting of 2D blocks is very convenient
- Example: for a 62x76 picture, we can arrange a 2D grid to use 16x16 blocks, which will cover the picture but generate 64x80 threads. To prevent the excess 24 threads from taking effect, we simply use an if statement to test whether the thread’s vertical and horizontal indices fall within the valid range of pixels.
- To process a 1500×2000 (3-million-pixel) picture, the grid would generate 11,750 blocks: 94 in the y direction and 125 in the x direction. Within the kernel function, references to gridDim.x, gridDim.y, blockDim.x, and blockDim.y will result in 125, 94, 16, and 16, respectively.
- In ANSI C, we would like to access 2D arrays like array[i][j], but CUDA C (which inherits this issue from ANSI C) requires the number of columns to be known at compile time for us to access [i][j] in such a fashion, so we flatten the 2D array into an equivalent 1D array to allow for easy access.
- A memory space is a per-application view of memory where each byte-sized location has a unique address. Multi-byte variables like floats occupy consecutive byte locations, accessed via a starting address and byte count.
- Modern memory spaces are "flat" in the sense that every location has exactly one address in a single linear range. This is why all multidimensional arrays are ultimately stored as 1D arrays under the hood. When you use array[i][j] syntax in C, the compiler is just translating that into a base pointer plus a 1D offset — the flat memory model doesn't natively understand dimensions.
- To linearize a 2D array, we can use two methods:
1. Row-major layout: place all elements of the same row into consecutive locations, then place the rows one after another in memory space. 
2. Column major layout: used by FORTRAN compilers. Basically the transposed form of the row-major layout. 
- These are necessary for the colorToGrayScale and Blur examples in the textbook

### Matrix Multiplication:
-  There are three levels of linear algebra functions:
1. Level 1 functions perform vector operations of the form y=αx+y, where x and y are vectors and α is a scalar
2. Level 2 functions perform matrix-vector operations of the form y=αAx+βy, where A is a matrix, x and y are vectors, and α and β are scalars
3. Level 3 functions perform matrix-matrix operations in the form of C=αAB+βC, where A, B, and C are matrices and α and β are scalars
- To implement matrix multiplication using CUDA, we can map the threads in the grid to the elements of the output matrix P such that each thread is responsible for calculating one element in P. 
- While performing this one-to-one mapping, we make sure to check if row and col are in range similar to the examples mentioned before.
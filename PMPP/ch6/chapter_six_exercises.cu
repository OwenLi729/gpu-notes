%%writefile coalescing.cu
#define TILE_WIDTH 8

__global__ void CoaMatMul(float *A, float *B, float *C, int Width) {

  // tiles
  __shared__ float Ads[TILE_WIDTH][TILE_WIDTH];
  __shared__ float Bds[TILE_WIDTH][TILE_WIDTH];

  // identify row and col of the thread we're working on
  int row = blockIdx.y * blockDim.y + threadIdx.y;
  int col = blockIdx.x * blockDim.x + threadIdx.x;

  // loop over A and B tiles and load
  float C_value = 0.0f;
  for (unsigned int i = 0; i < Width / TILE_WIDTH; ++i) {
    // load A tile, B tile with corner turning
    Ads[threadIdx.y][threadIdx.x] =
        A[row * Width + i * TILE_WIDTH + threadIdx.x];
    Bds[threadIdx.x][threadIdx.y] =
        B[col * Width + i * TILE_WIDTH + threadIdx.x];
    __syncthreads();

    // compute C values
    for (unsigned int k = 0; k < TILE_WIDTH; ++k) {
      C_value += Ads[threadIdx.y][k] * Bds[k][threadIdx.x];
    }

    __syncthreads();
  }

  if (row < Width && col < Width) {
    C[row * Width + col] = C_value;
  }
}

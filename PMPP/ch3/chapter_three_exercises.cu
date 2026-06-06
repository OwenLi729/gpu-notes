//compiled on google colab, this is just a placeholder that doesn't compile

%%writefile vector_addition.cu

__global__ void RowMulKernel(float* M, float* N, float* P, int Width) {
  int row = blockIdx.y*blockDim.y + threadIdx.y;
  if((row<Width)) {
    int col = 0;
    while(col < Width) {
      float Pvalue = 0;
      for(int k = 0; k < Width; ++k) {
        Pvalue += M[row*Width+k] * N[k*Width+col];
      }
      P[row*Width + col] = Pvalue;
      ++col;
    }
  }
}

__global__ void ColMulKernel(float* M, float* N, float* P, int Width) {
  int col = blockIdx.x*blockDim.x + threadIdx.x;
  if((col<Width)) {
    int row = 0;
    while(row < Width) {
      float Pvalue = 0;
      for(int k = 0; k < Width; ++k) {
        Pvalue += M[row*Width+k] * N[k*Width+col];
      }
      P[row*Width + col] = Pvalue;
      ++row;
    }
  }
}

__global__ void MatVecMul(float* B, float* C, float*A, int Width) {
  int row = blockIdx.y*blockDim.y + threadIdx.y;
  if(row<Width) {
    float Avalue = 0;
    for(int k = 0; k < Width; ++k) {
      Avalue += B[row*Width+k] * C[k];
    }
    A[row] = Avalue;
  }
}
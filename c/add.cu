#include <stdio.h>
// function to add the elements of two arrays
__global__
void add(int n, float *x, float *y)
{
  for (int i = 0; i < n; i++)
      y[i] = x[i] + y[i];
}

int main()
{
  int N = 1000000; // 1M elements

  float *x, *y;
  cudaMallocManaged(&x, N*sizeof(float));
  cudaMallocManaged(&y, N*sizeof(float));
  
  // initialize x and y arrays on the host
  for (int i = 0; i < N; i++) {
    x[i] = 1.0;
    y[i] = 2.0;
  }

  // Run kernel on 1M elements on the CPU
  add<<<1, 1>>>(N, x, y);
  // Wait for GPU to finish before accessing on host
  cudaDeviceSynchronize();

  // Check for errors (all values should be 3.0f)
  float maxError = 0.0;
  for(int i = 0; i < N; i++){
    maxError = fmax(maxError, fabs(y[i]-3.0));
  }
  printf("Max error: %f\n",maxError);

  // Free memory
  cudaFree(x);
  cudaFree(y);

}

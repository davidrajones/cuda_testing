#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// function to add the elements of two arrays
void add(int n, float *x, float *y)
{
  for (int i = 0; i < n; i++)
      y[i] = x[i] + y[i];
}

int main()
{
  int N = 1000000; // 1M elements

  float *x, *y;
  x = malloc(N*sizeof(float));
  y = malloc(N*sizeof(float));
  
  // initialize x and y arrays on the host
  for (int i = 0; i < N; i++) {
    x[i] = 1.0;
    y[i] = 2.0;
  }

  // Run kernel on 1M elements on the CPU
  add(N, x, y);

  // Check for errors (all values should be 3.0f)
  float maxError = 0.0;
  for(int i = 0; i < N; i++){
    maxError = fmaxf(maxError, fabs(y[i]-3.0));
  }
  printf("Max error: %f\n",maxError);

  // Free memory
  free(x);
  free(y);

}

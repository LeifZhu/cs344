#include <stdio.h> 

__global__ void cube(float *d_out, float *d_in){
	int idx = threadIdx.x;
	float f = d_in[idx];
	d_out[idx] = f * f * f;
}

int main(int argc, char **argv){
	const int ARRAY_SIZE = 96;
	const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

	float h_in[ARRAY_SIZE];
	float h_out[ARRAY_SIZE];
	for(int i = 0; i < ARRAY_SIZE; i++){
		h_in[i] = float(i);
	}

	float *d_in, *d_out;
	cudaMalloc((void**) &d_in, ARRAY_BYTES);
	cudaMalloc((void**) &d_out, ARRAY_BYTES);

	cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);
	
	cube<<<1, ARRAY_SIZE>>>(d_out, d_in);

	cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

	for(int i = 0; i < ARRAY_SIZE; i++){
		printf("%f", h_out[i]);
		printf("%c", i % 4 == 3? '\n' : '\t');
	}

	cudaFree(d_in);
	cudaFree(d_out);

	return 0;
}



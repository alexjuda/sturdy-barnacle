#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/generate.h>
#include <thrust/host_vector.h>
#include <thrust/sort.h>

void thrust_example() {
  /* // generate 32M random numbers serially */
  /* thrust::host_vector<int> h_vec(32 << 20); */
  /* std::generate(h_vec.begin(), h_vec.end(), rand); */

  /* // transfer data to the device */
  /* thrust::device_vector<int> d_vec = h_vec; */

  /* // sort data on the device (846M keys per second on GeForce GTX 480) */
  /* thrust::sort(d_vec.begin(), d_vec.end()); */

  /* // transfer data back to host */
  /* thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin()); */

  // generate random data serially
  thrust::host_vector<int> h_vec(100);
  std::generate(h_vec.begin(), h_vec.end(), rand);

  // transfer to device and compute sum
  thrust::device_vector<int> d_vec = h_vec;
  int x = thrust::reduce(d_vec.begin(), d_vec.end(), 0, thrust::plus<int>());
  std::cout << x;
}

int main() {
  thrust::host_vector<int> H(4);

  thrust_example();

  std::cout << "hello!";
  std::cout << std::endl;
  return 0;
}

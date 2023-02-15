#include <iostream>
#include <thrust/host_vector.h>


int main() {
    thrust::host_vector<int> H(4);

    std::cout << "hello!";
    std::cout << std::endl;
    return 0;
}

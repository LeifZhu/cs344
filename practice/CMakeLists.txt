
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)
PROJECT(practice)
INCLUDE(/usr/share/cmake-3.10/Modules/FindCUDA.cmake)


cuda_add_executable(cube cube.cu)

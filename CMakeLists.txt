cmake_minimum_required(VERSION 2.8)
project( OpenCVTest )
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )

add_executable( resizecpu resize_cpu.cpp )
target_link_libraries( resizecpu ${OpenCV_LIBS} )

add_executable( resizegpu resize_gpu.cpp )
target_link_libraries( resizegpu ${OpenCV_LIBS} )

FROM nvidia/cuda:10.1-devel-ubuntu18.04

WORKDIR /build

RUN apt-get update 
RUN apt-get install -y unzip python3 cmake g++ pkg-config libharfbuzz-dev libfreetype6-dev libgtk2.0-dev libeigen3-dev libgoogle-glog-dev

RUN ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so.6
RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen

#COPY vendor/opencv-4.0.1.zip vendor/opencv_contrib-4.0.1.zip /build/
#RUN unzip opencv-4.0.1.zip
#RUN unzip opencv_contrib-4.0.1.zip
ADD vendor/opencv-4.1.1.tar.gz /build/
ADD vendor/opencv_contrib-4.1.1.tar.gz /build/

RUN mkdir -p opencv-4.1.1/build && \
  cd opencv-4.1.1/build/ && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/build/opencv_contrib-4.1.1/modules \
    -D BUILD_EXAMPLES=OFF \
    -D WITH_CUDA=ON \
    -D CMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
    -D BUILD_opencv_cudacodec=OFF \
    -D OPENCV_GENERATE_PKGCONFIG=YES \
    -D PYTHON_EXECUTABLE=/usr/bin/python3 ..

RUN cd opencv-4.1.1/build/ && make -j6
RUN cd opencv-4.1.1/build/ && make install

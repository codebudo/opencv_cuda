#include <stdio.h>
#include <opencv2/opencv.hpp>

using namespace cv;

int main(int argc, char** argv ) {
  if ( argc != 2 ) {
    printf("usage: DisplayImage.out <Image_Path>\n");
    return -1;
  }
  Mat inImage;
  Mat outImage;
  inImage = imread( argv[1], 1 );
  if ( !inImage.data ) {
    printf("No image data \n");
    return -1;
  }

  for(int i=0; i < 100; i++){
    //resize
    //resize(inImage, outImage, Size(), 0.5, 0.5);
    resize(inImage, outImage, Size(640, 480));

    imwrite("output_cpu.jpg", outImage);
  }

  //namedWindow("Display Image", WINDOW_AUTOSIZE );
  //imshow("Display Image", outImage);
  //waitKey(0);
  return 0;
}

# HDR-methods-and-comparisons
HDR imge generation using various state of the art methods and their result comparisons

## HDR image generation using ILP (Inverted Local Patterns) 
based on the paper 
###          "High performance high dynamic range image generation by Inverted Local Patterns" 
         by Shih-Chang Hsia and Ting Tseng Kuo
         IET image processsing, 2015

## Setup
The codes for ILP (Inverted Local Patterns) and CLAHE(Contrast Limited Adaptive Histogram Equalization) is present in MATLAB

## Usage
Copy the code to the path where you have the test images. After running the code, it automatically saves the resultinh HDR image at that same path as that of the code.

We also have provided sample test images in the images folder. The resulting images of these sample images is also provided.

## Comparisons
We have provide the results for the same images for various methods.

In order to get a qualititaive analysis of the images , I recommend using the HDR-VDP and HDR-VDP 2 visual metric.
THese metrics can be accessed from http://hdrvdp.sourceforge.net/.

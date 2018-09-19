% 
% % Code for image contrast enhancement using
% % CLAHE ( Contrast-Limited Adaptive Histogram Equalization)
% 
% 
% % CLAHE for grayscale image
% I = imread('17.jpg'); %input image
% imwrite(I, '17.tiff');
% % img2=imresize(I,[256,256]);%resize image to 256x256 resolution
% % img_ori=img2;
% % img2=rgb2hsv(img2);
% % [x,y,z]=size(img2);
% % img_grey=img2(:,:,3);%convert RGB image to grayscale image
% imhist(I);     %histogram of input image
% 
%  J = adapthisteq(I,'clipLimit',0.02,'Distribution','rayleigh'); %output image 1 
%  imshowpair(I,J,'montage');
% % title('Original Image (left) and Contrast Enhanced Image (right)') 













I = imread('girl.jpg');
img=imresize(I,[256,256]);%resize image to 256x256 resolution
LAB = rgb2lab(img);
L = LAB(:,:,1)/100;
L = adapthisteq(L,'NumTiles',[8 8],'ClipLimit',0.005);
LAB(:,:,1) = L*100;
J = lab2rgb(LAB);

%figure;
%imshow(img);

figure;
imshow(J)



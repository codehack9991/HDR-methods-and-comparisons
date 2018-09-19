%HDR image generation using a single image using Inverted Local Patterns



I=imread('src.jpg');%input image
% LAB = rgb2lab(I);
% L = LAB(:,:,1)/100;
% L = adapthisteq(L,'NumTiles',[8 8],'ClipLimit',0.005);
% LAB(:,:,1) = L*100;
% img = lab2rgb(LAB);
img2=imresize(I,[256,256]);%resize image to 256x256 resolution

[x,y,z]=size(img2);

img_grey=rgb2gray(img2);%convert RGB image to grayscale image

[hist,o]=imhist(img_grey);%hist represents luminicance histogram

HB=0;%HB value of original image

for i=1:1:256

    HB=HB+abs(hist(i)-256);

end



% here we set some thresholds th1,th2,th3,th4 and thdark

th1=16;

th2=51;

th3=206;

th4=241;

thdark=0;



%Now we calculate values of 'low' and 'high'.

%These will determine whether original image is dark,bright,extreme or

%normal.

low=0;

high=0;

for i=1:1:th1-1

    low=low+hist(i)*2;

end



for i=th1:1:th2-1

    low=low+hist(i);

end



for i=th3:1:th4-1

    high=high+hist(i);

end



for i=th4:1:256

    high=high+hist(i)*2;

end



if low>high*2

    thdark=100; %dark image

elseif high>low*2

    thdark=0;   %bright image

elseif high/low<=2 && high/low>=0.5

    thdark=50;  %extreme image

else

    return; %original image is already HDR

end



%Here we apply 2x2 maximum fill on the original image

blk=[2,2];

fun = @(s)max(s.data(:))*ones(blk,class(s.data));

img_max=blockproc(img_grey,blk,fun); %img_max is the 2x2 maximum filled image  



%Here we apply a 3x3 low pass on img_max

img_low = imfilter(img_max,fspecial('average',[3 3]));



%Now we apply inverse operation on img_low

%After the inverse operation, bright regions become dark and dark regions

%become bright

img_inv=img_low;

for i=1:1:x

    for j=1:1:y

        p=double(255-img_low(i,j));

        p=p*p;

        img_inv(i,j)=p/255;

    end

end



%Dark enhancement

%Here we brighten the darker regions of the original image 

%If pixel value is less than thdark,then we increase its brightness

%Otherwise it remains same

img_dark=img_grey;

for i=1:1:x

    for j=1:1:y

        if img_grey(i,j)<thdark

            temp=double(img_grey(i,j))+double((thdark-img_grey(i,j))*0.072);

            img_dark(i,j)=temp;

        else

            img_dark(i,j)=img_grey(i,j);

        end

    end

end



%Mixing operation

%Here we mix the results of inverse operation and dark enhancement

%We use a parameter k which depends on type of image.

%More the darkness,more the value of k and vice-versa.

k=1.82*power(10,-8)*low+0.009;

img_mix=img_dark;

for i=1:1:x

    for j=1:1:y

        temp=double(img_dark(i,j))*double(img_inv(i,j));

        temp=temp*k;

        img_mix(i,j)=temp;

    end

end



%Brightness enhancement

%Here we increase brightness of img_mix to get our HDR image

%We set a threshold thb for brightness enhancement

%If pixel value is greater than thdb,then we increase its brightness

%Otherwise it remains same

thb=50;

img_hdr=img_mix;

for i=1:1:x

    for j=1:1:y

        if img_dark(i,j)>=thb

            p=double(img_dark(i,j)-thb);

            p=p*p;

            p=p*0.0068;

            img_hdr(i,j)=img_mix(i,j)+p;

        else

            img_hdr(i,j)=img_mix(i,j);

        end

    end

end



[hist_hdr,o1]=imhist(img_hdr);%hist_hdr represents luminicance histogram of HDR image

HB1=0;%HB value of output image

for i=1:1:256

    HB1=HB1+abs(hist_hdr(i)-256);

end



%Newly included part

%img_hdr2=imsharpen(img_hdr);

%[hist_hdr2,o3]=imhist(img_hdr2);

%HB2=0;

%for i=1:1:256

    %HB2=HB2+abs(hist_hdr2(i)-256);

%end





img_des0=imread('res.jpg');%Proposed image

img_des=imresize(img_des0,[256,256]);

img_des=rgb2gray(img_des);

[hist_hdr2,o2]=imhist(img_des);%hist_hdr2 represents luminicance histogram of Proposed image

HB3=0;%HB value of proposed image

for i=1:1:256

    HB3=HB3+abs(hist_hdr2(i)-256);

end



%Finally we display original image,output image and proposed image for

%comparison

figure;

imshow(img_grey)

figure;

imshow(img_hdr)

figure;

imshow(img_des)

figure;

imhist(img_grey(:,:,1))

figure;

imhist(img_hdr(:,:,1))

figure;

imhist(img_des(:,:,1))
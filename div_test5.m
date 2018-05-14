%基于最大方差法灰度门限的图像分割
I = imread('baihe.jpg');
img = rgb2gray(I);
T = thresh_md(img);
im = im2bw(img,T/255);
subplot(1,2,1),imshow(I)
subplot(1,2,2),imshow(im)
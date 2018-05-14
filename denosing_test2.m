im = imread('wangshi.jpg');
img = rgb2gray(im);
[m,n] = size(img);
Inoise = imnoise(img,'speckle',0.01);
%DCT±ä»»
A = dct2(Inoise);
I = zeros(m,n);
%¸ßÆµÆÁ±Î
I(1:m/3,1:n/3) = 1;
Ydct = A.*I;
%ÄæDCT±ä»»
Y = uint8(idct2(Ydct));

subplot(131),imshow(im)
subplot(132),imshow(Inoise)
subplot(133),imshow(Y)
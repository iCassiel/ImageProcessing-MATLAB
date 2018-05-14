%get image
im = imread('life.jpg');
im = rgb2gray(im);
subplot(2,2,1),imshow(im),title('original image')
%add noise
im = double(im);
X = size(im);
im = im + randn(X);
subplot(2,2,2),imshow(im,[]),title('noise image')
%wave decomposition
[c,s] = wavedec2(im,2,'coif2');
n = [1,2];
%threshold processing
p = [10,4]; %设置阈值向量
nc = wthcoef2('v',c,s,n,p,'s');
%first restructure
I = waverec2(nc,s,'coif2');
subplot(2,2,3),imshow(I,[]),title('first restructure')
%second restructure
[c,s] = wavedec2(I,2,'coif2');
nc = wthcoef2('v',c,s,n,p,'s');
I2 = waverec2(nc,s,'coif2');
subplot(2,2,4),imshow(I2,[]),title('second restructure')

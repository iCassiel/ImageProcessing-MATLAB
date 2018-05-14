load bust
X1 = X;
map1 = map;
subplot(1,3,1),image(X1);
colormap(map1),title('original image');
axis square

load mask
X2 = X;
map2 = map;
subplot(1,3,2),image(X2);
colormap(map),title('image2');
axis square

%基于拉普拉斯金字塔变换的图像融合
i1 = imread('clock1.bmp');
i1 = double(i1);
i2 = imread('clock2.bmp');
i2 = double(i2);
y = fuse_lap(i1,i2,2,1,3);
subplot(131),imshow(i1,[])
subplot(132),imshow(i2,[])
subplot(133),imshow(y,[])
[c1,s1] = wavedec2(X1,2,'sym4');
[c2,s1] = wavedec2(X2,2,'sym4');

c = c1+c2;
c = 0.5*c;
s = s1+s2;
s = 0.5*s;

Im = waverec2(c,s,'sym4');
subplot(1,3,3),image(Im),title('final image');
axis square

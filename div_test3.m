A = imread('moli.jpg');
T = graythresh(A);
img = im2bw(A,T);
subplot(121),imshow(A)
subplot(122),imshow(img)

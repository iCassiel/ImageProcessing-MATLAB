A = imread('baihe.jpg');
im = rgb2gray(A);
T = 0.5 * (double(min(im(:)))+double(max(im(:))));
d = false;
while ~d
    g = im >=T;
    Tn = 0.5 * (mean(im(g))+mean(im(~g)));
    d = abs(T-Tn)>0;
    T =Tn;
end
level = Tn/255;
img = im2bw(im,level);
subplot(121),imshow(A)
subplot(122),imshow(img)
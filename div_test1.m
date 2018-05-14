im = imread('hehua.JPG');
im1 = rgb2gray(im);
h = double(im1);
hist(h)
[n,m] = size(h);

for i = 1:n
    for j = 1:m
        if h(i,j)>70&h(i,j)<130
            h(i,j) = 1;
        else h(i,j) = 0;
        end
    end
end
subplot(121),imshow(im1)
subplot(122),imshow(h)


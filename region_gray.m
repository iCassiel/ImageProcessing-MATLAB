function P = region_gray(img,r)
         %功能：计算局部灰度概率
         %img_—输入图像；r—局域半径
         %P—局部灰度概率矩阵
if size(size(img),2) == 3
    img = rgb2gray(img);
end
[m,n] = size(img);
local_region = zeros(2*r+1,2*r+1);
%计算局部灰度概率
for i = r+1:m-r
    for j = r+1:n-r
    local_region = img(i-r:i+r,j-r:j+r);
    P(i,j) = img(i,j)/sum(sum(local_region));
    end
end




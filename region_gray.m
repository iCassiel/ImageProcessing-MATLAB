function P = region_gray(img,r)
         %���ܣ�����ֲ��Ҷȸ���
         %img_������ͼ��r������뾶
         %P���ֲ��Ҷȸ��ʾ���
if size(size(img),2) == 3
    img = rgb2gray(img);
end
[m,n] = size(img);
local_region = zeros(2*r+1,2*r+1);
%����ֲ��Ҷȸ���
for i = r+1:m-r
    for j = r+1:n-r
    local_region = img(i-r:i+r,j-r:j+r);
    P(i,j) = img(i,j)/sum(sum(local_region));
    end
end




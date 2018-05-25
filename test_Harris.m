%读取图像
img = imread('long.jpg');
img = rgb2gray(img);
imshow(img)
or_img = double(img);
%计算两个方向的梯度
fx = [-1 0 1];
Ix = filter2(fx,or_img);
Iy = filter2(fx',or_img);
%计算图像两个方向梯度的乘积
Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;
%使用高斯函数对以上三值进行高斯加权，生成M的元素A、B、C
h = fspecial('Gaussian',[7 7],2);
A = filter2(h,Ix2);
B = filter2(h,Iy2);
C = filter2(h,Ixy);
%计算每个像元的Harris响应值R，并对小于某一阈值的R置零
[m n] = size(or_img);
R = zeros(m,n);% 首先，要定义出R
for i = 1:m
    for j = 1:n
        M = [A(i,j) B(i,j)
             B(i,j) C(i,j)];
        R(i,j) = det(M) - 0.06 * (trace(M))^2;
    end
end
%对小于某一阈值的R置零
thre = 0.01 * max(max(R));
for i = 1:m
    for j = 1:n
        if R(i,j) < thre
            R(i,j) = 0;
        end
    end
end
%在3*3或5*5邻域内进行非极大值抑制,本例为3*3（对于该部分不太理解）
corner_peaks = imregionalmax(R);
countnum = sum(sum(corner_peaks));
%显示角点
[posr,posc] = find(corner_peaks == 1);
figure,imshow(img)
hold on 
for i = 1:length(posr)
    plot(posc(i),posr(i),'r+');
end
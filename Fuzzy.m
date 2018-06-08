img = imread('lena.bmp');
img1 = double(img);
[m,n] = size(img);

%图像模糊特征提取
Fe = 1;
Fd = 120;%设置变换系数Fe,Fd
gmax = double(max(img(:)));%%该步骤是实现过程中遇到的问题，开始gmax = max(img(;)),致使Line15报错：错误使用 ^ ，整数只能提升为正整数幂。
%实现二：gmax = max(max(img1));%图像中最大灰度值

%通过变换将图像从空间域变换到模糊域
for i = 1:m
    for j = 1:n
        G(i,j) = (1 + (gmax - img1(i,j))/Fd)^(-Fe);
        %隶属度函数值修正
        if G(i,j) <= 0.5
            G(i,j) = 2 * G(i,j)^2;
        else
            G(i,j) = 1 - 2 * (1-G(i,j))^2;
        end 
    end 
end
%实现二：G = (1 + (gmax - img1)/Fd).^(-Fe);

%模糊域反变换
for i = 1:m
    for j = 1:n
        I(i,j) = gmax - Fd*((G(i,j))^(-1/Fe)-1);
    end 
end
%实现二：I = gmax - Fd.*(G.^(-1/Fe)-1);
imshow(img)
figure,imshow(uint8(I))
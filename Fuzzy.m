img = imread('lena.bmp');
img1 = double(img);
[m,n] = size(img);

%ͼ��ģ��������ȡ
Fe = 1;
Fd = 120;%���ñ任ϵ��Fe,Fd
gmax = double(max(img(:)));%%�ò�����ʵ�ֹ��������������⣬��ʼgmax = max(img(;)),��ʹLine15��������ʹ�� ^ ������ֻ������Ϊ�������ݡ�
%ʵ�ֶ���gmax = max(max(img1));%ͼ�������Ҷ�ֵ

%ͨ���任��ͼ��ӿռ���任��ģ����
for i = 1:m
    for j = 1:n
        G(i,j) = (1 + (gmax - img1(i,j))/Fd)^(-Fe);
        %�����Ⱥ���ֵ����
        if G(i,j) <= 0.5
            G(i,j) = 2 * G(i,j)^2;
        else
            G(i,j) = 1 - 2 * (1-G(i,j))^2;
        end 
    end 
end
%ʵ�ֶ���G = (1 + (gmax - img1)/Fd).^(-Fe);

%ģ���򷴱任
for i = 1:m
    for j = 1:n
        I(i,j) = gmax - Fd*((G(i,j))^(-1/Fe)-1);
    end 
end
%ʵ�ֶ���I = gmax - Fd.*(G.^(-1/Fe)-1);
imshow(img)
figure,imshow(uint8(I))
%��ȡͼ��
img = imread('long.jpg');
img = rgb2gray(img);
imshow(img)
or_img = double(img);
%��������������ݶ�
fx = [-1 0 1];
Ix = filter2(fx,or_img);
Iy = filter2(fx',or_img);
%����ͼ�����������ݶȵĳ˻�
Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;
%ʹ�ø�˹������������ֵ���и�˹��Ȩ������M��Ԫ��A��B��C
h = fspecial('Gaussian',[7 7],2);
A = filter2(h,Ix2);
B = filter2(h,Iy2);
C = filter2(h,Ixy);
%����ÿ����Ԫ��Harris��ӦֵR������С��ĳһ��ֵ��R����
[m n] = size(or_img);
R = zeros(m,n);% ���ȣ�Ҫ�����R
for i = 1:m
    for j = 1:n
        M = [A(i,j) B(i,j)
             B(i,j) C(i,j)];
        R(i,j) = det(M) - 0.06 * (trace(M))^2;
    end
end
%��С��ĳһ��ֵ��R����
thre = 0.01 * max(max(R));
for i = 1:m
    for j = 1:n
        if R(i,j) < thre
            R(i,j) = 0;
        end
    end
end
%��3*3��5*5�����ڽ��зǼ���ֵ����,����Ϊ3*3�����ڸò��ֲ�̫��⣩
corner_peaks = imregionalmax(R);
countnum = sum(sum(corner_peaks));
%��ʾ�ǵ�
[posr,posc] = find(corner_peaks == 1);
figure,imshow(img)
hold on 
for i = 1:length(posr)
    plot(posc(i),posr(i),'r+');
end
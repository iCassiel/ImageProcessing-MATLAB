close all;  
clear all;  
clc;  
  
C_Segments=2;  
  
img_original = imread('shuixian.jpg');%����ͼ��  
subplot(2,2,1),imshow(img_original),title('ԭʼͼ��');    %��ʾԭͼ��  
img_gray=rgb2gray(img_original);  
subplot(2,2,2),imshow(img_gray),title('ԭʼ�Ҷ�ͼ��');  
  
% ��ȡͼ��ĳ���  
[m,n]=size(img_gray);  
  
% �Ҷ���ֵ����  
T=graythresh(img_gray);  
img_bw=im2bw(img_gray,T);  
subplot(2,2,3),imshow(img_bw),title('ԭʼ��ֵͼ��');  
  
% ��ͼ�����RGB����3ͨ���ֽ�  
A = reshape(img_original(:, :, 1), m*n, 1);    % ��RGB������תΪkmeansʹ�õ����ݸ�ʽn�У�һ��һ����  
B = reshape(img_original(:, :, 2), m*n, 1);  
C = reshape(img_original(:, :, 3), m*n, 1);  
dat = [A B C];  % r g b�������������������ÿ����������������ֵ����width*height������  
cRGB = kmeans(double(dat), C_Segments);    % ʹ�þ����㷨��Ϊ2��  
rRGB = reshape(cRGB, m, n);     % ����ת��ΪͼƬ��ʽ  
figure, imshow(label2rgb(rRGB)),title('RGBͨ���ָ���');   % ��ʾ�ָ���  
  
  
% ��ͼ����е�һͨ���Ҷȷֽ�  
GraySeg= reshape(img_gray(:, :), m*n, 1);  
cGray=kmeans(double(GraySeg), 2);  
rGray= reshape(cGray, m, n);     % ����ת��ΪͼƬ��ʽ  
figure, imshow(label2rgb(rGray)),title('�Ҷ�ͨ���ָ���');   % ��ʾ�ָ��� 
clear all; 
clc;
start_time=cputime;
%%%%%% 读取水印图像 %%%%%%
I=imread('mark.bmp');
I=rgb2gray(I);
I=double(I)/255; 
I=ceil(I);
%%%%%%显示水印图像%%%%%%
figure(1);
subplot(2,3,1);
imshow(I),title('水印图像')
dimI=size(I);
rm=dimI(1);cm=dimI(2);
%%%%%%以下生成水印信息 %%%%%%
mark=I;
alpha=50,
k1=randn(1,8);
k2=randn(1,8);
a0=imread('lena.bmp');
psnr_cover=double(a0);
subplot(2,3,2),imshow(a0,[]),title('载体图像');
[r,c]=size(a0);
cda0=blkproc(a0,[8,8],'dct2');
%%%%%% 嵌入 %%%%%%
cda1=cda0;   % cda1 = 256_256
for i=1:32 % i=1:32
    for j=1:32  % j=1:32 载体图像为256_256 i,j最大值不能超过32，否则，line35将超出矩阵维度
        x=(i-1)*8;y=(j-1)*8;
        if mark(i,j)==1
        k=k1;
        else
        k=k2; 
        end
    cda1(x+1,y+8)=cda0(x+1,y+8)+alpha*k(1);
    cda1(x+2,y+7)=cda0(x+2,y+7)+alpha*k(2);
    cda1(x+3,y+6)=cda0(x+3,y+6)+alpha*k(3);
    cda1(x+4,y+5)=cda0(x+4,y+5)+alpha*k(4);
    cda1(x+5,y+4)=cda0(x+5,y+4)+alpha*k(5);
    cda1(x+6,y+3)=cda0(x+6,y+3)+alpha*k(6);
    cda1(x+7,y+2)=cda0(x+7,y+2)+alpha*k(7);
    cda1(x+8,y+1)=cda0(x+8,y+1)+alpha*k(8);
    end
end
%%%%%%嵌入水印后图像 %%%%%%
%f = @(block)replace(dct2(block.data));  存在问题：未定义与 'double' 类型的输入参数相对应的函数 'replace'
%a1 =replace(blockproc(cda1,[8,8],f));
a1=blkproc(cda1,[8,8],'idct2'); 
a_1=uint8(a1);
imwrite(a_1,'withmark.bmp','bmp');
subplot(2,3,3),imshow(a1,[]),title('嵌入水印后的图像');
disp('嵌入水印处理时间');
embed_time=cputime-start_time,
%%%%%% 攻击实验 测试鲁棒性 %%%%%%%
disp('对嵌入水印的图像的攻击实验，请输入选择项：');
disp('1--添加白噪声');
disp('2--高斯低通滤波');
disp('3--JPEG 压缩');
disp('4--图像剪切');
disp('5--旋转10度');
disp('6--直接检测水印');
disp('其他--不攻击');
d=input('请输入选择（1-6）:');
start_time=cputime;
    figure(1);
            switch d
                case 6
            subplot(2,3,4);
            imshow(a1,[]);
            title('未受攻击的含水印图像');
            M1=a1;                      
                case 1
             WImage2=a1;
             noise0=20*randn(size(WImage2));
             WImage2=WImage2+noise0;
             subplot(2,3,4);
             imshow(WImage2,[]);
             title('加入白噪声后图像');
             M1=WImage2;
             M_1=uint8(M1);
             imwrite(M_1,'whitenoise.bmp','bmp');
                case 2
             WImage3=a1;
             H=fspecial('gaussian',[4,4],0.2);
             WImage3=imfilter(WImage3,H);
             subplot(2,3,4);
             imshow(WImage3,[]);
             title('高斯低通滤波后图像');
             M1=WImage3;
             M_1=uint8(M1);
             imwrite(M_1,'gaussian.bmp','bmp');
                case 4
             WImage4=a1;
             WImage4(1:64,1:512)=512;
             %WImage4(224:256,1:256)=256;
             %WImage4(1:256,224:256)=256;
             %WImage4(1:256,1:32)=256;
             WImage4cl=mat2gray(WImage4);
             figure(2);
             subplot(1,1,1);
             %subplot(2,3,4);
             imshow(WImage4cl);
             title('部分剪切后图像');
             figure(1);
             M1=WImage4cl;
             %M_1=uint8(M1);
             %imwrite(M_1,'cutpart.bmp','bmp');
                case 3
             WImage5=a1;
             WImage5=im2double(WImage5);
             cnum=10;
             dctm=dctmtx(8);
             P1=dctm;
             P2=dctm.';
             imageDCT=blkproc(WImage5,[8,8],'P1*x*P2',dctm,dctm.');
             DCTvar=im2col(imageDCT,[8,8],'distinct').';
             n=size(DCTvar,1);
             DCTvar=(sum(DCTvar.*DCTvar)-(sum(DCTvar)/n).^2)/n;
             [dum,order]=sort(DCTvar);
             cnum=64-cnum;
             mask=ones(8,8);
             mask(order(1:cnum))=zeros(1,cnum);
             im88=zeros(9,9);
             im88(1:8,1:8)=mask;
             im128128=kron(im88(1:8,1:8),ones(16));
             dctm=dctmtx(8);
             P1=dctm.';
             P2=mask(1:8,1:8);
             P3=dctm;
WImage5=blkproc(imageDCT,[8,8],'P1*(x.*P2)*P3',dctm.',mask(1:8,1:8),dctm);
             WImage5cl=mat2gray(WImage5);
             subplot(2,3,4);
             imshow(WImage5cl);
             title('经JPEG压缩后图像');
             %figure(1);
             M1=WImage5cl;
                case 5
            WImage6=a1;
            WImage6=imrotate(WImage6,10,'bilinear','crop');
            WImage6cl=mat2gray(WImage6);
            figure(2);
            subplot(1,1,1);
            imshow(WImage6cl);
            title('旋转10度后图像');  
            figure(1);
            M1=WImage6cl;
                  otherwise
            disp('你输入的是无效数字，图像未受攻击，将直接检测水印');
            subplot(2,3,4);
            imshow(a1,[]);
            title('未受攻击的含水印图像');
            M1=a1;
                end


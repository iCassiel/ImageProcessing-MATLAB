img = 0.6*ones(128,128);
img(80,90) = 256;
img(100,100) = 256;
imshow(img)
%计算序列图像各像素点得局部灰度概率，得到该幅图像得局部概率分布图；
r = 2;
P = region_gray(img,r);
figure
mesh(P)
%提取图像中得孤立奇异点
[Pr,Pc] = find(P>1/(2*r+1)^2);
figure
imshow(img)
hold on
for i = 1:length(Pc)
  %plot(Pr(i),Pc(i),'g+')
  plot(Pc(i),Pr(i),'g+')
end
hold on 
img2 = 0.6*ones(128,128);
img2(81,90) = 256;
img2(200,200) = 256;
%检查上一帧图像奇异点附近是否存在奇异点
P2 = region_detect(Pr,Pc,img2,1);
[Pr2,Pc2] = find(P>1/(2*1+1)^2);
for i = 1:length(Pct)
    %plot(Pr2(i),Pc2(i),'ro')
    plot(Pc2(i),Pr2(i),'ro')
end

    

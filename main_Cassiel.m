img = 0.6*ones(128,128);
img(80,90) = 256;
img(100,100) = 256;
imshow(img)
%��������ͼ������ص�þֲ��Ҷȸ��ʣ��õ��÷�ͼ��þֲ����ʷֲ�ͼ��
r = 2;
P = region_gray(img,r);
figure
mesh(P)
%��ȡͼ���еù��������
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
%�����һ֡ͼ������㸽���Ƿ���������
P2 = region_detect(Pr,Pc,img2,1);
[Pr2,Pc2] = find(P>1/(2*1+1)^2);
for i = 1:length(Pct)
    %plot(Pr2(i),Pc2(i),'ro')
    plot(Pc2(i),Pr2(i),'ro')
end

    

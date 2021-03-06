% 2.4 彩色图像的直方图均衡化
clc;
clear;
input_img = imread('hw4_input/task_3/16.png');
[M,N,C] = size(input_img);
input_img = im2double(input_img);
R = input_img(:,:,1);
G = input_img(:,:,2);
B = input_img(:,:,3);
% =======================================================================================================
% 2.4.1 
% 1.分别对RGB三个通道进行直方图均衡化
% 2.将处理后的三通道重构成一张RGB图
% -------------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', '2.4.1 分别对RGB三个通道进行直方图均衡化');
% 1.分别对RGB三个通道进行直方图均衡化
equalize_R1 = equalize_hist(R);
equalize_G1 = equalize_hist(G);
equalize_B1 = equalize_hist(B);
subplot(2,2,1);
imshow(equalize_R1);
title('equalize R1');
subplot(2,2,2);
imshow(equalize_G1);
title('equalize G1');
subplot(2,2,3);
imshow(equalize_B1);
title('equalize B1');
imwrite(equalize_R1, '.\hw4_output\2.4.1_RGB_Equalize\equalize_R1.png');
imwrite(equalize_G1, '.\hw4_output\2.4.1_RGB_Equalize\equalize_G1.png');
imwrite(equalize_B1, '.\hw4_output\2.4.1_RGB_Equalize\equalize_B1.png');
% 2.将处理后的三通道重构成一张RGB图
output_img1(:,:,1) = equalize_R1;
output_img1(:,:,2) = equalize_G1;
output_img1(:,:,3) = equalize_B1;
subplot(2,2,4);
imshow(output_img1);
title('outputimg1');
imwrite(output_img1, '.\hw4_output\2.4.1_RGB_Equalize\output_img1.png');
% =======================================================================================================
% 2.4.2 
% 1. 分别计算每一个通道的直方图
% 2. 对这三个直方图取平均值得到一个平均直方图
% 3. 对这个直方图做均衡化
% 4. 把平均直方图均衡化前后的像素值映射关系应用到RGB三个通道
% 5. 再重构一张RGB图
% -------------------------------------------------------------------------
% 1. 分别计算每一个通道的直方图
Pr_R = pr_256(R);
figure('NumberTitle', 'off', 'Name', '2.4.2-1 分别计算每一个通道的直方图，求平均直方图');

subplot(2,2,1);
bar(0:255, Pr_R, 'r'); % R概率密度直方图
title('R histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold on
Pr_G = pr_256(G);
subplot(2,2,2);
bar(0:255, Pr_G, 'g'); % G概率密度直方图
title('G histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold on
Pr_B = pr_256(B);
subplot(2,2,3);
bar(0:255, Pr_B, 'b'); % B概率密度直方图
title('B histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold on
% 2. 对这三个直方图取平均值得到一个平均直方图
for i = 1:256
    Pr_average(i) = (Pr_R(i)+Pr_G(i)+Pr_B(i))/3;
end
subplot(2,2,4);
bar(0:255, Pr_average,'k'); % 平均概率密度直方图
title('average histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold off
% 3. 对这个直方图做均衡化
Sk = zeros(1,256);
for i = 1:256
    for j = 1:i
        Sk(i) = Sk(i)+Pr_average(j);
    end
    Sk(i) = Sk(i) * 255;
end
approx_Sk = round(Sk); %近似为最接近的整数，得到均衡后直方图的值
newPr = zeros(1,256);
for i = 1:256
    for j = 1:256
        if approx_Sk(j) == i
            newPr(i) = Pr_average(j)+ newPr(i);
        end
    end
end
figure('NumberTitle', 'off', 'Name', '2.4.2-2 平均直方图的直方图均衡化结果');
bar(0:255,newPr,'k');
title('average equlized histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);

% 4. 把平均直方图均衡化前后的像素值映射关系应用到RGB三个通道

equalize_R2 = round((double(R)*255));
equalize_G2 = round((double(G)*255));
equalize_B2 = round((double(B)*255));
saveR = equalize_R2;
saveG = equalize_G2;
saveB = equalize_B2;
for i = 0:255
    %把原图中像素点灰度值为i的由转换函数转为均衡后灰度值
    index1 = find(saveR == i);
    equalize_R2(index1) = approx_Sk(i+1);
    index2 = find(saveG == i);
    equalize_G2(index2) = approx_Sk(i+1);
    index3 = find(saveB == i);
    equalize_B2(index3) = approx_Sk(i+1);
end
equalize_R2 = double(equalize_R2./255);
equalize_G2 = double(equalize_G2./255);
equalize_B2 = double(equalize_B2./255);

figure('NumberTitle', 'off', 'Name', '2.4.2-3 三通道分别对应变换和重构RGB图结果');
subplot(2,2,1);
imshow(equalize_R2);
title('equalize R2');
imwrite(equalize_R2, '.\hw4_output\2.4.2_RGB_average_Equalize\equalize_R2.png');
subplot(2,2,2);
imshow(equalize_G2);
title('equalize G2');
imwrite(equalize_G2, '.\hw4_output\2.4.2_RGB_average_Equalize\equalize_G2.png');
subplot(2,2,3);
imshow(equalize_B2);
title('equalize B2');
imwrite(equalize_B2, '.\hw4_output\2.4.2_RGB_average_Equalize\equalize_B2.png');
% 5. 再重构一张RGB图
output_img2(:,:,1) = equalize_R2;
output_img2(:,:,2) = equalize_G2;
output_img2(:,:,3) = equalize_B2;
subplot(2,2,4);
imshow(output_img2);
title('output img2');
imwrite(output_img2, '.\hw4_output\2.4.2_RGB_average_Equalize\output_img2.png');
% =======================================================================================================
% 2.4.3
% 1. 将输入图片转到HSV色彩空间
% 2. 对强度（intensity）进行直方图均衡化
% 3. 将处理后的结果转换到RGB色彩空间
% -------------------------------------------------------------------------
% 1. 将输入图片转到HSV色彩空间
R = im2double(R);
G = im2double(G);
B = im2double(B);

H = double(zeros(M,N));
S = zeros(M,N);
I = zeros(M,N);

for i = 1:M
    for j = 1:N
        r = R(i,j);
        g = G(i,j);
        b = B(i,j);
        item = [r,g,b];
        x1 = ((r-g)+(r-b))/2;
        x2 = sqrt((r-g)^2 + (r-b)*(g-b));
        H(i,j) = acos(x1/x2);
        if b > g
            H(i,j) = 2*pi - H(i,j);
        end
        H(i,j) = H(i,j)/(2*pi);
        S(i,j) = 1 - (3*min(item)/sum(item));
        I(i,j) = (r+g+b)/3;
    end
end
% 2. 对强度（intensity）进行直方图均衡化
figure('NumberTitle', 'off', 'Name', '2.4.3-1 强度I均衡化前后直方图');


subplot(1,2,1);
bar(0:255,pr_256(I),'k');
title('I histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.02]);

save_I = I;
I = equalize_hist(I);

subplot(1,2,2);
bar(0:255,pr_256(I),'k');
title('I equlized histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.02]);


% matlab 测试
% I_matlab = histeq(I,256);
% subplot(2,2,4);
% bar(0:255,pr_256(I_matlab),'k');
% title('matlab test');
% xlabel('gary level');
% ylabel('Pr(r)');
% axis([0 256 0 0.08]);


figure('NumberTitle', 'off', 'Name', '2.4.3-2 RGB模型转到HSI模型');


hsi_img = cat(3,H,S,I);
subplot(2,2,1);
imshow(hsi_img);
title('hsi色彩模型下表示');
imwrite(hsi_img, '.\hw4_output\2.4.3_RGB&HSI\hsi_img.png');
subplot(2,2,2);
imshow(save_I);
title('均衡化前I');
subplot(2,2,3);
imshow(H);
title('H');
imwrite(H, '.\hw4_output\2.4.3_RGB&HSI\H.png');
subplot(2,2,4);
imshow(I);
title('均衡化后I');
imwrite(I, '.\hw4_output\2.4.3_RGB&HSI\I.png');


% 3. 将处理后的结果转换到RGB色彩空间
for x = 1:M
    for y = 1:N
        h = 2*pi*H(x,y);
        s = S(x,y);
        i = I(x,y); 
        if h >= 0 && h < 2*pi/3
            B(x,y) = i*(1-s);
            R(x,y) = i*(1+(s*cos(h)/(cos(pi/3-h))));
            G(x,y) = 3*i - (B(x,y)+R(x,y));
        end
        if h >= 2*pi/3 && h < 4*pi/3
            R(x,y) = i*(1-s);
            G(x,y) = i*(1+(s*cos(h- 2*pi/3)/(cos(pi-h))));
            B(x,y) = 3*i - (R(x,y)+G(x,y));
        end
        if h >= 4*pi/3 && h < 2*pi
            G(x,y) = i*(1-s);
            B(x,y) = i*(1+(s*cos(h-4*pi/3)/(cos(5*pi/3-h))));
            R(x,y) = 3*i - (G(x,y)+B(x,y));
        end
    end
end

output_img3 = cat(3,R,G,B);


figure('NumberTitle', 'off', 'Name', '2.4.3-3 对I做直方图均衡化后转到RGB模型下结果');
subplot(2,2,1);
imshow(R);
title('R(equalized-I)');
imwrite(R, '.\hw4_output\2.4.3_RGB&HSI\R(equalized-I).png');
subplot(2,2,2);
imshow(G);
title('G(equalized-I)');
imwrite(G, '.\hw4_output\2.4.3_RGB&HSI\G(equalized-I).png');
subplot(2,2,3);
imshow(B);
title('B(equalized-I)');
imwrite(B, '.\hw4_output\2.4.3_RGB&HSI\B(equalized-I).png');
subplot(2,2,4);
imshow(output_img3);
title('处理后RGB合成图像');
imwrite(output_img3, '.\hw4_output\2.4.3_RGB&HSI\output_img3.png');

figure('NumberTitle', 'off', 'Name', '2.4.4 结果对比');
subplot(2,2,1);
imshow(input_img);
title('原图');
subplot(2,2,2);
imshow(output_img1);
title('RGB分别均衡化');
subplot(2,2,3);
imshow(output_img2);
title('RGB均值均衡化');
subplot(2,2,4);
imshow(output_img3);
title('HSI强度均衡化');







        
        



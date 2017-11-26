% 2.4 彩色图像的直方图均衡化
clc;
clear;
input_img = imread('hw4_input/task_3/16.png');
[M,N,C] = size(input_img);
R = input_img(:,:,1);
G = input_img(:,:,2);
B = input_img(:,:,3);
% =======================================================================================================
% 2.4.1 
% 1.分别对RGB三个通道进行直方图均衡化
% 2.将处理后的三通道重构成一张RGB图
% -------------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', '2.4.1');
% 1.分别对RGB三个通道进行直方图均衡化
equalize_R1 = equalize_hist(R);
equalize_G1 = equalize_hist(G);
equalize_B1 = equalize_hist(B);
subplot(2,2,1);
imshow(equalize_R1);
subplot(2,2,2);
imshow(equalize_G1);
subplot(2,2,3);
imshow(equalize_B1);
% 2.将处理后的三通道重构成一张RGB图
output_img1(:,:,1) = equalize_R1;
output_img1(:,:,2) = equalize_G1;
output_img1(:,:,3) = equalize_B1;
subplot(2,2,4);
imshow(output_img1);
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
figure('NumberTitle', 'off', 'Name', '2.4.2-1');

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
figure('NumberTitle', 'off', 'Name', '2.4.2-2');
bar(0:255,newPr,'k');
title('average equlized histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);

% 4. 把平均直方图均衡化前后的像素值映射关系应用到RGB三个通道
equalize_R2= R;
equalize_G2= G;
equalize_B2= B;
for i = 0:255
    %把原图中像素点灰度值为i的由转换函数转为均衡后灰度值
    equalize_R2(find(R == i)) = approx_Sk(i+1);
    equalize_G2(find(G == i)) = approx_Sk(i+1);
    equalize_B2(find(B == i)) = approx_Sk(i+1);
end
figure('NumberTitle', 'off', 'Name', '2.4.2-3');
subplot(2,2,1);
imshow(equalize_R2);
subplot(2,2,2);
imshow(equalize_G2);
subplot(2,2,3);
imshow(equalize_B2);
% 5. 再重构一张RGB图
output_img2(:,:,1) = equalize_R2;
output_img2(:,:,2) = equalize_G2;
output_img2(:,:,3) = equalize_B2;
subplot(2,2,4);
imshow(output_img2);
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
[M, N] = size(R);
H = double(zeros(M,N));
S = double(zeros(M,N));
I = double(zeros(M,N));

for i = 1:M
    for j = 1:N
        r = R(i,j);
        g = G(i,j);
        b = B(i,j);
        item = [r,g,b];
        x1 = ((r-g)+(r-b))/2;
        x2 = sqrt((r-g)^2 + (r-g)*(g-b));
        H(i,j) = acos(x1/x2);
        H(i,j) = rad2deg(H(i,j));
        if b > g
            H(i,j) = 360 - H(i,j);
        end
        H(i,j) = H(i,j)/360;
        S(i,j) = 1 - (3*min(item)/sum(item));
        I(i,j) = mean(item);
    end
end
% 2. 对强度（intensity）进行直方图均衡化
figure('NumberTitle', 'off', 'Name', '2.4.3');
I = im2uint8(I);

subplot(2,2,1);
bar(0:255,pr_256(I),'k');
title('I histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.08]);

I = equalize_hist(I);

subplot(2,2,2);
bar(0:255,pr_256(I),'k');
title('I equlized histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.08]);


% matlab 测试
I_matlab = histeq(I,256);
subplot(2,2,4);
bar(0:255,pr_256(I_matlab),'k');
title('matlab test');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.08]);

I = im2double(I);
% 3. 将处理后的结果转换到RGB色彩空间
for x = 1:M
    for y = 1:N
        h = 360 * H(x,y);
        s = S(x,y);
        i = I(x,y);
        if h > 0 && h <= 120
            B(x,y) = i*(1-s);
            R(x,y) = i*(1+(s*cos(h)/(cos(60-h))));
            G(x,y) = 3*i - (B(x,y)+R(x,y));
        end
        if h > 120 && h <= 240
            h = h - 2*pi/3;
            R(x,y) = i*(1-s);
            G(x,y) = i*(1+(s*cos(h)/(cos(60-h))));
            B(x,y) = 3*i - (R(x,y)+G(x,y));
        end
        if h > 240 && h < 360
            h = h - 4*pi/3;
            G(x,y) = i*(1-s);
            B(x,y) = i*(1+(s*cos(h)/(cos(60-h))));
            R(x,y) = 3*i - (G(x,y)+B(x,y));
        end
    end
end

R = im2double(R);
G = im2double(G);
B = im2double(B);
output_img3(:,:,1) = R;
output_img3(:,:,2) = G;
output_img3(:,:,3) = B;
subplot(2,2,3);
imshow(real(output_img3));







        
        



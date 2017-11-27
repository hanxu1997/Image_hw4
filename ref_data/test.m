% 2.4 彩色图像的直方图均衡化
clc;
clear;
input_img = imread('hw4_input/task_3/16.png');
figure('NumberTitle', 'off', 'Name', '2.4.3');
subplot(2,2,1);
imshow(input_img);
[M,N,C] = size(input_img);
input_img = im2double(input_img);
R = input_img(:,:,1);
G = input_img(:,:,2);
B = input_img(:,:,3);

% =======================================================================================================
% 2.4.3
% 1. 将输入图片转到HSV色彩空间
% 2. 对强度（intensity）进行直方图均衡化
% 3. 将处理后的结果转换到RGB色彩空间
% -------------------------------------------------------------------------
% 1. 将输入图片转到HSV色彩空间
x1 = 0.5 * ((R-G)+(R-B));
x2 = sqrt((R-G).^2 + (R-B).*(G-B));
H_f = acos(x1./(x2+eps));
H = H_f;
H(B>G) = 2*pi - H(B>G);
H = H/(2*pi);
minnum = min(min(R,G),B);
sumnum = R+G+B;
sumnum(sumnum==0) = eps;
S = 1 - 3.* minnum./sumnum;
H(S==0)=0;
I = (R+G+B)/3;

hsi_img = cat(3,H,S,I);
subplot(2,2,2);
imshow(hsi_img);
% 2. 对强度（intensity）进行直方图均衡化
% figure('NumberTitle', 'off', 'Name', '2.4.3');

I = equalize_hist(I);

subplot(2,2,3);
imshow(H);
title('H');
subplot(2,2,4);
imshow(I);
title('I');

% 3. 将处理后的结果转换到RGB色彩空间
H = H * (2*pi);
r = zeros(M,N);
g = zeros(M,N);
b = zeros(M,N);
% RG
index = find((H >= 0) & (H < 2*pi/3));
b(index) = I(index).* (1 - S(index));
r(index) = I(index).* (1+S(index).*cos(H(index))./cos(pi/3-H(index)));
g(index) = 3*I(index) - (b(index)+r(index));

% BG
index = find((H >= 2*pi/3) & (H < 4*pi/3));
r(index) = I(index).* (1 - S(index));
g(index) = I(index).* (1+(S(index).*cos(H(index) - 2*pi/3)./cos(pi-H(index))));
b(index) = 3*I(index) - (r(index)+g(index));
% BR
index = find((H >= 4*pi/3) & (H <= 2*pi));
g(index) = I(index).* (1 - S(index));
b(index) = I(index).* (1+(S(index).*cos(H(index) - 4*pi/3)./cos(5*pi/3-H(index))));
r(index) = 3*I(index) - (g(index)+b(index));
output_img3 = cat(3, r, g, b);
% output_img3 = max(min(output_img3,1),0);


figure(2);
subplot(2,2,1);
imshow(r);
title('R');
subplot(2,2,2);
imshow(g);
title('G');

subplot(2,2,3);
imshow(b);
title('B');

subplot(2,2,4);
output_img3 = max(min(output_img3,1),0);  
imshow(output_img3);
title('处理后RGB合成图像');







        
        



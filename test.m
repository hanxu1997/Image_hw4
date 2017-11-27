% 2.4 彩色图像的直方图均衡化
clc;
clear;
input_img = imread('hw4_input/task_3/06.png');
figure('NumberTitle', 'off', 'Name', '2.4.3');
subplot(2,2,1);
imshow(input_img);
[M,N,C] = size(input_img);
input_img = im2double(input_img);
R1 = input_img(:,:,1);
G1 = input_img(:,:,2);
B1 = input_img(:,:,3);

% =======================================================================================================
% 2.4.3
% 1. 将输入图片转到HSV色彩空间
% 2. 对强度（intensity）进行直方图均衡化
% 3. 将处理后的结果转换到RGB色彩空间
% -------------------------------------------------------------------------
% 1. 将输入图片转到HSV色彩空间
R = R1;
G = G1;
B = B1;

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
% figure('NumberTitle', 'off', 'Name', '2.4.3');

I = equalize_hist(I);

subplot(2,2,3);
imshow(H);
subplot(2,2,4);
imshow(I);
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
            h = h - 2*pi/3;
            R(x,y) = i*(1-s);
            G(x,y) = i*(1+(s*cos(h)/(cos(pi-h))));
            B(x,y) = 3*i - (R(x,y)+G(x,y));
        end
        if h >= 4*pi/3 && h < 2*pi
            h = h - 4*pi/3;
            G(x,y) = i*(1-s);
            B(x,y) = i*(1+(s*cos(h)/(cos(5*pi/3-h))));
            R(x,y) = 3*i - (G(x,y)+B(x,y));
        end
    end
end

output_img3 = cat(3, R, G, B);
% output_img3 = max(min(output_img3,1),0);
subplot(2,2,2);
imshow(output_img3);
figure(2);
subplot(2,2,1);
imshow(R);
subplot(2,2,2);
imshow(G);
subplot(2,2,3);
imshow(B);







        
        



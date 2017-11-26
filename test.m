% 2.4 ��ɫͼ���ֱ��ͼ���⻯
clc;
clear;
input_img = imread('hw4_input/task_3/16.png');
[M,N,C] = size(input_img);
R = input_img(:,:,1);
G = input_img(:,:,2);
B = input_img(:,:,3);

% =======================================================================================================
% 2.4.3
% 1. ������ͼƬת��HSVɫ�ʿռ�
% 2. ��ǿ�ȣ�intensity������ֱ��ͼ���⻯
% 3. �������Ľ��ת����RGBɫ�ʿռ�
% -------------------------------------------------------------------------
% 1. ������ͼƬת��HSVɫ�ʿռ�
R = im2double(R);
G = im2double(G);
B = im2double(B);

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
% 2. ��ǿ�ȣ�intensity������ֱ��ͼ���⻯
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


% matlab ����
I_matlab = histeq(I,256);
subplot(2,2,4);
bar(0:255,pr_256(I_matlab),'k');
title('matlab test');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.08]);

I = im2double(I);
% 3. �������Ľ��ת����RGBɫ�ʿռ�
for x = 1:M
    for y = 1:N
        h = 360 * H(x,y);
        s = S(x,y);
        i = I(x,y);
        if h >= 0 && h < 120
            B(x,y) = i*(1-s);
            R(x,y) = i*(1+(s*cos(h)/(cos(60-h))));
            G(x,y) = 3*i - (B(x,y)+R(x,y));
        end
        if h >= 120 && h < 240
            h = h - 120;
            R(x,y) = i*(1-s);
            G(x,y) = i*(1+(s*cos(h)/(cos(60-h))));
            B(x,y) = 3*i - (R(x,y)+G(x,y));
        end
        if h >= 240 && h < 360
            h = h - 240;
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







        
        



% 2.4 ��ɫͼ���ֱ��ͼ���⻯
clc;
clear;
input_img = imread('hw4_input/task_3/16.png');
[M,N,C] = size(input_img);
R = input_img(:,:,1);
G = input_img(:,:,2);
B = input_img(:,:,3);
% =======================================================================================================
% 2.4.1 
% 1.�ֱ��RGB����ͨ������ֱ��ͼ���⻯
% 2.����������ͨ���ع���һ��RGBͼ
% -------------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', '2.4.1');
% 1.�ֱ��RGB����ͨ������ֱ��ͼ���⻯
equalize_R1 = equalize_hist(R);
equalize_G1 = equalize_hist(G);
equalize_B1 = equalize_hist(B);
subplot(2,2,1);
imshow(equalize_R1);
subplot(2,2,2);
imshow(equalize_G1);
subplot(2,2,3);
imshow(equalize_B1);
% 2.����������ͨ���ع���һ��RGBͼ
output_img1(:,:,1) = equalize_R1;
output_img1(:,:,2) = equalize_G1;
output_img1(:,:,3) = equalize_B1;
subplot(2,2,4);
imshow(output_img1);
% =======================================================================================================
% 2.4.2 
% 1. �ֱ����ÿһ��ͨ����ֱ��ͼ
% 2. ��������ֱ��ͼȡƽ��ֵ�õ�һ��ƽ��ֱ��ͼ
% 3. �����ֱ��ͼ�����⻯
% 4. ��ƽ��ֱ��ͼ���⻯ǰ�������ֵӳ���ϵӦ�õ�RGB����ͨ��
% 5. ���ع�һ��RGBͼ
% -------------------------------------------------------------------------
% 1. �ֱ����ÿһ��ͨ����ֱ��ͼ
Pr_R = pr_256(R);
figure('NumberTitle', 'off', 'Name', '2.4.2-1');

subplot(2,2,1);
bar(0:255, Pr_R, 'r'); % R�����ܶ�ֱ��ͼ
title('R histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold on
Pr_G = pr_256(G);
subplot(2,2,2);
bar(0:255, Pr_G, 'g'); % G�����ܶ�ֱ��ͼ
title('G histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold on
Pr_B = pr_256(B);
subplot(2,2,3);
bar(0:255, Pr_B, 'b'); % B�����ܶ�ֱ��ͼ
title('B histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold on
% 2. ��������ֱ��ͼȡƽ��ֵ�õ�һ��ƽ��ֱ��ͼ
for i = 1:256
    Pr_average(i) = (Pr_R(i)+Pr_G(i)+Pr_B(i))/3;
end
subplot(2,2,4);
bar(0:255, Pr_average,'k'); % ƽ�������ܶ�ֱ��ͼ
title('average histogram');
xlabel('gary level');
ylabel('Pr(r)');
axis([0 256 0 0.06]);
hold off
% 3. �����ֱ��ͼ�����⻯
Sk = zeros(1,256);
for i = 1:256
    for j = 1:i
        Sk(i) = Sk(i)+Pr_average(j);
    end
    Sk(i) = Sk(i) * 255;
end
approx_Sk = round(Sk); %����Ϊ��ӽ����������õ������ֱ��ͼ��ֵ
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

% 4. ��ƽ��ֱ��ͼ���⻯ǰ�������ֵӳ���ϵӦ�õ�RGB����ͨ��
equalize_R2= R;
equalize_G2= G;
equalize_B2= B;
for i = 0:255
    %��ԭͼ�����ص�Ҷ�ֵΪi����ת������תΪ�����Ҷ�ֵ
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
% 5. ���ع�һ��RGBͼ
output_img2(:,:,1) = equalize_R2;
output_img2(:,:,2) = equalize_G2;
output_img2(:,:,3) = equalize_B2;
subplot(2,2,4);
imshow(output_img2);
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







        
        



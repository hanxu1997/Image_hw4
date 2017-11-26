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





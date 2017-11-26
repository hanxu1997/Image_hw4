% 2.3 图像去噪
clc;
clear;
input_img = imread('hw4_input/task_2.png');
[M,N,C] = size(input_img);
input_img = im2double(input_img);
R = input_img(:,:,1);
image = R;
% --------2.3.2对输入图片添加均值为 0、标准差为 40的高斯噪声---------------
figure('NumberTitle', 'off', 'Name', '2.3.2_gaussian');
subplot(2,3,1);
imshow(image);
title('inputimg');
output_img1 = imnoise( image,'gaussian', 0, 1600/(255*255));
subplot(2,3,2);
imshow(output_img1);
title('gaussian by imnoise');

output_img2 = mynoise( image, 'gaussian', 0, 40);
subplot(2,3,3);
imshow(output_img2);
title('gaussian by mynoise');
% ------------------2.3.2高斯噪声 算术均值滤波-----------------------------
a2_result3 = myfilter(output_img2,'arithmetic', 3, 3);
imwrite(a2_result3, '.\hw4_output\2.3.2_gaussian\arithmetic_3x3.png');

a2_result5 = myfilter(output_img2,'arithmetic', 5, 5);
imwrite(a2_result5, '.\hw4_output\2.3.2_gaussian\arithmetic_5x5.png');

a2_result7 = myfilter(output_img2,'arithmetic', 7, 7);
subplot(2,3,4);
imshow(a2_result7);
title('arithmetic 7x7');
imwrite(a2_result7, '.\hw4_output\2.3.2_gaussian\arithmetic_7x7.png');

a2_result9 = myfilter(output_img2,'arithmetic', 9, 9);
imwrite(a2_result9, '.\hw4_output\2.3.2_gaussian\arithmetic_9x9.png');

% -------------------------------------------------------------------------

% ------------------2.3.2高斯噪声 几何均值滤波-----------------------------
g2_result3 = myfilter(output_img2,'geometric', 3, 3);
imwrite(g2_result3, '.\hw4_output\2.3.2_gaussian\geometric_3x3.png');

g2_result5 = myfilter(output_img2,'geometric', 5, 5);
imwrite(g2_result5, '.\hw4_output\2.3.2_gaussian\geometric_5x5.png');
g2_result7 = myfilter(output_img2,'geometric', 7, 7);
subplot(2,3,5);
imshow(g2_result7);
title('geometric 7x7');
imwrite(g2_result7, '.\hw4_output\2.3.2_gaussian\geometric_7x7.png');
g2_result9 = myfilter(output_img2,'geometric', 9, 9);
imwrite(g2_result9, '.\hw4_output\2.3.2_gaussian\geometric_9x9.png');
% -------------------------------------------------------------------------

% ------------------2.3.2高斯噪声 中值滤波---------------------------------
m2_result3 = myfilter(output_img2,'median', 3, 3);
imwrite(m2_result3, '.\hw4_output\2.3.2_gaussian\median_3x3.png');
m2_result5 = myfilter(output_img2,'median', 5, 5);
imwrite(m2_result5, '.\hw4_output\2.3.2_gaussian\median_5x5.png');
m2_result7 = myfilter(output_img2,'median', 7, 7);
imwrite(m2_result7, '.\hw4_output\2.3.2_gaussian\median_7x7.png');
m2_result9 = myfilter(output_img2,'median', 9, 9);
imwrite(m2_result9, '.\hw4_output\2.3.2_gaussian\median_9x9.png');
subplot(2,3,6);
imshow(m2_result7);
title('median 7x7');
% medfilt2测试
% m_result = medfilt2(output_img2, [5 5], 'symmetric');
% imwrite(m_result2, '.\hw4_output\2.3.2_gaussian\median_5x5_2.png');
% -------------------------------------------------------------------------
% -------2.3.3 给输入图片添加盐噪声（概率为 0.2)---------------------------
output_img3 = mynoise( image, 'salt-and-pepper', 0, 0.2);
% figure(3);
figure('NumberTitle', 'off', 'Name', '2.3.3_salt');
subplot(2,2,1);
imshow(output_img3);
title('0.2 salt noise');

% ------------------2.3.3盐噪声 调和均值滤波-------------------------------
h3_result3 = myfilter(output_img3,'harmonic', 3, 3);
imwrite(h3_result3, '.\hw4_output\2.3.3_salt\harmonic_3x3.png');
h3_result5 = myfilter(output_img3,'harmonic', 5, 5);
imwrite(h3_result5, '.\hw4_output\2.3.3_salt\harmonic_5x5.png');
h3_result7 = myfilter(output_img3,'harmonic', 7, 7);
imwrite(h3_result7, '.\hw4_output\2.3.3_salt\harmonic_7x7.png');

subplot(2,2,2);
imshow(h3_result3);
title('3*3 harmonic filter');
% -------------------------------------------------------------------------
% ------------------2.3.3盐噪声 谐波均值滤波-------------------------------
% Q<0,Q>0
% 3*3谐波均值滤波
c3_result3_Q = myfilter(output_img3,'contraharmonic', 3, 3, -1.5);
subplot(2,2,3);
imshow(c3_result3_Q);
title('3*3 Q=-1.5');
imwrite(c3_result3_Q, '.\hw4_output\2.3.3_salt\contraharmonic_3x3_-1.5.png');
c3_result3 = myfilter(output_img3,'contraharmonic', 3, 3, 1.5);
subplot(2,2,4);
imshow(c3_result3);
title('3*3 Q=1.5');
imwrite(c3_result3, '.\hw4_output\2.3.3_salt\contraharmonic_3x3_1.5.png');
% 5*5谐波均值滤波
c3_result5_Q = myfilter(output_img3,'contraharmonic', 5, 5, -1.5);
imwrite(c3_result5_Q, '.\hw4_output\2.3.3_salt\contraharmonic_5x5_-1.5.png');
c3_result5 = myfilter(output_img3,'contraharmonic', 5, 5, 1.5);
imwrite(c3_result5, '.\hw4_output\2.3.3_salt\contraharmonic_5x5_1.5.png');
% -------------------------------------------------------------------------

% -------------2.3.4 椒盐噪声（椒噪声和盐噪声的概率都为 0.2)---------------
output_img4 = mynoise( image, 'salt-and-pepper', 0.2, 0.2);
figure('NumberTitle', 'off', 'Name', '2.3.4_salt-and-pepper');
subplot(2,3,1);
imshow(output_img4);
title('0.2 salt-and-pepper noise');
% ------------------2.3.4椒盐噪声 算术均值滤波-----------------------------
a4_result3 = myfilter(output_img4,'arithmetic', 3, 3);
imwrite(a4_result3, '.\hw4_output\2.3.4_salt-and-pepper\arithmetic_3x3.png');
a4_result5 = myfilter(output_img4,'arithmetic', 5, 5);
imwrite(a4_result5, '.\hw4_output\2.3.4_salt-and-pepper\arithmetic_5x5.png');
a4_result7 = myfilter(output_img4,'arithmetic', 7, 7);
imwrite(a2_result7, '.\hw4_output\2.3.4_salt-and-pepper\arithmetic_7x7.png');
subplot(2,3,2);
imshow(a2_result7);
title('arithmetic 7x7');

% ------------------2.3.4椒盐噪声 几何均值滤波-----------------------------
g4_result3 = myfilter(output_img4,'geometric', 3, 3);
imwrite(g4_result3, '.\hw4_output\2.3.4_salt-and-pepper\geometric_3x3.png');
g4_result5 = myfilter(output_img4,'geometric', 5, 5);
subplot(2,3,3);
imshow(g4_result5);
title('geometric 5x5');
imwrite(g4_result5, '.\hw4_output\2.3.4_salt-and-pepper\geometric_5x5.png');
g4_result7 = myfilter(output_img4,'geometric', 7, 7);
imwrite(g4_result7, '.\hw4_output\2.3.4_salt-and-pepper\geometric_7x7.png');

% ------------------2.3.4椒盐噪声 最大值滤波-------------------------------
max4_result3 = myfilter(output_img4,'max', 3, 3);
imwrite(max4_result3, '.\hw4_output\2.3.4_salt-and-pepper\max_3x3.png');
max4_result5 = myfilter(output_img4,'max', 5, 5);
imwrite(max4_result5, '.\hw4_output\2.3.4_salt-and-pepper\max_5x5.png');
max4_result7 = myfilter(output_img4,'max', 7, 7);
imwrite(max4_result7, '.\hw4_output\2.3.4_salt-and-pepper\max_7x7.png');
subplot(2,3,4);
imshow(max4_result3);
title('max 3x3');
% ------------------2.3.4椒盐噪声 最小值滤波-------------------------------
min4_result3 = myfilter(output_img4,'min', 3, 3);
imwrite(min4_result3, '.\hw4_output\2.3.4_salt-and-pepper\min_3x3.png');
min4_result5 = myfilter(output_img4,'min', 5, 5);
imwrite(min4_result5, '.\hw4_output\2.3.4_salt-and-pepper\min_5x5.png');
min4_result7 = myfilter(output_img4,'min', 7, 7);
imwrite(min4_result7, '.\hw4_output\2.3.4_salt-and-pepper\min_7x7.png');
subplot(2,3,5);
imshow(min4_result3);
title('min 3x3');
% ------------------2.3.4椒盐噪声 中值滤波---------------------------------
m4_result3 = myfilter(output_img4,'median', 3, 3);
imwrite(m2_result3, '.\hw4_output\2.3.4_salt-and-pepper\median_3x3.png');
m4_result5 = myfilter(output_img4,'median', 5, 5);
imwrite(m2_result5, '.\hw4_output\2.3.4_salt-and-pepper\median_5x5.png');
m4_result7 = myfilter(output_img4,'median', 7, 7);
imwrite(m4_result7, '.\hw4_output\2.3.4_salt-and-pepper\median_7x7.png');
subplot(2,3,6);
imshow(m4_result5);
title('median 5x5');






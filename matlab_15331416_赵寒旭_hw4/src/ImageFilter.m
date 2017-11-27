% 2.2 图像滤波
clc;
clear;
input_img = imread('hw4_input/task_1.png');
input_img = im2double(input_img);
% 3*3算术均值滤波
output_img1 = myfilter(input_img,'arithmetic', 3, 3);
figure(1);
subplot(3,2,1);
imshow(output_img1);
title('3*3 average filter');
imwrite(output_img1, '.\hw4_output\2.2_ImageFilter\arithmetic_3x3.png');

% 9*9算术均值滤波
output_img2 = myfilter(input_img,'arithmetic', 9, 9);
subplot(3,2,2);
imshow(output_img2);
title('9*9 average filter');
imwrite(output_img2, '.\hw4_output\2.2_ImageFilter\arithmetic_9x9.png');

% 3*3调和均值滤波
output_img3 = myfilter(input_img,'harmonic', 3, 3);
subplot(3,2,3);
imshow(output_img3);
title('3*3 harmonic filter');
imwrite(output_img3, '.\hw4_output\2.2_ImageFilter\harmonic_3x3.png');


% 9*9调和均值滤波
output_img4 = myfilter(input_img,'harmonic', 9, 9);
subplot(3,2,4);
imshow(output_img4);
title('9*9 harmonic filter');
imwrite(output_img4, '.\hw4_output\2.2_ImageFilter\harmonic_9x9.png');


% 3*3谐波均值滤波
output_img5 = myfilter(input_img,'contraharmonic', 3, 3, -1.5);
subplot(3,2,5);
imshow(output_img5);
title('3*3 contraharmonic filter');
imwrite(output_img3, '.\hw4_output\2.2_ImageFilter\contraharmonic_3x3.png');

% 9*9谐波均值滤波
output_img6 = myfilter(input_img,'contraharmonic', 9, 9, -1.5);
subplot(3,2,6);
imshow(output_img6);
title('9*9 contraharmonic filter');
imwrite(output_img4, '.\hw4_output\2.2_ImageFilter\contraharmonic_9x9.png');



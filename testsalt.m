% 2.3 Í¼ÏñÈ¥Ôë
clc;
clear;
input_img = imread('hw4_input/task_2.png');


[M,N,C] = size(input_img);
input_img = im2double(input_img);
R = input_img(:,:,1);
image = R;

% -------------------------------------------------------------------------
output_img3 = mynoise( image, 'salt-and-pepper', 0, 0.2);

% ------------------------------------------------------------------------

% Q>0,Q<0
% 3*3Ð³²¨¾ùÖµÂË²¨
figure(4);
c3_result3_Q = myfilter(output_img3,'contraharmonic', 3, 3, -1.5);
subplot(2,2,1);
imshow(c3_result3_Q);
imwrite(c3_result3_Q, '.\hw4_output\2.3.3_salt\contraharmonic_3x3_-1.5.png');
c3_result3 = myfilter(output_img3,'contraharmonic', 3, 3, 1.5);
subplot(2,2,2);
imshow(c3_result3);
imwrite(c3_result3, '.\hw4_output\2.3.3_salt\contraharmonic_3x3_1.5.png');

c3_result5_Q = myfilter(output_img3,'contraharmonic', 5, 5, -1.5);
subplot(2,2,3);
imshow(c3_result5_Q);
imwrite(c3_result5_Q, '.\hw4_output\2.3.3_salt\contraharmonic_5x5_-1.5.png');
c3_result5 = myfilter(output_img3,'contraharmonic', 5, 5, 1.5);
subplot(2,2,4);
imshow(c3_result5);
imwrite(c3_result5, '.\hw4_output\2.3.3_salt\contraharmonic_5x5_1.5.png');




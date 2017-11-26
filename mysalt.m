function [r,c] = mysalt( input_img, a, b)
%mynoise: 输入图像加噪声后输出
%   Detailed explanation goes here
    [M,N] = size(input_img);
    input_img = im2double(input_img);
        output_img = input_img;
        % 产生大小为M*N的0-1之间随机数矩阵
        X = rand(M, N);
        [r,c] = find(X <= a);
%         size = size(r);
%         for i = 1:size(r) 
%             output_img(r,c) = 0;
%         end
%         u = a + b;
%         [r,c] = find(X > a & X <= u);
%         for i = 1:size(r) 
%             output_img(r,c) = 1;
%         end

end


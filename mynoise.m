function output_img = mynoise( input_img, type, a, b)
% 输入图像加噪声后输出
%   高斯噪声 a：均值，b:方差
%   椒盐噪声 a: 椒(0)噪声概率，b：盐(1)噪声概率
    [M,N] = size(input_img);
    input_img = im2double(input_img);
    switch type
    case 'gaussian'
        %归一化
        a = a/255;
        b = b/255;
        R = a + b*randn(M, N);
        output_img = input_img + R;
    case 'salt-and-pepper'
        % a: 椒噪声概率
        % b: 盐噪声概率
        output_img = input_img;
        % 产生大小为M*N的0-1之间随机数矩阵
        sp_noise = rand(M, N);
        [r,c] = find(sp_noise <= a);
        for i = 1:size(r) 
            output_img(r(i),c(i)) = 0;
        end
        u = a + b;
        % & 适用于矩阵运算
        [r,c] = find(sp_noise > a & sp_noise <= u);
        for i = 1:size(r) 
            output_img(r(i),c(i)) = 1;
        end
    end
end


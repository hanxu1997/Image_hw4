function Pr = pr_256( input_img )
% 获得256个灰度级下输入图像的概率密度函数
    [m,n] = size(input_img);
    Pr = zeros(1,256);% 一个1行256列的零矩阵
    Nk = zeros(1,256); % 0~255个灰度级rk分别对应像素个数
    for k = 0:255
        Nk = length(find(input_img == k));
        Pr(k+1) = Nk/(m*n);
    end
end


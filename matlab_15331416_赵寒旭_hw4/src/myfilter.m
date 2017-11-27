function output_img = myfilter(input_img, type, m, n, parameter)
%图像滤波函数
%   算术均值滤波器 arithmetic_mean_filter
%   调和均值滤波器 harmonic_mean_filter
%   谐波均值滤波器 contraharmonic_mean_filter
%   几何均值滤波器 geometric_mean_filter
%   中值滤波器     median_filter
%   最大值滤波器   max_filter
%   最小值滤波器   min_filter
    % inputs.
    if nargin == 2
       m = 3; n = 3; Q = -1.5;
    elseif nargin == 4
       Q = -1.5;
    elseif nargin == 5
       Q = parameter;
    else 
       error('input error!');
    end

    switch type
        case 'arithmetic'
            output_img = arithmetic_mean_filter( input_img, m, n);
        case 'harmonic'
            output_img = harmonic_mean_filter( input_img, m, n);
        case 'contraharmonic'
            output_img = contraharmonic_mean_filter( input_img, m, n, Q );
        case 'geometric'
            output_img = geometric_mean_filter( input_img, m, n);
        case 'median'
            output_img = median_filter( input_img, m, n);
        case 'max'
            output_img = max_filter( input_img, m, n);
        case 'min'
            output_img = min_filter( input_img, m, n);
        otherwise
           error('type error!')
    end
end

% arithmetic_mean_filter
function output_img = arithmetic_mean_filter( input_img, m, n)
    input_img = im2double(input_img);
    filter = ones(m,n);
    output_img = filter2d( input_img, filter)./(m*n);
end

% harmonic_mean_filter
function output_img = harmonic_mean_filter(input_img, m, n)
    input_img = im2double(input_img);
    % 分母为窗口内像素倒数求和
    output_img = m * n ./ filter2d(1./(input_img + eps),ones(m, n));
end

% contraharmonic_mean_filter
function output_img = contraharmonic_mean_filter( input_img, m, n, Q )
    input_img = im2double(input_img);
    output_img = filter2d(input_img.^(Q+1), ones(m, n));
    output_img = output_img ./ (filter2d(input_img.^Q, ones(m, n)) + eps);
end

%  geometric_mean_filter
function output_img = geometric_mean_filter( input_img, m, n)
%     Warning: Displaying real part of complex input. (imshow(result) warning!)
    warning('off');
%     更简洁的方法：
%     input_img = im2double(input_img);
%     output_img = exp(filter2d(log(input_img), ones(m, n))).^(1 / (m * n));
    input_img = im2double(input_img);
    [M, N] = size(input_img);
    height = 2*(m-1) + M;
    width = 2*(n-1) + N;
    C = ones(height,width);
    C(m-1:M+m-2,n-1:N+n-2) = input_img;
    temp = double(C);
    output_img = temp;
    for i = 1:M+m-1
        for j = 1:N+n-1
            item = temp(i:i+(m-1),j:j+(n-1));
            item = item(:);
            num = prod(item);
            output_img(i+(m-1)/2,j+(n-1)/2) = num^(1/(m*n));
        end
    end
    output_img = output_img(m-1:M+m-2,n-1:N+n-2);
end


% median_filter
function output_img = median_filter( input_img, m, n)
    input_img = im2double(input_img);
    [M, N] = size(input_img);
    height = 2*(m-1) + M;
    width = 2*(n-1) + N;
    C = ones(height,width);
    C(m-1:M+m-2,n-1:N+n-2) = input_img;
    temp = double(C);
    output_img = temp;
    for i = 1:M+m-1
        for j = 1:N+n-1
            item = temp(i:i+(m-1),j:j+(n-1));
            item = item(:);
            midnum = median(item);
            output_img(i+(m-1)/2,j+(n-1)/2) = midnum;
        end
    end
    output_img = output_img(m-1:M+m-2,n-1:N+n-2);
end

% max_filter
function output_img = max_filter( input_img, m, n)
    input_img = im2double(input_img);
    [M, N] = size(input_img);
    height = 2*(m-1) + M;
    width = 2*(n-1) + N;
    C = ones(height,width);
    C(m-1:M+m-2,n-1:N+n-2) = input_img;
    temp = double(C);
    output_img = temp;
    for i = 1:M+m-1
        for j = 1:N+n-1
            item = temp(i:i+(m-1),j:j+(n-1));
            maxnum = max(max(item));
            output_img(i+(m-1)/2,j+(n-1)/2) = maxnum;
        end
    end
    output_img = output_img(m-1:M+m-2,n-1:N+n-2);
end

% min_filter
function output_img = min_filter( input_img, m, n)
    input_img = im2double(input_img);
    [M, N] = size(input_img);
    height = 2*(m-1) + M;
    width = 2*(n-1) + N;
    C = zeros(height,width);
    C(m-1:M+m-2,n-1:N+n-2) = input_img;
    temp = double(C);
    output_img = temp;
    for i = 1:M+m-1
        for j = 1:N+n-1
            item = temp(i:i+(m-1),j:j+(n-1));
            minnum = min(min(item));
            output_img(i+(m-1)/2,j+(n-1)/2) = minnum;
        end
    end
    output_img = output_img(m-1:M+m-2,n-1:N+n-2);
end




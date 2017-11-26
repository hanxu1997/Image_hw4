function output_img = filter2d( input_img, filter)
%ÓÃÂË²¨Æ÷filter¶ÔÊäÈëÍ¼ÏñÂË²¨
    [m,n] = size(input_img);
    [a,b] = size(filter);
    height = 2*(a-1) + m;
    width = 2*(b-1) + n;
    C = zeros(height,width);
    C(a-1:m+a-2,b-1:n+b-2) = input_img;
    temp1 = double(C);
    output_img = temp1;
    for i = 1:m+a-1
        for j = 1:n+b-1
            matrix1 = temp1(i:i+(a-1),j:j+(b-1)).* filter;
            midnum = sum(sum(matrix1));
            output_img(i+(a-1)/2,j+(b-1)/2) = midnum;
        end
    end
    output_img = output_img(a-1:m+a-2,b-1:n+b-2);
end


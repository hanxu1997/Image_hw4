function output_img = mynoise( input_img, type, a, b)
% ����ͼ������������
%   ��˹���� a����ֵ��b:����
%   �������� a: ��(0)�������ʣ�b����(1)��������
    [M,N] = size(input_img);
    input_img = im2double(input_img);
    switch type
    case 'gaussian'
        %��һ��
        a = a/255;
        b = b/255;
        R = a + b*randn(M, N);
        output_img = input_img + R;
    case 'salt-and-pepper'
        % a: ����������
        % b: ����������
        output_img = input_img;
        % ������СΪM*N��0-1֮�����������
        sp_noise = rand(M, N);
        [r,c] = find(sp_noise <= a);
        for i = 1:size(r) 
            output_img(r(i),c(i)) = 0;
        end
        u = a + b;
        % & �����ھ�������
        [r,c] = find(sp_noise > a & sp_noise <= u);
        for i = 1:size(r) 
            output_img(r(i),c(i)) = 1;
        end
    end
end


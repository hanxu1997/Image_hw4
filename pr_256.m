function Pr = pr_256( input_img )
% ���256���Ҷȼ�������ͼ��ĸ����ܶȺ���
    [m,n] = size(input_img);
    Pr = zeros(1,256);% һ��1��256�е������
    Nk = zeros(1,256); % 0~255���Ҷȼ�rk�ֱ��Ӧ���ظ���
    for k = 0:255
        Nk = length(find(input_img == k));
        Pr(k+1) = Nk/(m*n);
    end
end


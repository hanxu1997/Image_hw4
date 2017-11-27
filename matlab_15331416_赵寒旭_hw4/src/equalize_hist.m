function output_img = equalize_hist(input_img)
    [m,n] = size(input_img);
    Pr = zeros(1,256);% һ��1��256�е������
    Nk = zeros(1,256); % 0~255���Ҷȼ�rk�ֱ��Ӧ���ظ���
    input_img = round((double(input_img)*255));
    for k = 0:255
        Nk = length(find(input_img == k));
        Pr(k+1) = Nk/(m*n);
    end
    Sk = zeros(1,256);
    for i = 1:256
        for j = 1:i
            Sk(i) = Sk(i)+Pr(j);
        end
        Sk(i) = Sk(i) * 255;
    end
    approx_Sk = round(Sk); %����Ϊ��ӽ����������õ������ֱ��ͼ��ֵ
    newPr = zeros(1,256);
    for i = 1:256
        for j = 1:256
            if approx_Sk(j) == i
                newPr(i) = Pr(j)+ newPr(i);
            end
        end
    end
    output_img = input_img;
    for i = 0:255
        output_img(find(input_img == i)) = approx_Sk(i+1);
        %��ԭͼ�����ص�Ҷ�ֵΪi����ת������תΪ�����Ҷ�ֵ
    end
    output_img = double(output_img./255);
end


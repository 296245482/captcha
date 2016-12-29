function [ letters ] = binaryPartition( img, num )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

    letters = zeros(num,400);
    img = rgb2gray(img);%�ҶȻ�
    img = im2bw(img);%0-1��ֵ��
    img = 1-img;%��ɫ��ת���ַ���Ϊ��ͨ�򣬷���ȥ�����
    points=partitionPoint(img,num);
    for j = 0:num-1
        region = [points(j+1,1),1,points(j+1,2),20];
        subimg = imcrop(img,region);
        imlabel = bwlabel(subimg);
        m=max(max(imlabel));
        if m>1 % ˵������㣬Ҫȥ��
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area); 
            maxindex = find(area == max(area));
            area(maxindex) = 0;
            for ii=1:m-1
                secondindex = find(area == max(area));        
                imindex = ismember(imlabel,secondindex);
                subimg(imindex==1)=0;%ȥ���ڶ�����ͨ����㲻���ܱ��ַ������Եڶ���ľ������
            end
        end
        subimg = resizeImg(subimg);
        minwidth = 20;
        for angle = -60:60
            imgr=imrotate(subimg,angle,'bilinear','crop');%crop ����ͼ���С�仯
            imlabel = bwlabel(imgr);
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area);
            maxindex = find(area == max(area));
            imindex = ismember(imlabel,maxindex);%�����ͨ��Ϊ1
            [~,x] = find(imindex==1);
            width = max(x)-min(x)+1;
            if width<minwidth
                minwidth = width;
                imgrr = imgr;
            end
        end
        letter = im2bw(imgrr);
        letters(j+1,:) = letter(:);
    end
end
mydir='.\bw\';
lettersdir = '.\letters\';
if exist(lettersdir,'dir')==0
    mkdir(lettersdir);
end
DIRS=dir([mydir,'*.jpg']);  %��չ��
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(mydir,DIRS(i).name ));
        img = im2bw(img);%��ֵ��
        img = 1-img;%��ɫ��ת���ַ���Ϊ��ͨ�򣬷���ȥ�����
        for j = 0:3
            region = [j*20+1,1,19,20];%��һ����֤��ֳ��ĸ�20*20��С���ַ�ͼƬ
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
            name = strcat(lettersdir,DIRS(i).name(j+1),'_',num2str(i*4+j),'.jpg');
            imwrite(subimg,name);
        end
    end
end
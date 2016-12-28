mydir='.\captcha\';
bw = '.\bw\';
if exist(bw,'dir')==0
    mkdir(bw)
end
DIRS=dir([mydir,'*.jpg']);
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(mydir,DIRS(i).name ));
        img = rgb2gray(img);%�ҶȻ�
        img = im2bw(img);%0-1��ֵ��
        name = strcat(bw,DIRS(i).name);
        imwrite(img,name);
    end
end

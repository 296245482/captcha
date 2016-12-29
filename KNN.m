function [ result ] = KNN( letters, traindata, trainlabel, k)
%KNN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

    klabel = char(k);
    kdistance = zeros(k,1);
    n = size(letters,1);
    m = size(traindata,2);
    total = size(traindata,1);
    result = char(n);
    
    for i=1:n
        for j=1:k
            kdistance(j)=500;
            klabel(j)='A';
        end
        
        for j=1:total
            d = abs(traindata(j,:)-letters(i,:));
            d = sum(d);
            %calculate distance between two letter
%             for l=1:m
%                 if traindata(j,l) ~= letters(i,l)
%                     d = d+1;
%                 end
%             end
            %k nearest neighbor
            tlabel = trainlabel(j);
            for l=1:k
                if d<kdistance(l)
                    dtemp = kdistance(l);
                    ltemp = klabel(l);
                    kdistance(l) = d;
                    klabel(l) = tlabel;
                    d = dtemp;
                    tlabel = ltemp;
                end
            end
        end
        ta = tabulate(klabel(:));
        [~,index] = max([ta{:,2}]);
        result(i) = ta{index,1};
    end
end


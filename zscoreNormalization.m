function [normalized] = zscoreNormalization(set,notrated)
%Zscore normalization
%   Detailed explanation goes here
    
    [rows,columns]=size(set);
    set(set == notrated)=NaN;
    setmeans=nanmean(set,2);
    normalized=zeros(size(set));
    for i=1:rows
        normalizedrow=(set(i,:)-setmeans(i))/nanstd(set(i,:));
        normalized(i,:)=normalizedrow;
    end
    normalized(isnan(normalized))=notrated;
end

function [weights] = zscoreweights(activeuser,trainset,notrated)
%finds z score weights bw activeuser and trainset
%   inputs must be z score normalized
%   size of weights = user count in active user * user count in trainset

    if(notrated ~= 0)
        activeuser(activeuser == notrated) = 0;
        trainset(trainset == notrated) = 0;
    end
    weights = activeuser * trainset';
end

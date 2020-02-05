function [predictions] = userbasedMemoryCF(testset,normtest,normtrain,nsm,nsmval)

%   Prediction with z-score normalization
%   nsm(neighbour selection method)=knn or threshold
%   nsmval=k or threshold

    [testrows,testcolumns]=size(testset);
    
    predictions=zeros(testrows,testcolumns);
    nantest=testset;
    notrateds=nantest == 0;
    nantest(notrateds)=NaN;

    
    
    for i=1:testrows
        
        rateds=find(testset(i,:)~=0);
        ratedcount=length(rateds);
        
        for j=1:ratedcount
            
            normactiveuser = normtest(i,:);
            nanactiveuser=nantest(i,:);
            targetitem = rateds(j);
            normactiveuser(1,targetitem)=0;
            nanactiveuser(1,targetitem)=NaN;
            
            weights=zscoreweights(normactiveuser,normtrain,0);
            
            neighbors=[];
            
            if strcmp(nsm,'knn')
                
                [neighbors,~,~] = knn(weights,nsmval);
                
            elseif strcmp(nsm,'threshold')
                
                neighbors = find(weights >= nsmval);
                
            else
                
                fprintf('nsm yanlýþ girildi!!!');
                
            end
            
            usedneighbors=neighbors(normtrain(neighbors,targetitem)~=0); %neighbors rated target item
            
            %usedneighbors==0
            if length(usedneighbors~=0)
                
                weights=weights(usedneighbors);
            
                std_a=nanstd(nanactiveuser);
                mean_a=nanmean(nanactiveuser);
                predictions(i,targetitem) = mean_a + std_a * ((weights*normtrain(usedneighbors,targetitem))/sum(weights));
                
            end
            
        end
        
    end
    
    
    
end
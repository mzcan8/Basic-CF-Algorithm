function [indices,values,y] = knn(weights,k)
%Knn neighbour selection
%   y: count of selected neighbors


% hmmConstruct(MLP, 3, 0); holds 19 mins with this knn implementation
%     [values,indices]=sort(weights,2,'descend');
%     x = size(indices,2);
%     y=0;
%     if k > x
%         values=values(:,1:x);
%         indices=indices(:,1:x);
%         y=x;
%     else
%         values=values(:,1:k);
%         indices=indices(:,1:k);
%         y=k;
%     end
    
    
    x = size(weights,2);
    y=0;
    if k > x
        indices=zeros(1,x);
        values=zeros(1,x);
        for i = 1:x
            [values(i),indices(i)] = max(weights);
            weights(indices(i)) = -inf;
        end
        y=x;
    else
        indices=zeros(1,k);
        values=zeros(1,k);
        for i = 1:k
            [values(i),indices(i)] = max(weights);
            weights(indices(i)) = -inf;
        end
        y=k;
    end
    
end

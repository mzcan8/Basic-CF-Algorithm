

load('Netflix.mat');
% Kfoldindices=crossvalind('Kfold', Netflix(:,1), 10);
load('NormalizedNetflix.mat');
load('Kfoldindices.mat');
dataset=Netflix;
normdataset=NormalizedNetflix;
Kfoldval=10;
nsm='knn';
nsmval=50;

        tEnd=0;
        
        TestIndices = find((Kfoldindices == 1));
        TrainIndices = find((Kfoldindices ~= 1));
            
        Testset=dataset(TestIndices,:);
        
        allpredictions=zeros([Kfoldval size(Testset)]);
        alltestsets=zeros([Kfoldval size(Testset)]);
        tStart = tic;
        for i = 1:Kfoldval
            
            
            TestIndices = find((Kfoldindices == i));
            TrainIndices = find((Kfoldindices ~= i));
            
            Testset=dataset(TestIndices,:);
            normtestset=normdataset(TestIndices,:);
            normtrainset=normdataset(TrainIndices,:);
            
            [predictions] = userbasedMemoryCF(Testset,normtestset,normtrainset,nsm,nsmval);
            
            alltestsets(i,:,:)=Testset;
            allpredictions(i,:,:)=predictions;

            
        end
        tEnd = toc(tStart);
        fprintf('%d minutes and %f seconds\n',floor(tEnd/60),rem(tEnd,60));
        
        predicteds=allpredictions~=0&~isnan(allpredictions);
        [mae,rmse] = maeRMSE(alltestsets(predicteds),allpredictions(predicteds));
        
        ratingcount=nnz(alltestsets);
        ratedcount=nnz(predicteds);
        coverage=ratedcount/ratingcount;
        
        strvar1='allpredictions';
        strvar2='mae';
        strvar3='rmse';
        strvar4='tEnd';
        strvar5='coverage';
        save(resstr,strvar1,strvar2,strvar3,strvar4,strvar5);
        
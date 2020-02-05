function [mae,rmse] = maeRMSE(ratings,predictions)

mae=mean(nanmean(abs(ratings-predictions)));
rmse= sqrt(mean((ratings-predictions).^2));


end
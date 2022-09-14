% First method to generate "Z" vectors is to use simple formula
% Z=(X-u)/stddev. This should generate what is close to a standard 
% Normal distribution N[0,1].
for ii=1:nAssets
    columnmean(ii)= mean(PDDELTAS(:,ii));   % calculate mean of each column of obligor historical dPD's
    columnstd(ii)= std (PDDELTAS(:,ii));    % calculate std deviation of each column
    Znorm(:,ii) = (PDDELTAS(:,ii)- columnmean(ii))/columnstd(ii);
end   

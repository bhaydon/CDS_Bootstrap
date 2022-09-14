%Script to determine correlation from historical PD data obtained
%from Deutsche Bank website. Five reference sovereign 5Y CDS's were used
%to provide the PD data.
%
% Function below will return "R", the correlation matrix of all the
% historical data

% [R]=corrcoef(PDDELTAS);

% We now have to convert our data from X --> U where
% X = rougly normally distributed sampled dPD's from obligor's hist. data
% U = Uniformly distributed 'pseudo-samples' based on X put through CDF
% function.
% Perform kernel smoothing on the data

nAssets = 5
load PDDELTAS;  % load dPD sample sets
load uhist;     % load table of pseudo-samples "u"

%First, let's generate histograms of original datasets (one per obligor)
for ii=1:nAssets
    figure;
    histogram (PDDELTAS(:,ii))
    str = sprintf('Histogram Original Samples Asset %d', ii);
    title(str);
end;

% Kernel-Smoothing Curves
% The function below is used to illustrate how kernel smoothing works by
% creating a smoothed curve from the sum of constituent PDF curves based on
% each point of data in the sample dataset. Five smoothed curves will be
% generated, overlaid on their respective original sample histograms.
%
% pdKS(x) = array of kernel smoothed PDF's - one per data set

for ii=1:nAssets
    figure;
    histogram (PDDELTAS(:,ii))     %Plot histogram first
    hold on;
    pdKS(ii) = fitdist(PDDELTAS(:,ii),'Kernel'); %generate fitted curve
    x = -1:.05:1;
    ySix = pdf(pdKS(ii),x);
    ySix = ySix*15;       % Scale pdf to overlay on histogram
    plot(x,ySix,'k-','LineWidth',2);
    str = sprintf('Kernel Smoothed PDF - Asset %d', ii);
    title(str);
end

% Generate "U" from Empirical PDF using MATLAB's "cds" function.
% 
% "uhist" = array of pseudo-samples "u" generated from smoothed "X" sample data.
for ii=1:nAssets
    pdKS(ii) = fitdist(PDDELTAS(:,ii),'Kernel'); %generate fitted curve from X sample data
    uhist(:,ii) = cdf(pdKS(ii),PDDELTAS(:,ii));
end;    

% Convert "u-historical" psuedo-samples into "Z-hist" through the use
% of the inverse normal function. This completes the "X-->u-->Z"
% transformation.
zhist(:,:)= norminv(uhist(:,:),0,1);   %generate Z-historical matrix

% Obtain correlation matrix from "Z-hist" matrix
%
rhohatZhist = corrcoef(zhist);  %Generate correlation matrix from Z-hist



% Alternative approach to correlation matrix is working with 
% the "u-hist" dataset and using MATLAB's "copulafit" function.
%

rhohatGaussian = copulafit('Gaussian',uhist);   % Generate correlation matrix for Gaussian Copula
[rhohatTcop,dfhat]= copulafit('t',uhist);       % Generate correlation matrix and degreets of freedom
                                                % for a t-Copula.



 








% We have correlation Matrix for Guassian and T-Copulas, and now are required to
% generate correlated simulated "u's". In this method, we will use the
% MATLAB function "copularnd" to generate the random numbers, as opposed to
% transforming u-->Z-->X (by Cholesky)-->back to u again. The "copularnd"
% function allows us to do all this in one step.
%
load rhohatGaussian;    % load previously calculated Rho for Gaussian Copula
load rhohatTcop;        % load previously calculated Rho for T-Copula
load dfhat;             % load previously calculated degrees of freedom estimate for T-Copula

nSimulations=10000      % number of simulated data sets to generate.

% Generate simulated "u's" using Gaussian Copula
% uSimGaussian = (nx5)matrix containing simulated u's from Gaussian Copula
uSimGuassian = copularnd('Gaussian',rhohatGaussian,nSimulations);

% Generate histograms of simulated data from Gaussian Copula to confirm uniform distribution
for ii=1:nIssuers
    figure;
    histogram(uSimGuassian(:,ii));
    str = sprintf('Gaussian Copula Generated data - Asset %d', ii);
    title(str);
end


% Generate simulated "u's" using Gaussian Copula
% uSimtcopula = (nx5)matrix containing simulated u's from Gaussian Copula
uSimtcopula = copularnd('t',rhohatTcop,dfhat, nSimulations);

% Generate histograms of simulated data from T-Copula to confirm uniform distribution
for ii=1:nIssuers
    figure;
    histogram(uSimtcopula(:,ii));
    str = sprintf('T-Copula Generated data - Asset %d', ii);
    title(str);
end



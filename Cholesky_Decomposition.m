% This block of code performs Cholesky Decomposition on the Gaussian
% correlation matrix we have already calculated in a previous step.

load rhohatGaussian;    % load previously calculated correlation matrix

[Rcholesky,posdefindicator]  = chol(rhohatGaussian);

% Now check to ensure RHO ("rhohatGuassian
if (posdefinindicator > 0) then  
    error ('RHO is not positive-definite');    
end


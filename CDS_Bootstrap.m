% CDS Bootstrapping using Choleskey Decomposition
%
% Bruce Haydon (Ottawa (Canada)/New York (USA))
% 
%Interest rate curve - US Treasury Rates
ZeroDates = datenum({'08-Oct-15','08-Jan-16', '08-Jul-17','08-Jul-18', '08-Jul-20','08-Jul-25','08-Jul-45'});
% Enter Zero-Coupon rates (apostrophe at end indicates as column)
ZeroRates = [0.01,0.08,0.57,0.91,1.52,2.23,3.01]'/100;  
ZeroData = [ZeroDates ZeroRates];

% Valuation date for CDS's
Settle = '08-Jul-2015';

% CDS spreads 
% Each row in MarketSpreads corresponds to a different issuer;
% Each column to a different maturity date (corresponding to MarketDates).
% Enter spread information Asset (A) 

Spread_Time = [1 2 3 5 7]';         % Maturity years for spread

Market_Dates = daysadd(datenum(Settle),360*Spread_Time,1);

MarketSpreads = [
   160 195 230 285 330;  % Italy
   130 165 205 260 305;  % Mexico
   150 180 210 260 300;  % Portugal
   165 200 225 275 295;  % Spain
   180 240 260 320 360]; % Russia

nIssuers = 5;   % number of issuers (5)
nProbDates = length(Market_Dates);  % number of spread dates


% Assumptions used in the calculation of hazard rates and default
% probabilities:
%   Recovery Rate = 40% (default)
%   Period = premiums paid every quarter (4 per year)  (default)
%   Semiannual compounding (default)

DefProb = zeros(nIssuers,nProbDates);
HazRates= zeros(nIssuers,nProbDates);

for ii = 1:nIssuers
   MarketData = [Market_Dates MarketSpreads(ii,:)'];
   [ProbData, HazData] = cdsbootstrap(ZeroData,MarketData,Settle);
   DefProb(ii,:) = ProbData(:,2)';
   HazRates(ii,:)= HazData(:,2)';
end
% [ProbData_A,HazData_A] = cdsbootstrap(ZeroData, Market_Data, Settle)

% Generate Default Probability Curves
% Comparison of all Credit Default curves on one graph
figure
plot(Market_Dates',DefProb')
datetick
title('Individual Default Probability Curves')
ylabel('Cumulative Probability')
xlabel('Date')


% Generate HAZARD RATE curves for each obligor

% (1) Generate Bootstrapped Hazard Rate Curve for Italy
HazData_A(:,2)=HazRates(1,:)
HazTimes=yearfrac(Settle,HazData_A (:,1));
figure
stairs([0; HazTimes(1:end-1,1); HazTimes(end,1)+1],[HazData_A(:,2);HazData_A(end,2)])
grid on
axis([0 HazTimes(end,1)+1 0.9*HazData_A(1,2) 1.1*HazData_A(end,2)])
xlabel('Time (years)')
ylabel('Hazard Rate')
title('Bootstrapped Hazard Rates For Italy')

% (2) Generate Bootstrapped Hazard Rate Curve for Mexico
HazData_A(:,2)=HazRates(2,:)
HazTimes=yearfrac(Settle,HazData_A (:,1));
figure
stairs([0; HazTimes(1:end-1,1); HazTimes(end,1)+1],[HazData_A(:,2);HazData_A(end,2)])
grid on
axis([0 HazTimes(end,1)+1 0.9*HazData_A(1,2) 1.1*HazData_A(end,2)])
xlabel('Time (years)')
ylabel('Hazard Rate')
title('Bootstrapped Hazard Rates For Mexico')

% (3) Generate Bootstrapped Hazard Rate Curve for Portugal
HazData_A(:,2)=HazRates(3,:)
HazTimes=yearfrac(Settle,HazData_A (:,1));
figure
stairs([0; HazTimes(1:end-1,1); HazTimes(end,1)+1],[HazData_A(:,2);HazData_A(end,2)])
grid on
axis([0 HazTimes(end,1)+1 0.9*HazData_A(1,2) 1.1*HazData_A(end,2)])
xlabel('Time (years)')
ylabel('Hazard Rate')
title('Bootstrapped Hazard Rates For Portugal')

% (4) Generate Bootstrapped Hazard Rate Curve for Spain
HazData_A(:,2)=HazRates(4,:)
HazTimes=yearfrac(Settle,HazData_A (:,1));
figure
stairs([0; HazTimes(1:end-1,1); HazTimes(end,1)+1],[HazData_A(:,2);HazData_A(end,2)])
grid on
axis([0 HazTimes(end,1)+1 0.9*HazData_A(1,2) 1.1*HazData_A(end,2)])
xlabel('Time (years)')
ylabel('Hazard Rate')
title('Bootstrapped Hazard Rates For Spain')

% (4) Generate Bootstrapped Hazard Rate Curve for Russia
HazData_A(:,2)=HazRates(5,:)
HazTimes=yearfrac(Settle,HazData_A (:,1));
figure
stairs([0; HazTimes(1:end-1,1); HazTimes(end,1)+1],[HazData_A(:,2);HazData_A(end,2)])
grid on
axis([0 HazTimes(end,1)+1 0.9*HazData_A(1,2) 1.1*HazData_A(end,2)])
xlabel('Time (years)')
ylabel('Hazard Rate')
title('Bootstrapped Hazard Rates For Russia')

%Generate Bootstrapped Default Probability Curve for Mexico
ProbTimes = yearfrac(Settle, ProbData_A(:,1));     % Generate axis values for dates
figure
plot([0; ProbTimes],[0;ProbData_A(:,2)]);
grid on
axis([0,ProbTimes(end,1) 0 ProbData_A(end,2)]);
xlabel('Time (years)');
ylabel('Cumulative Default Probability');
title('Bootstrapped Probability Default Curve - Mexico')





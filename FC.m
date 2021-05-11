function [dataTr,dataTs, LablTr, LablTs] = FC
load bloodVessels
%% Generate Points and Labels
Sigma  = [15 5 ; 5 15 ];
Num    = 300;
f1     = mvnrnd([0 5], Sigma, Num); 
f1=bloodVessels(1:300,1:300);
f2     = mvnrnd([15 8], Sigma, Num); 
f2=bloodVessels(1:300,1:300);
sz1    = length(f1);
sz2    = length(f2);
c1     = zeros(sz1, 1);
c2     = ones(sz2, 1);
F      = [f1; f2];
C      = [c1; c2];
%% Separate into Train and Test data
ind    = randperm(length(F));
dataTr = F(ind(1 : sz1), 1:2);
dataTs = F(ind(sz1 + 1 : end), 1:2);
LablTr = C(ind(1 : sz1), 1);
LablTs = C(ind(sz1 + 1 : end), 1);

end

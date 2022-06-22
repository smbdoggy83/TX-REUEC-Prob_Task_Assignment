% function [D, P] = P1(n, W, w) 
function cond2 = P1(n, W, w) 

%% Represents equation P1
% Inputs: 
% ~ n: N edge devices
% ~ W: Total amount of work needed to meet or exceed. 
% ~ w: Work accomplished per device. Ex: w[2] = work done by device 2

d = []; % Network delays per device. Ex: d[2] = network delay for device 2
x = [1 1 0 1 0 0 1 1 1 0]; % Chosen factor per device (1 = chosen, 2 = unchosen). Ex: d[2] = 1 
        % --> device 2 was chosen. The paper refers to this as "vector X"

% minimize D such that

% cond1: P(sum from i=1 to n (di*xi < D)) >= p

%sym i;
%cond2 = symsum(w*x, i, 1, n)
cond2 = 0;
for i = 1:n
    cond2 = cond2 + ( w(i) * x(i) ) ;
end


% xi = {0, 1}




end
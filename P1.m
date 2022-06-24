function [D, P] = P1(n, W, w) 

%% Represents equation P1
% Inputs: 
% ~ n: N edge devices
% ~ W: Total amount of work needed to meet or exceed. 
% ~ w: Work accomplished per device. Ex: w[2] = work done by device 2

dist = normpdf([10:1:100], mu, sigma);
d = []; % Network delays per device. Ex: d[2] = network delay for device 2
x = [1 1 0 1 0 0 1 1 1 0]; % Chosen factor per device (1 = chosen, 2 = unchosen). Ex: d[2] = 1 
        % --> device 2 was chosen. The paper refers to this as "vector X"
% w defined as parameter

Dvals = []; % Stores all pcalculated D values. The smallest one will be returned at the end

for j = 1:100 % 100 is arbitrary til we figure out what it should be

    % minimize D such that
    
        % condition 1: P(sum from i=1 to n of (di*xi < D)) >= p
        % this gets rewritten in the next part

        % condition 2: sum from i=1 to n of ( wi * xi* ) >= W
    
        %sym i;
        %cond2 = symsum(w*x, i, 1, n)
        %%cond2 = 0;
        %%for i = 1:n
        %%    cond2 = cond2 + ( w(i) * x(i) ) ;
        %%end
        cond2 = sum(w(1:n) .* x(1:n))
        
        % xi = {0, 1} (covered with x above)
end

D = minimum(Dvals);

end
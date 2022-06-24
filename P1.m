function D = P1(n, W, w, d) 

%% Represents equation P1
% Inputs: 
% ~ n: N edge devices
% ~ W: Total amount of work needed to meet or exceed. 
% ~ w (wi): Work accomplished per device. Ex: w[2] = work done by device 2
% ~ d (di): Network delays per device. Ex: d[2] = network delay for device 2
% Outputs:
% ~ x (xi): Chosen factor per device (1 = chosen, 2 = unchosen).  The paper refers to this as "vector X". Ex: d[2] = 1 --> device 2 was chosen.

dist = normpdf([10:1:100], mu, sigma);

Dvals = []; % Stores all pcalculated D values. The smallest one will be returned at the end

for j = 1:100 % 100 is arbitrary, should be some set of combos (brute force used all combos)

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
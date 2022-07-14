function [range, X] = RSS(means, stdDevs, works, A, W)
%% Reduces search space of [0 ∞] to [0 h]. 
%
% Inputs: ~ means (μi): The average delay per device. Ex: means[2] =
% average delay of device 2 ~ stdDevs (σi): The standard deviation of delay
% per device. Ex: stdDevs[2] = standard deviation of delay of device 2 ~ w
% (wi): Work accomplished per device. Ex: w[2] = work done by device 2 ~ p:
% Confidence probability. Usually 99% or 95%, represented as 0.99 or 0.95 .
% ~ W: For condition 1, total amount of work needed to meet or exceed. Ex:
% 500 ~ x (xi): Chosen factor per device (1 = chosen, 2 = unchosen).  The
% paper refers to this as "vector X". Ex: x[2] = 1 --> device 2 was chosen.
%
% Outputs: ~ range: array representing search space. Should only have two
% items: [0, h]. ~ X: array representing device combo at 0 and at h. Should
% only have two items: [X(0), X(h)]

% Mapping out every line from algorithm
%dataTable = table;

%[means, stdDevs, works] =DataGen(dataTable, 10);
%W = 500;
%p = .99; % Probability constant
%A = sqrt(2) * erfinv(2*p - 1); % Constant
%stdDevs = stdDevs .^2;
%1: "solve P3 at 0 to get X(0)"
            %x = zeros(length(means)); Commenting out some lines for now to
            %make work with updated P3_2
n = length(means);
k = 0;
[X0, ~] = P3_2(0, W, means, stdDevs, works);
X0 = rot90(X0);
%std = sqrt( sum( X0( 1:length(X0)).*stdDevs(1:length(X0) ) ) )

sigSqr = stdDevs.^2; % Squares each element, stores into another array
std = sqrt( sum(sigSqr(1:n) .* X0(1:n)) ); % std dev calculation of chosen devices, as per beginning of section IV. 

if std == 0
    range = []
    X = []
    return
end
count = 1;
while (abs(k*std - A) > .001) %while (k*std ~= A) 
    disp("Loop #" + count + ": k * std is " + (k*std) + ", A is " + A);
    
    k = A / std

    [X1, ~] = P3_2(k, W, means,stdDevs, works);
    X1 = rot90(X1);

    std = sqrt( sum(sigSqr(1:n) .* X1(1:n)) ) % std dev calculation of chosen devices, as per beginning of section IV. 
%   std = sqrt(sum(X1(1:length(X1)).*stdDevs(1:length(X1))));

    count = count + 1;
end

disp("Done after " + (count-1) + " loops. Final k * std was " + (k*std) + ", A is " + A);

h = k;

range = [0; h]
X = [X0; X1];
X = round(X)


%     n = length(x); % Number of devices
%     workReq = sum(works(1:n) .* x(1:n)); % The sum of all work per chosen device (sum from i = 1:n of w(i) * x(i) ). Must be >= W
% 
%     % Finding μ
%     totalMean = sum(means(1:n) .* x(1:n)); % Total average calculation, as per beginning of section IV. 
%     
%     % Finding k We know that k >= 0 and overall function must be increasing
%     p = 0.99; % Confidence level, can try 95% later
% 
%     % Finding σ^2
%     sigSqr = stdDevs.^2; % Squares each element, stores into another array
%     totalStd = sqrt( sum(sigSqr(1:n) .* x(1:n)) ); % Total std dev calculation, as per beginning of section IV. 
%     totalStdSqrd = totalStd^2;
% 
% %[x, fval] = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub); % not set up
% %yet
% k = 0;
% [x, fval] = intlinprog(totalMean + k*totalStdSqrd, 10, -workReq, W, [], [], zeros(10, 1), [Inf;Inf;1])
% 
% stdDev = stdDevs(0) % instead of 0, might be related the best result from the above function (since we find X(0))
% 

% 
% h = k;
% range = [0, h]; X(0) = something; X(h) = something; 
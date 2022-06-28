function [minWorkReq, totalMean, A, totalStd] = P2(W, w, x, means, stdDevs)
%% Represents equation P2. This function is meant to just perform calculations 
%% and return results, whereas the true "minimization" is done by the algorithm
%% that calls the method. 
% Requirements: w, x, means, and stdDevs should all be the same length.
% Example: [minWorkReq, totalMean, A, totalStd] = P2(500, [3 4 10 9 7], [1 1 0 1 0], [23 12 76 52 82], [6 7 15 6 10])
% 
% Inputs: 
% ~ W: For condition 1, total amount of work needed to meet or exceed. Ex: 500
% ~ w (wi): Work accomplished per device. Ex: w[2] = work done by device 2
% ~ x (xi): Chosen factor per device (1 = chosen, 2 = unchosen).  The paper refers to this as "vector X". Ex: x[2] = 1 --> device 2 was chosen.
% ~ means (μi): The average delay per device. Ex: means[2] = average delay of device 2
% ~ stdDevs (σi): The standard deviation of delay per device. Ex: stdDevs[2] = standard deviation of delay of device 2
%
% Outputs:
% ~ minWorkReq: A boolean value representing if the minimum work
    % requirement has been met (sum from i=1 to n of wi*xi >= W). If false,
    % you should generally cancel the operation in the algorithm. 
% ~ totalMean: Overall average of minimal solution (μ)
% ~ A: Constant to denote gaussian error function
% ~ totalStd: Overal standard deviation of minimal solution (σ)

    % Finding the "such that" condition of P2
    n = length(x); % Number of devices
    workReq = sum(w(1:n) .* x(1:n)); % The sum of all work per chosen device (sum from 1:n of w(i) * x(i) ). Must be >= W
    if (workReq >= W) 
        minWorkReq = true;
    else
        minWorkReq = false;
    end

    % Finding μ
    totalMean = sum(means(1:n) .* x(1:n)); % Total average calculation, as per beginning of section IV. 
    
    % Finding A
    p = 0.99; % Confidence level, can try 95% later
    A = sqrt(2) * erfinv(2*p - 1); % Constant

    % Finding σ
    sigSqr = stdDevs.^2; % Squares each element, stores into another array
    totalStd = sqrt( sum(sigSqr(1:n) .* x(1:n)) ); % Total std dev calculation, as per beginning of section IV. 
    
end

%% Old code
%{
%A = 1:10;
%B = 2:11;
%mu = sum(A(1:4))
%A(1:4)
%mu = sum(A) * sum(B)

%m = sort(rand(1, 10),'descend')     %sample data

%x = [1 1 1 1 1 1 1 1 1 1];
%mui = [7 6 3 7 3 5 1 5 7 4];
%sigi = [8 9 7 5 9 4 5 2 3 9];

%done = false;
%while (~done) 

    %% result = fminsearch() ...

    %if (some condition)
    %    done = true;
    %end 

%end
%}
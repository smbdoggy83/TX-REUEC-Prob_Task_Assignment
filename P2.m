function [muTotal, A, sigmaTotal] = P2(n, W, w)
%% Represents equation P1
% Inputs: 
% ~ n: N edge devices
% ~ W: Total amount of work needed to meet or exceed. 
% ~ w (wi): Work accomplished per device. Ex: w[2] = work done by device 2
% ~ d (di): Network delays per device. Ex: d[2] = network delay for device 2
% Outputs:
% ~ muTotal: Overall average of minimal solution
% ~ 

%A = 1:10;
%B = 2:11;
%mu = sum(A(1:4))
%A(1:4)
%mu = sum(A) * sum(B)

%m = sort(rand(1, 10),'descend')     %sample data

x = [1 1 1 1 1 1 1 1 1 1];
mu = [7 6 3 7 3 5 1 5 7 4];
sig = [8 9 7 5 9 4 5 2 3 9];

%done = false;
%while (~done) 

    workReq = sum(w(1:n) .* x(1:n)); % The sum of all work per chosen device (sum from 1:n of w(i) * x(i) ). Must be >= W
    
    muTotal = sum(mu(1:n) .* x(1:n)); % Total average calculation, as per beginning of section IV. 
    
    sigSqr = sig.^2;
    sigmaTotal = sqrt( sum(sigSqr(1:n) .* x(1:n)) ); % Total sigma calculation, as per beginning of section IV. 
    
    p = 0.95; % Probability constant, just arbitrarily setting it to this for now
    A = sqrt(2) * erfinv(2*p - 1); % Constant
    
    % Check for minimum muTotal + A*sigmaTotal, return those variables
    
    %% result = fminsearch() ...

    %if (some condition)
    %    done = true;
    %end 

%end

end
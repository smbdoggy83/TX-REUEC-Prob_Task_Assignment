function [muTotal, A, sigmaTotal] = P2(n, W, w)

%A = 1:10;
%B = 2:11;
%mu = sum(A(1:4))
%A(1:4)
%mu = sum(A) * sum(B)

%m = sort(rand(1, 10),'descend')     %sample data

x = [1 1 1 1 1 1 1 1 1 1];
p = 0.95; % Probability constant, just arbitrarily setting it to this for now

workReq = sum(w(1:n) .* x(1:n)) % The sum of all work per chosen device (sum from 1:n of w(i) * x(i) ). Must be >= W

muTotal = sum(mu(1:n) .* x(1:n)) % Total average calculation, as per beginning of section IV. 

sigSqr = sig.^2
sigmaTotal = sqrt( sum(sigSqr(1:n) .* x(1:n)) ) % Total sigma calculation, as per beginning of section IV. 

A = sqrt(2) * erf(2p - 1)^-1 % Constant

% Check for minimum muTotal + A*sigmaTotal, return those variables

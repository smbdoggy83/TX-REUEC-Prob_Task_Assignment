function [deviceList, totalMean] = P3_2(k, W, u, o, w)
% k = the constraint
% W = min work
% w = work capability of each device (array)
% u = mean delay of each device (array)
% o = std dev of delay of each device (array)

numDevices = length(u); % n

% Preallocation
f = zeros(numDevices, 1);
intcon = zeros(1, numDevices);
A = zeros(1, numDevices); 

% Data Population + Formatting for intlinprog command
for i = 1:numDevices
    f(i) = u(i) + k*o(i)^2;     %f = [u(1) + k*o(1)^2; u(2) + k*o(2)^2; u(3) + k*o(3)^2...];
    intcon(1, i) = i;              %intcon = [1, 2, 3...];
    A(i) = -1*w(i);             %A = [-w(1), -w(2), -w(3)...];
end
%f
%intcon = [];
B = -W;
Aeq = [];
Beq = [];
lb = zeros(numDevices, 1);
ub = ones(numDevices, 1);
options=optimoptions(@intlinprog,'display','off');
[deviceList, totalMean] = intlinprog(f, intcon, A, B, Aeq, Beq, lb, ub, options);

end
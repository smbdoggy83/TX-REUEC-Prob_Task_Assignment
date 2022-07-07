function 
%clear all
%clc
%u = [50, 30, 60];
%o = [2, -3, 5];
%w = [165, 132, 187];
k = 0;
W = 500;
numDevices = 10;

dataTable = table;
[u, o, w] = DataGen(dataTable, numDevices)

% Preallocation
f = zeros(numDevices, 1);
intcon = zeros(1, numDevices);
A = zeros(1, numDevices); 

for i = 1:numDevices
    f(i) = u(i) + k*o(i)^2;     %f = [u(1) + k*o(1)^2; u(2) + k*o(2)^2; u(3) + k*o(3)^2...];
    intcon(1, i) = i;              %intcon = [1, 2, 3...];
    A(i) = -1*w(i);             %A = [-w(1), -w(2), -w(3)...];
end

intcon = [];
B = -W;
Aeq = [];
Beq = [];
lb = zeros(numDevices, 1);
ub = ones(numDevices, 1);
[x, totalMean] = intlinprog(f, intcon, A, B, Aeq, Beq, lb, ub)
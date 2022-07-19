%{
%% Represents equation P3. Uses intlinprog command to return the reduced search space
Requirements: w, x, means, and stdDevs should all be the same length.
Example: [deviceList, totalMean] = P3_2(0, 500, [], stdDevs, w)

Inputs: 
~ k: Coefficient used for solution searching. 
~ W: For condition 1, total amount of work needed to meet or exceed. Ex: 500
~ means (μi): The average delay per device. Ex: means[2] = average delay of device 2
~ stdDevs (σi): The standard deviation of delay per device. Ex: stdDevs[2] = standard deviation of delay of device 2
~ w (wi): Work accomplished per device. Ex: w[2] = work done by device 2

Outputs:
~ deviceList (X): A single array of devices that best matches the inputs.
    Minimizes μ + kσ while also making sure that the minimum work requirement
    W is met. 
~ totalMean: Overall average of minimal solution (μ)
%}
function [deviceList, totalMean] = P3_2(k, W, u, o, w)

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
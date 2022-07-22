%{
%% The RSS Algorithm reduces device combination search space of [0 ∞] to [0 h]. 

Inputs: 
~ means (μi): The average delay per device. Ex: means[2] = average delay
    of device 2 ~ stdDevs (σi): The standard deviation of delay
    per device. Ex: stdDevs[2] = standard deviation of delay of device 2 
~ w (wi): Work accomplished per device. Ex: w[2] = work done by device 2 
~ p: Confidence probability. Usually 99% or 95%, represented as 0.99 or 0.95 .
~ W: For condition 1, total amount of work needed to meet or exceed. Ex: 500 
~ x (xi): Chosen factor per device (1 = chosen, 2 = unchosen).  The paper
    refers to this as "vector X". Ex: x[2] = 1 --> device 2 was chosen.

Outputs: 
~ range: array representing search space. Should only have two items: [0, h]. 
~ X: array representing device combo at 0 and at h. Should only have two items: [X(0), X(h)]
%}
function [range, X] = RSS(means, stdDevs, works, A, W)

%1: "solve P3 at 0 to get X(0)"
n = length(means);
k = 0;
[X0, ~] = P3_2(0, W, means, stdDevs, works);
X0 = X0';

sigSqr = stdDevs.^2; % Squares each element, stores into another array
std = sqrt( sum(sigSqr(1:n) .* X0(1:n)) ); % std dev calculation of chosen devices, as per beginning of section IV. 

if std < .000001
    range = []
    X = []
    return
end
count = 1;
while (abs(k*std - A) > .001) %while (k*std ~= A) 
    disp("Loop #" + count + ": k * std is " + (k*std) + ", A is " + A);
    
    k = A / std;

    [X1, ~] = P3_2(k, W, means,stdDevs, works);
    X1 = rot90(X1);

    std = sqrt( sum(sigSqr(1:n) .* X1(1:n)) ); % std dev calculation of chosen devices, as per beginning of section IV. 
    if std < .000001
    range = [];
    X = [];
    return
end

    count = count + 1;
end

disp("Done after " + (count-1) + " loops. Final k * std was " + (k*std) + ", A is " + A);

h = k;

range = [0; h];
X = [X0; X1];
X = round(X);

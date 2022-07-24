function [] = displayResults(TotalMatch, BSTotalMatch, errorBS, cListAmts)
global cList

% accuracy
figure
bar(categorical({'FMS Match Rate', 'BS Match Rate'}), [TotalMatch BSTotalMatch]);

% difference
%disp("Final error is " + errorBS(end).percent);

% difference in c/k values
%figure
%ListOut = zeros(10, 10);
%cListOut(1) = [2]
%cListOut(2, 1:4) = [1, 4, 0, 3]
%cListOut(3, 1:4) = [2 7 1 6]
%cListAmts
T = array2table(cListAmts, 'VariableNames', {'10', '12', '14', '16', '18', '20'}, 'RowNames', {'Brute Force', 'FMS', 'FMS w/ BS'})
%plot(10:2:20, [cListAmts(1); cListAmts(2) cListAmts(3)]);
%legend('Brute Force', 'FMS', 'FMS using BS')


end
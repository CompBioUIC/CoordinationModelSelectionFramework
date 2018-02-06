function [ trainFilter,testFilter ] = FindCrossValidationInx2( M )
%FINDCROSSVALIDATIONINX Summary of this function goes here
%   Detailed explanation goes here
% N is a number of coordination events
indices = crossvalind('Kfold',M,10);
for i = 1:10
    testVal = (indices == i); trainVal = ~testVal;
    testFilter{i}=testVal;
    trainFilter{i}=trainVal;
end 

end


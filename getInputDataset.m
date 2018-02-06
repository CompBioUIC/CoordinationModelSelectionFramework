function [ trainDataSet,testDataSet ] = getInputDataset(inputpath,inputPrefix,TrTestRatio)
%GETINPUTDATASET Summary of this function goes here
%   Detailed explanation goes here
FileRXP=sprintf('%s/%s*.mat',inputpath,inputPrefix);
fileList=dir( fullfile('',FileRXP) );
[ test,train] = crossvalind('HoldOut', length(fileList), TrTestRatio);
tr=1;
te=1;
for i=1:length(fileList)
    clear TrajectoryXY
    str=sprintf('%s/%s',inputpath,fileList(i).name);
    load(str);
    if train(i)
        trainDataSet{tr}=TrajectoryXY;
        tr=tr+1;
    else
        testDataSet{te}=TrajectoryXY;
        te=te+1;
    end
end

end


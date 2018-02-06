function [ nDataSet,nClass ] = getFishInputDataset(inputpath,inputPrefix)
%GETINPUTDATASET Summary of this function goes here
%   Detailed explanation goes here
FileRXP=sprintf('%s/%s*.mat',inputpath,inputPrefix);
fileList=dir( fullfile('',FileRXP) );
for i=1:length(fileList)
    clear TrajectoryXY
    str=sprintf('%s/%s',inputpath,fileList(i).name);
    load(str);
    nDataSet{i}=TrajectoryXY;
    nClass{i}=InformedFishVec(:);
end

end


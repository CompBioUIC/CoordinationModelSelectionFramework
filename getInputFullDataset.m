function [ trainSuperDataSet ] = getInputFullDataset(inputpath,inputPrefix)
FileRXP=sprintf('%s/%s*.mat',inputpath,inputPrefix);
fileList=dir( fullfile('',FileRXP) );

trainDataSet={};
tr=1;
for i=1:length(fileList)
    clear TrajectoryXY
    str=sprintf('%s/%s',inputpath,fileList(i).name);
    load(str);
    trainDataSet{tr}=TrajectoryXY;
    tr=tr+1;
end
trainSuperDataSet{1}=trainDataSet;

end



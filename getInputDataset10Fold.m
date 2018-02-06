function [ trainSuperDataSet,testSuperDataSet ] = getInputDataset10Fold(inputpath,inputPrefix)
FileRXP=sprintf('%s/%s*.mat',inputpath,inputPrefix);
fileList=dir( fullfile('',FileRXP) );

N=length(fileList);
[ trainFilter,~ ] = FindCrossValidationInx2( N );
for k=1:10
    trainDataSet={};
    testDataSet={};
    train=trainFilter{k};
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
    trainSuperDataSet{k}=trainDataSet;
    testSuperDataSet{k}=testDataSet;
end

end


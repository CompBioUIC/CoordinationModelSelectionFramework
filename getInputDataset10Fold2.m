function [ trainSuperDataSet,testSuperDataSet ] = getInputDataset10Fold2(traWin,timeShiftWin,LamdaTHS,inputpath,outputPath)
DataOut=FLICAfunc( traWin,timeShiftWin, inputpath,outputPath,LamdaTHS);
load(inputpath);
N=length(DataOut.NetPeriods);
[ trainFilter,~ ] = FindCrossValidationInx2( N );
for k=1:10
    trainDataSet={};
    testDataSet={};
    train=trainFilter{k};
    tr=1;
    te=1;
    for i=1:N
        st=DataOut.NetPeriods(i,1);
        fn=DataOut.NetPeriods(i,3);
        nTrajectoryXY{1}=TrajectoryXY{1}(:,st:fn);
        nTrajectoryXY{2}=TrajectoryXY{2}(:,st:fn);
        if train(i)
            trainDataSet{tr,1}=nTrajectoryXY;
            %trainDataSet{tr,2}=DataOut.CorrMat(:,:,st:fn);
            tr=tr+1;
        else
            testDataSet{te,1}=nTrajectoryXY;
            %testDataSet{te,2}=DataOut.CorrMat(:,:,st:fn);
            te=te+1;
        end
    end
    trainSuperDataSet{k}=trainDataSet;
    testSuperDataSet{k}=testDataSet;
end

end


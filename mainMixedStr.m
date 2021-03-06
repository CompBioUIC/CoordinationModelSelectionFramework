clear
inputpath='MixedStrPr0.50';
%inputpath='LRA_F1.00';
inputPrefix='TrajectoryXY';
%outputPath=sprintf('%s/DataOut.mat');
TrTestRatio=0.9; % Train 90% test 10%
trnValRatio=0.5; % train 50% validation 50%
%TWsearchSpace=15:15:90;
TWopt=60;
[ trainSuperDataSet,testSuperDataSet ] = getInputDataset10Fold(inputpath,inputPrefix);
kTrnValModelInfo={};
kTestResult={};
errOPT=0;
errLocal=0;
errHin=0;
errR=0;
parfor k=1:10 % 10 fold validation
    trainDataSet=trainSuperDataSet{k};
    testDataSet=testSuperDataSet{k};
    [ TrnValModelInfo ] = CoGIFfunc( trainDataSet,trnValRatio,TWopt  );
    [ TestResult ] = TestModelPredict(TrnValModelInfo,testDataSet);
    kTrnValModelInfo{k}=TrnValModelInfo;
    kTestResult{k}=TestResult;
    errOPT=errOPT+nanmean(nanmean(TestResult.errOPTMat))
    errHin=errHin+nanmean(nanmean(TestResult.errMats {1}))
    errLocal=errLocal+nanmean(nanmean(TestResult.errMats {2}))
    errR=errR+nanmean(nanmean(TestResult.errMats {3}))
end
errOPT=errOPT/10.0;
errLocal=errLocal/10.0;
errHin=errHin/10.0;
errR=errR/10.0;
filename = sprintf('%s.mat',inputpath);
save(filename);
mainLRA
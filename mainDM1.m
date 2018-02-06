clear
inputpath='DM_F1.00PR1.00';
%inputpath='LRA_F1.00';
inputPrefix='TrajectoryXY';
%outputPath=spriMixedStrntf('%s/DataOut.mat');
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
parfor k=1:10 % 10 fold validation
    trainDataSet=trainSuperDataSet{k};
    testDataSet=testSuperDataSet{k};
    %[ trainDataSet,testDataSet] = getInputDataset(inputpath,inputPrefix,TrTestRatio);
    % OPTList=zeros(1,25);
    % maxList=zeros(1,25);
    % parfor i=1:25
    % [ TWopt,maxPsi ] = searchTWopt( trainDataSet,TWsearchSpace  );
    % OPTList(i)=TWopt;
    % maxList(i)=maxPsi;
    % end
    [ TrnValModelInfo ] = CoGIFfunc( trainDataSet,trnValRatio,TWopt  );
    [ TestResult ] = TestModelPredict(TrnValModelInfo,testDataSet);
    kTrnValModelInfo{k}=TrnValModelInfo;
    kTestResult{k}=TestResult;
    errOPT=errOPT+nanmean(nanmean(TestResult.errOPTMat))
    errHin=errHin+nanmean(nanmean(TestResult.errMats {1}))
    errLocal=errLocal+nanmean(nanmean(TestResult.errMats {2}))
end
errOPT=errOPT/10.0; % direction prediction risk values from our framework
errLocal=errLocal/10.0; % direction prediction risk values LRA strategy function
errHin=errHin/10.0; % direction prediction risk values HM strategy function
filename = sprintf('%s.mat',inputpath);
save(filename);
mainDM2
clear
inputpath='Baboon/BaboonTrajectoryXY.mat';
outputPath='Baboon/FLICANetDataBaboonTW240TS12.mat';

addpath('FLICAoriginalV.1.6')
%inputpath='LRA_F1.00';
inputPrefix='TrajectoryXY';
%outputPath=sprintf('%s/DataOut.mat');
TrTestRatio=0.9; % Train 90% test 10%
trnValRatio=0.5; % train 50% validation 50%
%TWsearchSpace=15:15:90;

SingleTimeSeriesFlag=1;

 TWopt=60; % new framework parameter
traWin = 240;
timeShiftWin= floor(traWin*0.1);

LamdaTHS=25;
coGameOutputPath=sprintf('Baboon/BaboonResTHS%d.mat',LamdaTHS);
if SingleTimeSeriesFlag ==0
    [ trainSuperDataSet,testSuperDataSet ] = getInputDataset10Fold(inputpath,inputPrefix);
else
    [ trainSuperDataSet,testSuperDataSet ] = getInputDataset10Fold2(traWin,timeShiftWin,LamdaTHS,inputpath,outputPath);
end
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
    errOPT=errOPT+nanmean(nanmean(TestResult.errOPTMat));
    errHin=errHin+nanmean(nanmean(TestResult.errHinMat));
    errLocal=errLocal+nanmean(nanmean(TestResult.errLocalMat));
end
errOPT=errOPT/10.0;
errLocal=errLocal/10.0;
errHin=errHin/10.0;

save(coGameOutputPath,'-v7.3');
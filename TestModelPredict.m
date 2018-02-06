function [ TestResult ] = TestModelPredict(TrnValModelInfo,testDataSet)
%TESTMODELPREDICT Summary of this function goes here
%   Detailed explanation goes here
M=length(testDataSet);
ValdInfo=TrnValModelInfo.ValdInfo;
nTrajectoryXY=testDataSet{1};
for i=2:M
    TrajectoryXY=testDataSet{i};
    nTrajectoryXY{1}=[nTrajectoryXY{1},TrajectoryXY{1}];
    nTrajectoryXY{2}=[nTrajectoryXY{2},TrajectoryXY{2}];
end
flag=2;
ModelExtension;
M1= length(TrnValModelInfo.ModelInfo.gMats);
[N,T]=size(DirMat);
errOPTMat=zeros(N,T);
for itr=1:M1
    errMats{itr}=zeros(N,T);
end

for ID=1:N
    %filter=~( isnan(ModelInfo.ghinMat(ID,:))| isnan(ModelInfo.glocalMat(ID,:))|isnan(ModelInfo.gilMat(ID,:)) | isnan(ModelInfo.grMat(ID,:)) | isnan(ModelInfo.DirMat(ID,:)));
    ActualVec=DirMat(ID,:)';
    modelMat=[];
    for itr=1:M1
        modelMat=[modelMat,gMats{itr}(ID,:)'];
    end
    PredVec=ValdInfo.Wopt(ID,:)*modelMat';
    errOPTMat(ID,:)=degDist(ActualVec',PredVec);
    for itr=1:M1
        selVec=zeros(1,M1);
        selVec(itr)=1;
        PredVec=selVec*modelMat';
        errMats{itr}(ID,:) = degDist(ActualVec',PredVec);
    end
end

TestResult.errOPTMat=errOPTMat;
TestResult.errMats=errMats;
    
end




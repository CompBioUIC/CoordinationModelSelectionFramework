function [ DataRes,ErrorDist ] = getDirectionPrediction( nDataSet,nClass )
%GETDIRECTIONPREDICTION Summary of this function goes here
%   Detailed explanation goes here
M=length(nDataSet);
globalErrLocalDist=[];
globalErrInformedDist=[];
for i=1:M
    TrajectoryXY=nDataSet{i};
    classVec=nClass{i};
    
    [ DirMat ] = DirectionExtractor( TrajectoryXY );
    [ glocalMat ] = LocalNeighborNetPredict( TrajectoryXY,DirMat );
    [ ginformedMat ] = InformedNeighborNetPredict( TrajectoryXY,DirMat,classVec );
    [errLocalDist,errInformedDist]=getErrorDist(DirMat,glocalMat,ginformedMat);
    
    DataRes{i}.DirMat=DirMat;
    DataRes{i}.glocalMat=glocalMat;
    DataRes{i}.ginformedMat=ginformedMat;
    DataRes{i}.errLocalDist=errLocalDist;
    DataRes{i}.errInformedDist=errInformedDist;
    globalErrLocalDist=[globalErrLocalDist,errLocalDist];
    globalErrInformedDist=[globalErrInformedDist,errInformedDist];
    
end
globalErrLocalDist(isnan(globalErrLocalDist))=[];
globalErrInformedDist(isnan(globalErrInformedDist))=[];
ErrorDist.globalErrLocalDist=globalErrLocalDist;
ErrorDist.globalErrInformedDist=globalErrInformedDist;
end


function [errDistA,errDistB]=getErrorDist(DirMat,A,B)
[N,T]=size(DirMat);
errAMat=zeros(N,T);
errBMat=zeros(N,T);
for ID=1:N
    %filter=~( isnan(ModelInfo.ghinMat(ID,:))| isnan(ModelInfo.glocalMat(ID,:))|isnan(ModelInfo.gilMat(ID,:)) | isnan(ModelInfo.grMat(ID,:)) | isnan(ModelInfo.DirMat(ID,:)));
    ActualVec=DirMat(ID,:)';
    Mat=[A(ID,:)',B(ID,:)']';
    PredVec=[1,0]*Mat;
    errAMat(ID,:)=degDist(ActualVec',PredVec);
    PredVec=[0,1]*Mat;
    errBMat(ID,:)=degDist(ActualVec',PredVec);
end
errDistA=errAMat(:)';
errDistB=errBMat(:)';
end
function [ ValdInfo ] = ModelSelection2( valSet,ModelInfo,TS )
%MODELSELECTION Summary of this function goes here
%   Detailed explanation goes here
if (~exist('TS','var') || isempty(TS))
    TS=ModelInfo.TWopt;
end
M=length(valSet);
nTrajectoryXY=valSet{1};
for i=2:M
    TrajectoryXY=valSet{i};
    nTrajectoryXY{1}=[nTrajectoryXY{1},TrajectoryXY{1}];
    nTrajectoryXY{2}=[nTrajectoryXY{2},TrajectoryXY{2}];
end

flag=1;
ModelExtension;

M=size(ModelInfo.KappaTHSVec,1);
T=size(DirMat,2);
N=ModelInfo.N;
errMatList={};
scoreMat=zeros(N,M);
D=size(ModelInfo.W{1},2);
for i=1:M
    WVec=ModelInfo.W{i};
    errMat=zeros(N,T);
    for ID=1:N
        %filter=~( isnan(ModelInfo.ghinMat(ID,:))| isnan(ModelInfo.glocalMat(ID,:))|isnan(ModelInfo.gilMat(ID,:)) | isnan(ModelInfo.grMat(ID,:)) | isnan(ModelInfo.DirMat(ID,:)));
        ActualVec=DirMat(ID,:)';
        modelMats = [];
        for itr=1:length(gMats)
            modelMats=[modelMats,gMats{itr}(ID,:)'];
        end
        PredVec=WVec(ID,:)*modelMats';
        errMat(ID,:)=abs(ActualVec'-PredVec);
        for k=1:length(errMat(ID,:))
            if errMat(ID,k)>180
                errMat(ID,k)=360-errMat(ID,k);
            end
        end
    end
    errMatList{i}=errMat;
    scoreMat(:,i)=nanmean(errMat,2);
end
[~,OPTmodel]=min(scoreMat');
ValdInfo.errMatList=errMatList;
ValdInfo.scoreMat=scoreMat;
ValdInfo.OPTmodel=OPTmodel;
ValdInfo.avgNeighborMat=avgNeighborMat;
Wopt=zeros(N,D);
for i=1:N
    Wopt(i,:)=ModelInfo.W{OPTmodel(i)}(i,:);
end
ValdInfo.Wopt=Wopt;

[ prINFLNet2,fullprINFLNet2,InitRankOrderMat2  ] = GetProbInfluenceNet3( DirMat,ModelInfo.TWopt,TS );
ValdInfo.prINFLNet=prINFLNet2;
ValdInfo.fullprINFLNet=fullprINFLNet2;
ValdInfo.InitRankOrderMat=InitRankOrderMat2;

end


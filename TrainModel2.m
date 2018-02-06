function [ModelInfo]= TrainModel2(trSet,TWopt,TS)
if (~exist('TS','var') || isempty(TS))
    TS=TWopt;
end
M=length(trSet);
nTrajectoryXY=trSet{1};
N=size(nTrajectoryXY{1},1);
for i=2:M
    TrajectoryXY=trSet{i};
    nTrajectoryXY{1}=[nTrajectoryXY{1},TrajectoryXY{1}];
    nTrajectoryXY{2}=[nTrajectoryXY{2},TrajectoryXY{2}];
end
flag=0;
ModelExtension; % ==== add model here

M1=length(gMats);

KappaTHSVec(1,:)=zeros(1,M1);
k=2;
for itr1=2:(M1+1)
    KappaTHSVec(k,:)=zeros(1,M1);
    KappaTHSVec(k,itr1-1)=0.5;
    k=k+1;
end
for itr1=2:(M1+1)
    KappaTHSVec(k,:)=[0,0,0];
    KappaTHSVec(k,itr1-1)=1;
    k=k+1;
end

ModelInfo.N=N;
ModelInfo.DirMat=DirMat;
ModelInfo.gMats=gMats;
ModelInfo.InitRankOrderMat=InitRankOrderMat;
ModelInfo.prINFLNet=prINFLNet;
ModelInfo.nTrajectoryXY=nTrajectoryXY;
ModelInfo.KappaTHSVec=KappaTHSVec;
ModelInfo.W=GetModelFitting(KappaTHSVec,ModelInfo);
ModelInfo.fullprINFLNet=fullprINFLNet;
ModelInfo.TWopt=TWopt;
ModelInfo.avgNeighborMat=avgNeighborMat;
end

function [W]=GetModelFitting(KappaTHSVec,ModelInfo)
N=ModelInfo.N;
M1=length(ModelInfo.gMats);
for i=1:max(size(KappaTHSVec))
    WVec=zeros(N,max(size(KappaTHSVec(i,:))));
    for ID=1:N
        filter = isnan(ModelInfo.DirMat(ID,:));
        for itr=1:M1
            filter=filter | isnan(ModelInfo.gMats{itr}(ID,:)) ;% ~( | isnan(ModelInfo.glocalMat(ID,:)) | isnan(ModelInfo.grMat(ID,:)) | isnan(ModelInfo.DirMat(ID,:)));
        end
        filter=~filter;
        XMat=ModelInfo.DirMat(ID,filter)';
        GMat=[];
        for itr=1:M1
            GMat=[GMat,ModelInfo.gMats{itr}(ID,filter)'];
        end
        %GMat=[ModelInfo.ghinMat(ID,filter)',ModelInfo.glocalMat(ID,filter)',ModelInfo.grMat(ID,filter)'];
        [ w ] = ModelWeightFitting( GMat,XMat,KappaTHSVec(i,:) );
        WVec(ID,:)=w;
    end
    W{i}=WVec;
end

end


function [ TrnValModelInfo ] = CoGIFfunc( trainDataSet,trnValRatio,TWopt,TS  )
%COGIFFUNC Summary of this function goes here
%   Detailed explanation goes here
if (~exist('TS','var') || isempty(TS))
    TS=TWopt;
end
[ validate,train] = crossvalind('HoldOut', length(trainDataSet), trnValRatio);
trSet=trainDataSet(train);
valSet=trainDataSet(validate);

[ModelInfo]= TrainModel2(trSet,TWopt,TS);
[ ValdInfo ] = ModelSelection2( valSet,ModelInfo,TS );
TrnValModelInfo.ModelInfo=ModelInfo;
TrnValModelInfo.ValdInfo=ValdInfo;

InitRankOrderMat=ModelInfo.InitRankOrderMat+ValdInfo.InitRankOrderMat;
[~,inxVec]=sort(InitRankOrderMat);
rankVec=1:length(inxVec);
[InitRankOrderMat(inxVec,1)] =rankVec;
TrnValModelInfo.InitRankOrderMat=InitRankOrderMat;

fullprINFLNet=(ModelInfo.fullprINFLNet+ValdInfo.fullprINFLNet)/2;
prINFLNet=fullprINFLNet;
N=size(prINFLNet,1);
for i=1:N % Normalize the Net to DAG with the total order of InitRankOrderMat(ID); if DI16=leader, then InitRankOrderMat(ID)=1
    for j=1:N
        if i~=j && InitRankOrderMat(i)<InitRankOrderMat(j)
            prINFLNet(i,j)=0;
        end
    end
end

TrnValModelInfo.fullprINFLNet=fullprINFLNet;
TrnValModelInfo.prINFLNet=prINFLNet;

end




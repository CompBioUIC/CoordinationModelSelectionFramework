function [ prINFLNet,fullprINFLNet,InitRankOrderMat ] = GetProbInfluenceNet3( DirMat,TWopt,TS )
%CREATEPROBINFLUENCENET Summary of this function goes here
%   Detailed explanation goes here
if (~exist('TS','var') || isempty(TS))
    TS=TWopt;
end
addpath('FLICAoriginalV.1.6')
N=size(DirMat,1);
prINFLNet=zeros(N,N);
InitRankOrderMat=zeros(N,1);

TrajectoryXY{1}=DirMat;
TrajectoryXY{2}=zeros(size(DirMat));

[CorrMat,~,RankMat] = CreateMatFromTrajectory(TrajectoryXY,TS,TWopt);

fullprINFLNet=nanmean(CorrMat,3);
InitRankOrderMat= RankMat2GlobalRankList( RankMat );
[ prINFLNet ] = TrimMAT2TDAG( fullprINFLNet,InitRankOrderMat );

rmpath('FLICAoriginalV.1.6');
end


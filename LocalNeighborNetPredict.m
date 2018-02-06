function [ glocalMat,avgNeighborMat ] = LocalNeighborNetPredict( TrajectoryXY,DirMat )
%HIRCINFLUENCEPREDICT Summary of this function goes here
%   Detailed explanation goes here
[N,T]=size(DirMat);
glocalMat=zeros(N,T);
avgNeighborMat=zeros(N,1);
for t=2:T
    Xpos=TrajectoryXY{1,1}(:,t);
    Ypos=TrajectoryXY{1,2}(:,t);
    [ DelaunayAdjMat ] = GetDelaunayNeighborsNet( [Xpos,Ypos] );
    neighborVec=zeros(N,1);
    for i=1:N
        
        currRow=DelaunayAdjMat(i,:);
        currRow(i)=1; % add self to the set of neighbors
        currRowSum=sum(currRow);
        
        currRow=currRow/currRowSum;
        prevDirVec=DirMat(:,t-1);
        
        glocalMat(i,t)=currRow*prevDirVec;
        neighborVec(i)=neighborVec(i)+sum(sum(DelaunayAdjMat(i,:)));
    end
    avgNeighborMat=avgNeighborMat+neighborVec;
end
avgNeighborMat=avgNeighborMat/(T-1);
end


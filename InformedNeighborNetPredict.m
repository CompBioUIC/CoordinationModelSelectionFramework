function [ ginformedMat ] = InformedNeighborNetPredict( TrajectoryXY,DirMat,classVec )
%HIRCINFLUENCEPREDICT Summary of this function goes here
%   Detailed explanation goes here
[N,T]=size(DirMat);
ginformedMat=zeros(N,T);
parfor t=2:T
    Xpos=TrajectoryXY{1,1}(:,t);
    Ypos=TrajectoryXY{1,2}(:,t);
    for i=1:N
        
        currRow=classVec(:)';
        %currRow(i)=1; % add self to the set of neighbors
        currRowSum=sum(currRow);
        
        currRow=currRow/currRowSum;
        prevDirVec=DirMat(:,t-1);
        
        ginformedMat(i,t)=currRow*prevDirVec;
    end
end

end


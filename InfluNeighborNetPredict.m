function [ ghinMat ] = InfluNeighborNetPredict( AdjNet,DirMat )
%HIRCINFLUENCEPREDICT Summary of this function goes here
%   Detailed explanation goes here
[N,T]=size(DirMat);
ghinMat=zeros(N,T);
parfor t=2:T
    for i=1:N
        currRow=AdjNet(i,:);
        currRow(i)=1; % add self to the set of neighbors
        currRowSum=sum(currRow);
        
        currRow=currRow/currRowSum;
        prevDirVec=DirMat(:,t-1);
        
        ghinMat(i,t)=currRow*prevDirVec;
    end
end

end


function [ InitRankOrderMat ] = RankMat2GlobalRankList( RankMat )
%RANKMAT2GLOBALRANKLIST Summary of this function goes here
%   Detailed explanation goes here
N=size(RankMat,1);
[sortList,inx]=sort(nanmean(RankMat,2),'descend');
InitRankOrderMat=zeros(N,1);
list=1:N;
r=1;
InitRankOrderMat(inx(1))=r;
for i=2:N
if sortList(i)~=sortList(i-1)
r=r+1;
end
InitRankOrderMat(inx(i))=r;
end

end


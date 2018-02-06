function [ DirMat ] = DirectionExtractor( TrajectoryXY )
%DIRECTIONEXTRACTOR Summary of this function goes here
%   Detailed explanation goes here
% TrajectoryXY 

[N,T]=size(TrajectoryXY{1,1});
DirMat=zeros(N,T);

for t=2:T
    for i=1:N
        Xprev=TrajectoryXY{1,1}(i,t-1);
        Yprev=TrajectoryXY{1,2}(i,t-1);
        
        Xcurr=TrajectoryXY{1,1}(i,t);
        Ycurr=TrajectoryXY{1,2}(i,t);
        
        unitVec=[Xcurr-Xprev,Ycurr-Yprev];
        deg=UnitVec2Deg( unitVec );
        DirMat(i,t)=deg;
    end
end


end


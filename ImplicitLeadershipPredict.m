function [ gilMat ] = ImplicitLeadershipPredict( TrajectoryXY,DirMat,c )
%IMPLICITLEADERSHIPPREDICT Summary of this function goes here
%   Detailed explanation goes here
% c1 is the weight for the group centroid of position
% c2 is the weight for the group centroid of direction
% c2=1-c1; c1=c
if (~exist('c','var') || isempty(c)),
    c=0.5;
end

[N,T]=size(DirMat);
gilMat=zeros(N,T);
parfor t=2:T

    XGcurr=TrajectoryXY{1,1}(:,t);
    YGcurr=TrajectoryXY{1,2}(:,t);

    posCentroid=[nanmean(XGcurr),nanmean(YGcurr)];
    DirCentroid=nanmean(DirMat(:,t));
    for i=1:N
        Xcurr=TrajectoryXY{1,1}(i,t);
        Ycurr=TrajectoryXY{1,2}(i,t);
        unitVec=[posCentroid(1)-Xcurr,posCentroid(2)-Ycurr];
        dirPosCentroid=UnitVec2Deg( unitVec );
        dirDirCentroid=DirCentroid-DirMat(i,t-1);
        if dirDirCentroid>180
            dirDirCentroid=dirDirCentroid-360;
        elseif dirDirCentroid<-180
            dirDirCentroid=180-abs(180+dirDirCentroid);
        end
        gilMat(i,t)=c*dirPosCentroid+(1-c)*dirDirCentroid;
        
    end
end

end


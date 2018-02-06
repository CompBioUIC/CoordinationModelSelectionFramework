function [ TWopt,maxPsi ] = searchTWopt( trainDataSet,TWsearchSpace  )
%COGIFFUNC Summary of this function goes here
%   Detailed explanation goes here
if max(size(TWsearchSpace))==1
    TWopt=TWsearchSpace;
else
    addpath('MFLICAframeworkV.1.1')
    maxPsi=0;
    inx=randi([1,length(trainDataSet)],1,1);
    TWopt=TWsearchSpace(1);
    for i=1:max(size(TWsearchSpace))
        TW=TWsearchSpace(i);
        TrajectoryXY=trainDataSet{inx};
        [CorrMat,~,RankMat] = CreateMatFromTrajectoryTHS(TrajectoryXY,TW,TW);
        [ ~,dyGroupMat,~,~ ] = DetectDyFollowingGroups( CorrMat,RankMat );
        [ avgPsi,~ ] = averageCoordinationMeasureFunc( dyGroupMat,CorrMat );
        if maxPsi<avgPsi
            maxPsi=avgPsi;
            TWopt=TW;
        end
    end
    rmpath('MFLICAframeworkV.1.1')
end

end



gMats={};
[ DirMat ] = DirectionExtractor( nTrajectoryXY );
if flag == 0 % training
    [ prINFLNet,fullprINFLNet,InitRankOrderMat ] = GetProbInfluenceNet3(DirMat,TWopt,TS );
    [ gMats{1}  ] = InfluNeighborNetPredict( prINFLNet,DirMat );
elseif flag==1 % validation
    [ gMats{1} ] = InfluNeighborNetPredict( ModelInfo.prINFLNet,DirMat );
    TWopt=ModelInfo.TWopt;
else % testing 
    [ gMats{1}] = InfluNeighborNetPredict( TrnValModelInfo.prINFLNet,DirMat );
    TWopt=TrnValModelInfo.ModelInfo.TWopt;
end

[ gMats{2},avgNeighborMat ] = LocalNeighborNetPredict( nTrajectoryXY,DirMat );
[ gMats{3} ] = AutoRegressionPredict( DirMat,int64( floor(TWopt*0.1) ));


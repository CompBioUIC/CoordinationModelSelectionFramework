% The Framework of Multiple-Faction Leadership in Coordinated Activity  Inference (MFLICA)
% This source code is intent to support ICDM 2017 blind review process
% This is the main script of MFLICA for inferring multiple faction
% intervals
% INPUT DATA
% inputFilename is the input file containing 'TrajectoryXY'
% 'TrajectoryXY'a set of two-dimensional Time series 
% TrajectoryXY{1,1} M time series (X axis coordinate) where T is the time-series length
% TrajectoryXY{1,2} M time series (Y axis coordinate) where T is the time-series length
% INPUT PARAMETERS
%  1) traWin is a time window parameter (\omega)
%  2) timeShiftWin is a time shift parameter (\delta)
%  3) sigmaTHS is a similarity threshold (\sigma) 
inputFilename='TrajectoryXY1.mat';
outputFilename='NetData1_new.mat';
traWin=30; % Suggestion: choose the traWin that maximizes avgPsi (see the output description below)
timeShiftWin=floor(0.1*traWin);
sigmaTHS=0.5; 
[ DataOut ] = MFLICAfunc2( inputFilename,outputFilename,traWin,timeShiftWin,sigmaTHS);

% OUTPUTS Decription ==========================================================================
%NetDVec: A following network density which has a length T. NetDVec(t) is a network density value at time t
DataOut.NetDVec; 
%CorrMat: If CorrMat(A,B,t)>0, individual A follows B at time step t with the weight CorrMat(A,B,t). This value is bound within [-1,1]
DataOut.CorrMat;
%RankMat: RankMat(A,t) is a PageRank value of individual A at time t.
DataOut.RankMat;

% dyGroupDensityMat: the faction  size  ratio (EQ.3) where dyGroupDensityMat(i,t) is the faction  size  ratio of a faction leading by i at time t
DataOut.dyGroupDensityMat;
%dyLeaderMat: dyLeaderMat{t}(i) is an initiator of ith faction at time t
DataOut.dyLeaderMat
%dyGroupMat: dyGroupMat{t}{i} is a set of ID of ith faction at time t where  ismember(k,DataOut.dyGroupMat{t}{i}) is true if ID(k) is a member of ith faction at time t
DataOut.dyGroupMat
% dyRankedIDMat: dyRankedIDMat{t}{i}(j) is a rank of individual ID(dyGroupMat{t}{i}(j)) who is a member of ith faction at time t 
DataOut.dyRankedIDMat;

% PsiDensity: a time series of average coordination measure w.r.t. time window \omega
DataOut.PsiDensity;
% =========================== Choose traWin following this result ========================================
% avgPsi: ($\hat{\Psi}_{\omega}$ in the paper) the median of average coordination measure time series PsiDensity w.r.t. time window \omega. Higher avgPsi implies a better time window \omega to infer following relations 
DataOut.avgPsi;
%=========================================================================================================

% ============ The main output of factions inference
% predMasterMat: the prediction of faction assignment from the framework
% This matrix encodes infomation about faction membership, faction interval, and initiators. 
% predMasterMat(k,t) == i if ID(k) is belong to a faction leading by ID(i) at time t.
% Note that predMasterMat(k,t) == -1 if ID(k) does not move.
% predMasterMat(k,t) == 0 if ID(k) is an initiator.
% predMasterMat(k,t) == predMasterMat(q,t) if ID(k) and ID(q) are in the same faction ta time t. 
DataOut.predMasterMat;

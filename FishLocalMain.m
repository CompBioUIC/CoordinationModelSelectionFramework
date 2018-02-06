%clear
inputpath='Fish';
inputPrefix='TrajectoryXY';
alpha=0.001;
% [ nDataSet,nClass ] = getFishInputDataset(inputpath,inputPrefix);
% 
% [ DataRes,ErrorDist ] = getDirectionPrediction(nDataSet,nClass);

%=== plot
C = [ErrorDist.globalErrLocalDist',ErrorDist.globalErrInformedDist'];
grp = [zeros(1,length(ErrorDist.globalErrLocalDist)),ones(1,length(ErrorDist.globalErrInformedDist))];
localstr=sprintf('Local Model: Median = %.2f',median(ErrorDist.globalErrLocalDist));
informedstr=sprintf('Informed Model: Median = %.2f',median(ErrorDist.globalErrInformedDist));
boxplot(C,grp,'labels',{localstr,informedstr});

str=sprintf('Fish Stratety prediction');
title(str)
xlabel('Model')
ylabel('Degree Error')
ylim([0 180])

% [ ~,localHNPmat ] = HtestFunc( ErrorDist.globalErrLocalDist,alpha );
% [ ~,informedHNPmat ] = HtestFunc( ErrorDist.globalErrInformedDist,alpha );
%Ci(:,1) ==mean Ci(:,2) == std, Ci(1,:) lower bound, Ci(2,:) upperbound
% localCi=paramci(fitdist(ErrorDist.globalErrLocalDist','Normal'),'Alpha',alpha);
% informedCi=paramci(fitdist(ErrorDist.globalErrInformedDist','Normal'),'Alpha',alpha);
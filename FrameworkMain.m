clear
%=========================== Input and parameter setup
 % In our demo, all coordination-event time series come from HM strategy model 
 % where everyone follows ID1
 % If you want to use coordination-event time series
 % from LRA as inputs, please set inputpath='LRA_F1.00';
inputpath='DM_F1.00PR1.00';
inputPrefix='TrajectoryXY';
trnValRatio=0.5; % train 50% validation 50%
TWopt=60; % Time window parameter to create following networks in HM strategy function 

%========================================== Main computation
% load inputs from inputpath (each TrajectoryXY#.mat contains a single coordination event)
[ trainSuperDataSet ] = getInputFullDataset(inputpath,inputPrefix);

trainDataSet=trainSuperDataSet{1};

% Our main framework function is here.
[ TrnValModelInfo ] = CoGIFfunc( trainDataSet,trnValRatio,TWopt  );


% Output of model selection for each individual is in Wopt matrix below
% Where Wopt(i,:) represent support vector of individual i
% Wopt(i,1) is a support value of HM strategy model, 
% Wopt(i,2) is a support value of LRA strategy model, 
% % Wopt(i,3) is a support value of Auto regressive strategy model, 
Wopt=TrnValModelInfo.ValdInfo.Wopt;

% HierarchyNet is a predicted probabilistic influence network  $\mathcal{G}=(\mathcal{V},\mathcal{E})$
% If $i$ follows $j$ 90\% of the time, then  $(i,j) \in \mathcal{E}$ where $p_{j,i}=0.9$.
HierarchyNet=TrnValModelInfo.prINFLNet;

filename = sprintf('%sDemoResult.mat',inputpath); % save output
save(filename);

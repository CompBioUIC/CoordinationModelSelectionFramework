function [ WVec ] = ModelWeightFitting( GMat,XMat,KappaTHSVec )
%MODELWEIGHTFITTING Summary of this function goes here
%   Detailed explanation goes here
% GMat: TxM mat
% XMat: TxM mat, unit degree, radius =1 (unit vector)
% KappaTHSVec: 1xM mat
% Wvec: Mx1 mat
M=max(size(KappaTHSVec));

A =diag(-1*ones(1,M));
b =-1*KappaTHSVec(:);
Aeq = ones(1,M);
beq = 1;
lb = 0*ones(M,1);
ub = 1*ones(M,1);

WVec = lsqlin(GMat,XMat,A,b,Aeq,beq,lb,ub);
df=1e-3;
WVec(WVec<=df)=0; % remove small numbers
end


function [ grMat ] = AutoRegressionPredict( DirMat,TWopt )
%LINEARREGRESSIONPREDICTOR Summary of this function goes here
%   Detailed explanation goes here
[N,T]=size(DirMat);
grMat=zeros(N,T);

parfor t=2:T
    for i=1:N
        if t<TWopt
            t2=1;
        else
            t2=TWopt;
        end
        grMat(i,t)=nanmean(DirMat(i,t2:t-1));
    end
end

end


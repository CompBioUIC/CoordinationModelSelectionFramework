function [ prINFLNet ] = TrimMAT2TDAG( prFullINFLNet,InitRankOrderMat )
%TRIMMAT2TDAG Summary of this function goes here
%   Detailed explanation goes here
prINFLNet=prFullINFLNet;
N=max(size(prFullINFLNet));
for i=1:N % Normalize the Net to DAG with the total order of InitRankOrderMat(ID); if DI16=leader, then InitRankOrderMat(ID)=1
    for j=1:N
        if i~=j && InitRankOrderMat(i)<InitRankOrderMat(j)
            prINFLNet(i,j)=0;
        end
    end
end

end



function [ deg,unitVec ] = UnitVec2Deg( unitVec )
%UNITVEC2DEG Summary of this function goes here
%   Detailed explanation goes here
unitVec=unitVec/norm(unitVec);
deg=atan2d(unitVec(2),unitVec(1));

end


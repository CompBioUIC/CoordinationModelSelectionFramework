function [ DelaunayAdjMat ] = GetDelaunayNeighborsNet( PMat )
%GETDELAUNAYNEIGHBORS Summary of this function goes here
%   Detailed explanation goes here
% souce: https://www.mathworks.com/matlabcentral/answers/163115-how-do-i-get-the-neighbors-of-a-vertex-in-a-delaunay-triangulation
% Generate triangulation
N=size(PMat,1);
DelaunayAdjMat=zeros(N,N);
if isnan(sum(PMat(:)))
    return;
end
DelaunayTri = delaunayTriangulation(double(PMat));


  
attachedTriangles = vertexAttachments(DelaunayTri);

for i = 1:N
    if i >max(size(attachedTriangles))
        continue;
    end
    verticesOfTI = DelaunayTri.ConnectivityList(attachedTriangles{i},:);
    
    neighboursOfInternal{i} = int64(setdiff(unique(verticesOfTI), i) );
    
    DelaunayAdjMat(i,neighboursOfInternal{i})=1;
    DelaunayAdjMat(neighboursOfInternal{i},i)=1;
end
end


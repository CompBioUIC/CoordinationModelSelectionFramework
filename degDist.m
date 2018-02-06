function deg=degDist(x,y)
deg=abs(x-y);
for k=1:length(deg)
    if deg(k)>180
        deg(k)=360-deg(k);
    end
end
end


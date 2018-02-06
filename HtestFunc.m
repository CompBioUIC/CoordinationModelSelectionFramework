function [ HZPmat,HNPmat ] = HtestFunc( x,alpha )
%HTESTFUNC Summary of this function goes here
%   Detailed explanation goes here
HZPmat=zeros(3,2);
HNPmat=zeros(4,2);
i=1;
[h,p] = ttest(x,0,'Alpha',alpha); % zero mean non-para
HZPmat(i,:)=[h,p];
i=i+1;
[p,h,~] = signtest(x,0,'Alpha',alpha); % zero median non-para
HZPmat(i,:)=[h,p];
i=i+1;
[p,h] = signrank(x,0,'Alpha',alpha); % zero median non-para
HZPmat(i,:)=[h,p];
i=1;
[h,p]  = kstest(x,'Alpha',alpha); % normality test
HNPmat(i,:)=[h,p];
i=i+1;
[h,p] = chi2gof(x,'Alpha',alpha); % normality test
HNPmat(i,:)=[h,p];
i=i+1;
[h,p] = jbtest(x,alpha); % normality test
HNPmat(i,:)=[h,p];
i=i+1;
[h,p] = adtest(x,'Alpha',alpha); % normality test
HNPmat(i,:)=[h,p];
i=i+1;
end


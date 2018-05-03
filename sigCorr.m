function [sc,A] = sigCorr(S, istim, tst, nt)

NN = size(S,1);
jj=0;
for j = 1:max(istim)
    tpts = tst(istim==j) + [0:nt-1]';
    nst = sum(istim==j);
    resp = squeeze(mean(reshape(S(:,tpts(:)), NN, nt, sum(istim==j)),2));
    
    A(:,j,1) = mean(resp(:,1:floor(nst/2)),2);
    A(:,j,2) = mean(resp(:,floor(nst/2)+[1:floor(nst/2)]),2);
    
end

sc=nanmean(diag(corr(A(:,:,1)',A(:,:,2)','type','spearman')));
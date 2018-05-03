% add paths to Suite2P and OASIS
addpath(genpath('../Suite2P'))
addpath(genpath('/media/carsen/DATA2/Github/OASIS_matlab'))

%%% defaults
ops.sensorTau        = 2; % timescale
ops.doBaseline       = 0;
ops.recomputeKernel  = 0;
ops.running_baseline = 0;
ops.fs               = 2.5; % sampling rate

%%% inputs
% F is time x neurons
% istim are stim identities (integers)
% tst are stim times
% nt is stimulus length (in timescale of F)

% load file with data here
load('/media/carsen/DATA1/2P/oriResp/orimat_M150610_MP021_2016-08-09.mat');
%%
iPlane = 3;
F = dat.Fraw([dat.stat(:).iplane]==iPlane,:)';
istim = dat.istim;
tst   = dat.tst{iPlane};
nt    = 2;

% non-negative spike deconvolution
ops.lam = 0.0; % no penalty
ops.deconvType = 'OASIS';
[ssp1] = wrapperDECONV(ops, F);
svn = sigCorr(ssp1', istim, tst, nt);
fprintf('non-negative signal correlation: %1.2f\n',svn);

% L1 spike deconvolution
ops.lam = 10;
ops.deconvType  = 'OASIS';
[ssp3] = wrapperDECONV(ops, F(:,itest));
sv1 = sigCorr(ssp3', istim, tst, nt);
fprintf('L1 deconvolution signal correlation: %1.2f\n',svn);
        
% L0 spike deconvolution
ops.lam  = .2;
ops.deconvType = 'L0';
[ssp2] = wrapperDECONV(ops, F(:,itest));
sv0 = sigCorr(ssp2', istim, tst, nt);
fprintf('L0 deconvolution signal correlation: %1.2f\n',svn);




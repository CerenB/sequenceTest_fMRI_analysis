% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function opt = getOptionSequenceTest()
    % opt = getOption()
    % returns a structure that contains the options chosen by the user to run
    % slice timing correction, pre-processing, FFX, RFX.

    if nargin < 1
        opt = [];
    end

    % group of subjects to analyze
    opt.groups = {''};
    % suject to run in each group
    opt.subjects = {'003'};

    % we stay in native space (that of the T1)
    opt.space = 'T1w';

    % The directory where the data are located
    opt.dataDir = fullfile(fileparts(mfilename('fullpath')), ...
                           '..', '..', '..',  'raw');

    % task to analyze
    opt.taskName = 'RhythmCategBlock';

    % Suffix output directory for the saved jobs
    opt.jobsDir = fullfile( ...
                           opt.dataDir, '..', 'derivatives', ...
                           'SPM12_CPPL', 'JOBS', opt.taskName);

    % specify the model file that contains the contrasts to compute
    opt.model.univariate.file =  ...
        fullfile(fileparts(mfilename('fullpath')), '..', ...
                 'model', 'model-RhythmCategBlock_smdl.json');

    opt.model.multivariate.file = '';

    % specify the result to compute
    % Contrasts.Name has to match one of the contrast defined in the model json file
    %     opt.result.Steps(1) = struct( ...
    %         'Level',  'dataset', ...
    %         'Contrasts', struct( ...
    %                         'Name', 'AllSounds', ... %
    %                         'Mask', false, ... % this might need improving if a mask is required
    %                         'MC', 'none', ... FWE, none, FDR
    %                         'p', 0.001, ...
    %                         'k', 0, ...
    %                         'NIDM', true));

    % Options for slice time correction
    % If left unspecified the slice timing will be done using the mid-volume acquisition
    % time point as reference.
    % Slice order must be entered in time unit (s) (this is the BIDS way of doing things)
    % instead of the slice index of the reference slice (the "SPM" way of doing things).
    % More info here: https://en.wikibooks.org/wiki/SPM/Slice_Timing
    opt.sliceOrder = []; %it'll read from .json data
    
    opt.STC_referenceSlice = [];

    % Options for normalize
    % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
    opt.funcVoxelDims = [2.7 2.7 2.7];
    opt.space = 'MNI';

    %     % Save the opt variable as a mat file to load directly in the preprocessing
    %     % scripts
    %     save('opt.mat', 'opt');

end

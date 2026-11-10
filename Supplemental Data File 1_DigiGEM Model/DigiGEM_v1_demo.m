%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DigiGEM v1 Demonstration Script
%
% This script demonstrates:
%   1. Loading DigiGEM
%   2. Setting the weighted growth/cardenolide objective
%   3. Running FBA
%   4. Running FVA
%   5. Performing a simple in silico perturbation
%
% Requirements:
%   - MATLAB
%   - COBRA Toolbox
%   - DigiGEM_v1.mat in the same folder as this script
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

%% ------------------------------------------------------------------------
% 1. Initialize COBRA Toolbox
% -------------------------------------------------------------------------

% Uncomment the line below if COBRA has not already been initialized.
% initCobraToolbox(false);

%% ------------------------------------------------------------------------
% 2. Load DigiGEM
% -------------------------------------------------------------------------

load('DigiGEM_v1.mat','model');

fprintf('\nDigiGEM v1 loaded.\n');
fprintf('Reactions: %d\n', length(model.rxns));
fprintf('Metabolites: %d\n\n', length(model.mets));

%% ------------------------------------------------------------------------
% 3. Set the weighted objective function
% -------------------------------------------------------------------------

% Biomass and terminal cardenolide pathway reactions
objectiveRxns = { ...
    'BIO_L', ...
    'Add_Card13_c', ...
    'Add_Card14_c', ...
    'Add_Card15_c'};

% Objective weights used in DigiGEM
objectiveWeights = [693 100 100 100];

% Reset existing objective
model.c(:) = 0;

% Set weighted objective
model = changeObjective( ...
    model, ...
    objectiveRxns, ...
    objectiveWeights);

fprintf('Weighted objective set:\n');
fprintf('  Biomass = 693\n');
fprintf('  Add_Card13_c = 100\n');
fprintf('  Add_Card14_c = 100\n');
fprintf('  Add_Card15_c = 100\n\n');

%% ------------------------------------------------------------------------
% 4. Run Flux Balance Analysis
% -------------------------------------------------------------------------

solution = optimizeCbModel(model,'max');

if isempty(solution.x)
    error('FBA did not return a feasible solution.');
end

idxBio = find(strcmp(model.rxns,'BIO_L'));
idx13  = find(strcmp(model.rxns,'Add_Card13_c'));
idx14  = find(strcmp(model.rxns,'Add_Card14_c'));
idx15  = find(strcmp(model.rxns,'Add_Card15_c'));

fprintf('FBA results\n');
fprintf('-----------\n');
fprintf('Objective value: %.4f\n', solution.f);
fprintf('Biomass flux: %.4f\n', solution.x(idxBio));
fprintf('Add_Card13_c flux: %.4f\n', solution.x(idx13));
fprintf('Add_Card14_c flux: %.4f\n', solution.x(idx14));
fprintf('Add_Card15_c flux: %.4f\n\n', solution.x(idx15));

%% ------------------------------------------------------------------------
% 5. Run Flux Variability Analysis
% -------------------------------------------------------------------------

fprintf('Running FVA...\n');

[minFlux,maxFlux] = fluxVariability( ...
    model, ...
    100, ...
    'max', ...
    model.rxns);

fprintf('FVA complete.\n\n');

fprintf('Objective reaction FVA ranges\n');
fprintf('-----------------------------\n');

for i = 1:length(objectiveRxns)

    idx = find(strcmp(model.rxns,objectiveRxns{i}));

    fprintf('%-15s  min = %10.4f   max = %10.4f\n', ...
        objectiveRxns{i}, ...
        minFlux(idx), ...
        maxFlux(idx));

end

%% ------------------------------------------------------------------------
% 6. Simple simulation: knock out the P450scc cardenolide reaction
% -------------------------------------------------------------------------

fprintf('\nSimple perturbation example\n');
fprintf('---------------------------\n');

model_KO = model;

% P450scc reaction in DigiGEM v1
KOreaction = 'Add_Card20_c';

idxKO = find(strcmp(model_KO.rxns,KOreaction));

if isempty(idxKO)

    fprintf('Reaction %s was not found in the model.\n', KOreaction);

else

    % Constrain reaction flux to zero
    model_KO.lb(idxKO) = 0;
    model_KO.ub(idxKO) = 0;

    % Re-optimize
    solution_KO = optimizeCbModel(model_KO,'max');

    fprintf('Knocked out reaction: %s\n', KOreaction);

    if isempty(solution_KO.x)

        fprintf('The knockout model did not return a feasible solution.\n');

    else

        fprintf('Wild-type biomass flux: %.4f\n', solution.x(idxBio));
        fprintf('Knockout biomass flux:   %.4f\n', solution_KO.x(idxBio));

        fprintf('Wild-type Add_Card15_c flux: %.4f\n', solution.x(idx15));
        fprintf('Knockout Add_Card15_c flux:   %.4f\n', solution_KO.x(idx15));

    end

end

%% ------------------------------------------------------------------------
% Finished
% -------------------------------------------------------------------------

fprintf('\nDigiGEM v1 demonstration complete.\n');

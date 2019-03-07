%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Runs a particular scenario under a given simulator configuration
%          and then exits matlab with a succesfull result. Useful when
%          running in a non-interactive mode (i.e. on an HPC cluster). 
% INPUT:
    % scenarioID = the string id of the scenario to use    
    % configurationID = the numeric id of the configuration to use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [] = Run_Scenario_And_Exit(scenarioID, configurationID)

Run_Scenario(scenarioID, configurationID)
exit(0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Runs a particular scenario under a given simulator configuration. 
% INPUT:
    % scenarioID = the string id of the scenario to use    
    % configurationID = the numeric id of the configuration to use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = Run_Scenario(scenarioID, configurationID)

% Setup Paths
addpath(genpath('.'))

% Setup Analysis
[ Vstart, tau, myWorld, plotDims, projpt, xlab, ylab, zlab, toplab ] = Setup_Reachability(scenarioID, configurationID);
Setup_Runoff();

% Run Reachability
[ Vstop ] = Watershed_Reachability( Vstart, myWorld, plotDims, projpt, tau );

% Generate Outputs
Generate_Outputs(xlab, ylab, zlab, toplab, myWorld, Vstart, Vstop);

end
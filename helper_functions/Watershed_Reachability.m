%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Compute reachable sets for watershed
% AUTHOR: Margaret Chapman & Sylvia Herbert
% DATE: March 12, 2018
% UPDATED: Kevin Smith updated on March 6, 2019 to load dynamic confiugration. 
% INPUT:
    % Vstart = initial value function = surface function over constraint set, K
    % myWorld = grid
    % plotDims = dimensions to plot, [ x1, x2, x3, x4 ]
    % projpt = values of unplotted dimensions [ft]
% OUTPUT:
    % Vstop = value function at end of computation
            % { x \in myWorld : Vstop <= 0 } = { x0 } 
            % whose trajectories will remain in K for time [0, T]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Vstop ] = Watershed_Reachability( Vstart, myWorld, plotDims, projpt, tau )

global config;
global scenario;

% Pack problem parameters
schemeData.grid = myWorld;                                                      % grid

schemeData.dynSys = Watershed(zeros(0,scenario.dim),1:scenario.dim);            % dynamic system

schemeData.accuracy = config.accuracy;                                          % set accuracy

schemeData.uMode = 'min';                                                       % u is trying to minimize value function

schemeData.dMode = 'max';                                                       % d is trying to maximize value function

% Specify extra arguments
HJIextraArgs.visualize = true;                           % show plot
HJIextraArgs.deleteLastPlot = config.deleteLastPlot;     % delete previous plot as you update
HJIextraArgs.plotData.plotDims = plotDims;               % dimensions to plot
HJIextraArgs.plotData.projpt = projpt;                   % projected points for non-plotted states
HJIextraArgs.stopConverge = 0;                           % stop the computation when it converges
HJIextraArgs.keepLast = 1;                               % to conserve memory
HJIextraArgs.plotColorT = [0 232 255] ./ 255;
HJIextraArgs.makeVideo = config.makeVideo;

% Solve HJI PDE
[ Vstop, tau, extraOuts ] = HJIPDE_solve( Vstart, tau, schemeData, 'maxVOverTime', HJIextraArgs);

end
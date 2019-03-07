%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: Margaret Chapman & Sylvia Herbert
% DATE: March 12, 2018
% PURPOSE: Create grid and surface function, g(x), over constraint set, K
% UPDATED: Kevin Smith updated on March 6, 2019 to load dynamic confiugration. 
% INPUT:
    % scenarioID = the scenario to setup (see ../configuration_options/get_scenario.m)
    % configurationID = the configuration to setup (see ../configuration_options/get_config.m)
% OUTPUT:
    % gx = surface function for K, input: grid point index, output: signed distance from K
    % tau = time vector
    % myWorld = grid
    % plotDims = dimensions to plot, [ x1, x2, x3, x4 ]
    % projpt = values of unplotted dimensions [ft]
    % xlab, ylab, toplab = graph labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ gx, tau, myWorld, plotDims, projpt, xlab, ylab, zlab, toplab ] = Setup_Reachability(scenarioID, configurationID)

global scenario;
global config;

% load scenario and configuration
scenario = get_scenario(scenarioID);
config = get_config(configurationID);

display(strcat("Running scenario: (", scenarioID, ") \'", scenario.title, "\', under simulator configuration (",num2str(configurationID) ,")."))

% bound computational grid based on constraint set with some padding
%   - avoid evaluating x_k = 0 for numerical stability
%   - to reduce the impact of edge effects when discretizing implicit
%     surface function near K_max
grid_min = scenario.K_min + config.grid_spacing;
grid_max = scenario.K_max + 2 * config.grid_spacing;


N = ceil( (grid_max-grid_min)/config.grid_spacing );                                        % # grid points for each dimension

myWorld = createGrid(grid_min, grid_max, N );                                               % create grid

gx = shapeRectangleByCorners(myWorld, grid_min + config.grid_spacing, scenario.K_max);      % g(x) = surface over constraint set, K

tau = 0 : config.plot_update_interval : config.simulation_length;                           % time vector for graph update [sec]

% determine dimensions to plot, setup figure annotations for the specified view
if scenario.dim == 2
    % x1, x3           x2
    plotDims = [1 1]; projpt = []; %ft
    
    xlab = 'x_1, pond stage [ft]'; ylab = 'x_2, stream stage [ft]'; zlab = '';
    
    toplab = '';
    
else
    % x1, x2, x3
    plotDims = [1 1 1]; projpt = [];
    
    xlab = 'x_1, pond 1 stage [ft]'; ylab = 'x_2, stream stage [ft]'; zlab = 'x_3, pond 2 stage [ft]';
    
    toplab = '';
    
end


                                                          
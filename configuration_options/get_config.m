%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Create a structure containing scenario-agnostic simulation information
% INPUT:
    % configId = the numeric id of the configuration to use
% OUTPUT:
    % config = a structure containing scenario-agnostic simulation information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function config = get_config(configId)

config = [];
switch configId
    case 1
        config.id = '1';
        config.grid_spacing = 1/12; % spacing between grid points [ft]
        config.plot_update_interval = 60; % seconds
        config.simulation_length = 4 * 3600; % seconds
        config.design_storm_start_offset_seconds = 60*640; % seconds
        
        config.accuracy = 'high';
        config.makeVideo = false;
        config.deleteLastPlot = true;
             
    case 2
        config.id = '2';
        config.grid_spacing = 1/24; % spacing between grid points [ft]
        config.plot_update_interval = 1/3*3600; % seconds
        config.simulation_length = 4 * 3600; % seconds
        config.design_storm_start_offset_seconds = 60*640; % seconds
        
        config.accuracy = 'high';
        config.makeVideo = false;
        config.deleteLastPlot = false; % creates 'onion skin' effect that shows the progression of the safe sets at various times during the simulation
        
    otherwise
        display('error loading config')
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Create a structure containing scenario-specifc details
% INPUT:
    % scenarioID = the string id of the scenario to use
% OUTPUT:
    % scenario = a structure containing scenario-specific details
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function scenario = get_scenario(scenarioID)

scenario = [];

scenario.surface_runoff_pond1 = str2func("zero_disturbance");
scenario.surface_runoff_pond2 = str2func("zero_disturbance");

scenario.surface_area_pond1 = 28292; % [ft^2]
scenario.surface_area_pond2 = 25965; % [ft^2]

scenario.outlet_radius_pond1 = 1/3; % [ft]
scenario.outlet_radius_pond2 = 1/3; % [ft]

scenario.active_controls_enabled_pond1 = 0; % 1 = enabled
scenario.active_controls_enabled_pond2 = 0; % 1 = enabled

scenario.outlet_always_closed_pond1 = 0;
scenario.outlet_always_closed_pond2 = 0;

scenario.outlet_elevation_stream = 1/2; %[ft]
scenario.outlet_elevation_pond1 = 1; % [ft]
scenario.outlet_elevation_pond2 = 1; % [ft]

scenario.stream_slope = 0.01;
scenario.mannings_n = 0.1; % Manning's roughness coefficient [s/m^(1/3)]
scenario.stream_length = 1820; % [ft]
scenario.surface_runoff_stream = str2func("zero_disturbance");
scenario.side_slope = 1/4;  % side slope, stream


scenario.dim = 3;

switch scenarioID
    case '1'
        scenario.dim = 2;
        scenario.id = '1';
        scenario.title = "Scenario 1";
        scenario.outlet_always_closed_pond1 = 1;
        scenario.outlet_always_closed_pond2 = 1;
        
    case '2'
        scenario.dim = 2;
        scenario.id = '2';
        scenario.title = "Scenario 2";
        
    case '3'
        scenario.dim = 2;
        scenario.id = '3';
        scenario.title = "Scenario 3";
        scenario.surface_runoff_pond1 = str2func("two_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("two_cfs_disturbance");
        scenario.outlet_always_closed_pond1 = 1;
        scenario.outlet_always_closed_pond2 = 1;
        
    case '4'
        scenario.dim = 2;
        scenario.id = '4';
        scenario.title = "Scenario 4";
        scenario.surface_runoff_pond1 = str2func("two_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("two_cfs_disturbance");
        
    case '5'
        scenario.dim = 2;
        scenario.id = '5';
        scenario.title = "Scenario 5";
        scenario.surface_runoff_pond1 = str2func("four_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("four_cfs_disturbance");
        scenario.outlet_always_closed_pond1 = 1;
        scenario.outlet_always_closed_pond2 = 1;
        
    case '6'
        scenario.dim = 2;
        scenario.id = '6';
        scenario.title = "Scenario 6";
        scenario.surface_runoff_pond1 = str2func("four_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("four_cfs_disturbance");
        
    case 'A'
        scenario.id = 'A';
        scenario.title = "Scenario A";
        
    case 'B'
        scenario.id = 'B';
        scenario.title = "Scenario B";
        scenario.surface_area_pond2 = 28292 * 1.5; % [ft^2]
        
    case 'C'
        scenario.id = 'C';
        scenario.title = "Scenario C";
        scenario.outlet_radius_pond2 = 2/3; % [ft]
        
    case 'D'
        scenario.id = 'D';
        scenario.title = "Scenario D";
        scenario.active_controls_enabled_pond1 = 1;
        scenario.active_controls_enabled_pond2 = 1;
        
    case 'E'
        scenario.id = 'E';
        scenario.title = "Scenario E";
        scenario.surface_runoff_pond1 = str2func("two_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("two_cfs_disturbance");
        
    case 'F'
        scenario.id = 'F';
        scenario.title = "Scenario F";
        scenario.surface_runoff_pond1 = str2func("two_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("two_cfs_disturbance");
        scenario.surface_area_pond2 = 28292 * 1.5; % [ft^2]
        
    case 'G'
        scenario.id = 'G';
        scenario.title = "Scenario G";
        scenario.surface_runoff_pond1 = str2func("two_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("two_cfs_disturbance");
        scenario.outlet_radius_pond2 = 2/3; % [ft]
        
    case 'H'
        scenario.id = 'H';
        scenario.title = "Scenario H";
        scenario.surface_runoff_pond1 = str2func("two_cfs_disturbance");
        scenario.surface_runoff_pond2 = str2func("two_cfs_disturbance");
        scenario.active_controls_enabled_pond1 = 1;
        scenario.active_controls_enabled_pond2 = 1;
        
    case 'I'
        scenario.id = 'I';
        scenario.title = "Scenario I";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        
    case 'J'
        scenario.id = 'J';
        scenario.title = "Scenario J";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.surface_area_pond2 = 28292 * 1.5; % [ft^2]
        
    case 'K'
        scenario.id = 'K';
        scenario.title = "Scenario K";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.outlet_radius_pond2 = 2/3; % [ft]
        
    case 'L'
        scenario.id = 'L';
        scenario.title = "Scenario L";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.active_controls_enabled_pond1 = 1;
        scenario.active_controls_enabled_pond2 = 1;
        
    case 'M'
        scenario.id = 'M';
        scenario.title = "Scenario M";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.surface_area_pond1 = scenario.surface_area_pond1 * 5; % [ft^2]
        scenario.surface_area_pond2 = scenario.surface_area_pond2 * 2; % [ft^2]
        
        
    case 'N'
        scenario.id = 'N';
        scenario.title = "Scenario N";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.surface_area_pond1 = scenario.surface_area_pond1 * 5; % [ft^2]
        scenario.surface_area_pond2 = scenario.surface_area_pond2 * 2; % [ft^2]
        scenario.active_controls_enabled_pond1 = 1;
        scenario.active_controls_enabled_pond2 = 1;
        
    case 'O'
        scenario.id = 'O';
        scenario.title = "Scenario O";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.surface_area_pond1 = scenario.surface_area_pond1 * 7; % [ft^2]
        scenario.surface_area_pond2 = scenario.surface_area_pond2 * 2.5; % [ft^2]
        
    case 'P'
        scenario.id = 'P';
        scenario.title = "Scenario P";
        scenario.surface_runoff_pond1 = str2func("pond1_two_year_runoff");
        scenario.surface_runoff_pond2 = str2func("pond2_two_year_runoff");
        scenario.surface_area_pond1 = scenario.surface_area_pond1 * 7; % [ft^2]
        scenario.surface_area_pond2 = scenario.surface_area_pond2 * 2.5; % [ft^2]
        scenario.active_controls_enabled_pond1 = 1;
        scenario.active_controls_enabled_pond2 = 1;
        
    otherwise
        dipslay('error loading scenario')
end

% set boundaries ofthe constraint set, K
switch scenario.dim
    case 3
        scenario.K_min = zeros( 3, 1 );  % [ft]
        scenario.K_max = [ 5; 3; 3.5 ];  % [ft]
        
    case 2
        scenario.K_min = zeros( 2, 1 );  % [ft]
        scenario.K_max = [ 5; 3; ];      % [ft]
end

end

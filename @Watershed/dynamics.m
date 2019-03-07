%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: A function that describes the system dynamics, used by 
%          HJIPDE_solve in ToolboxLS. It has definitions for both
%          the two-state and three-state scenario options. If a two-state
%          simulation is run, the dynamics of the third state will not be 
%          evaluated.
% INPUT:
    % obj, deriv, uMode, parameters used by HJIPDE_solve
    % tau = t_max - t [seconds], where t is the current time in simulation space
    % x = state vector 
% OUTPUT: vector of state changes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dx = dynamics(obj, tau, x, u, d)

%initialize your dx in each dimension of the state space
dx = cell(obj.nx, 1);

%turn everything into cells
returnVector = false;
if ~iscell(x)
    returnVector = true;
    x = num2cell(x);
    u = num2cell(u);
    d = num2cell(d);
end

%solve dx for each dimension of the state space
for i = 1:length(obj.dims)
    dx{i} = dynamics_i(x, tau, u, d, obj.dims, obj.dims(i));
end

%give back a matrix if need be
if returnVector
    dx = cell2mat(dx);
end
end

%calculate change in particular state
function dx = dynamics_i(x, tau, u, d, ~, dim)

global scenario;

                                            % pond1
A1 = scenario.surface_area_pond1;           %   surface area  [ft^2]
d1 = scenario.surface_runoff_pond1(tau);    %   inflow [cfs]
R1 =scenario.outlet_radius_pond1;           %   outlet radius [ft]
Z1 = scenario.outlet_elevation_pond1;       %   outlet invert elevation [ft]

                                            % pond2
A2 = scenario.surface_area_pond1;           %   surface area  [ft^2]
d2 = scenario.surface_runoff_pond2(tau);    %   inflow [cfs]
R2 = scenario.outlet_radius_pond2;          %   outlet radius [ft]
Z2 = scenario.outlet_elevation_pond2;       %   outlet invert elevation [ft]

                                            % stream
L = scenario.stream_length;                 %   length [ft]
m = 1/scenario.side_slope;                  %   side slope inverse
ds = scenario.surface_runoff_stream(tau);   %   surface runoff into stream [cfs]

switch dim
    % x1 dot - the instantaneous change in the elevation of pond1
    % The change in elevation of the pond is [inflow - outflow]/[surface area].        
    % Here: 
    %   inflow: runoff from pond1 watershed
    %   outflow: outflow through pond1 control structure based on current 
    %             state of outlet and water surface elevation estimated
    %             using the orifice equation
    %   surface area: taken as constant as specified by scenario
    
    case 1
        dx = ( d1 - q_outlet(x{1},u{1}, R1, Z1)) ./ ( A1 );
    
    % x2 dot - the instantaneous change in the elevation of the stream
    % The change in elevation of the stream is [inflow - outflow]/[surface area].
    % Here: 
    %   inflow: runoff from the stream's watershed + outflow from pond1
    %   outflow: discharge from stream, estimated using Manning's equation
    %            for open channel flow in a triangular cross-section
    %   surface area: dynamic as elevation changes in the triangular cross section
    case 2    
        dx = ( ds + q_outlet(x{1},u{1},R1,Z1) - q_stream(x{2}) ) ./ ( 2*m*x{2}*L );
    
    % x3 dot - the instantaneous change in the elevation of pond2
    % The change in elevation of the pond is [inflow - outflow]/[surface area].        
    % Here: 
    %   inflow: discharge from stream + runoff from pond2 watershed
    %   outflow: outflow through pond2 control structure based on current 
    %             state of outlet and water surface elevation estiamted
    %             using the orifice equation
    %   surface area: taken as constant as specified by scenario
    case 3    
        dx = ( q_stream(x{2}) + d2 - q_outlet(x{3},u{2}, R2, Z2)) ./ ( A2 );
        
    otherwise
        error('Only dimension 1-3 are defined')
end
end
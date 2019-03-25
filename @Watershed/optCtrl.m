%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: A function for determining optimal control used by HJIPDE_solve
%          in helperOC. There are two control states:
%               0 = outlet fully closed
%               1 = outlet fully open
%
%          There are three 'modes' that can be enabled by manipulating the
%          scenario definition. The modes determine which control states
%          are available to the control system:
%               default = passive system with always-open outlet
%               outlet_always_closed = passive system with always-closed outlet
%               active_controls_enabled = active system with oulet controlled 
%                                         by optimal bang-bang controller
%
%          LBu is the control signal when the optimal control algorithm
%              indicates the system should stop draining.
%
%          UBu is the control signal when the optimal control algorithm
%              indicates the system should begin draining.
%
%          Under active control:
%              LBu is always set to control state 0 (fully closed)
%              UBu is always set to cotnrol state 1 (fully open)
%
%          Under passive control, LBu and UBu are both set to the control
%          state that corresponds to the 'mode' of passive operation (e.g.
%          fully open or fully closed).
%
% INPUT:
    % obj, deriv, uMode, parameters used by HJIPDE_solve
    % tau = t_max - t [seconds], where t is the current time in simulation space
    % x = state vector 
% OUTPUT: optimal control vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function uOpt = optCtrl(obj, tau, x, deriv, uMode)

%% Input processing
if nargin < 5, uMode = 'min'; end % if <=4 input arguments assume uMode is trying to minimize. Default option.

if ~iscell(deriv), deriv = num2cell(deriv); end % ensure that deriv is a cell

global scenario;

sisl = scenario.side_slope;             % side slope, stream
m = 1 / sisl;                           % slide slope, inverse
L1 = scenario.stream_length;
A1 = scenario.surface_area_pond1;       % approx. surface area, pond 1 [ft^2]
A2 = scenario.surface_area_pond2;       % approx. surface area, pond 2 [ft^2]
Z1 = scenario.outlet_elevation_pond1;   % outlet elevation measured from pond base [ft]
Z2 = scenario.outlet_elevation_pond2;   % outlet elevation measured from pond base [ft]

% passive - closed
if scenario.outlet_always_closed_pond1
    
    LBu1 = 0;
    UBu1 = 0;
    
    % active - binary control
elseif scenario.active_controls_enabled_pond1
    
    LBu1 = 0;
    UBu1 = 1;
    
    % passive - open
else
    LBu1 = 1;
    UBu1 = 1;
end

% passive - closed
if scenario.outlet_always_closed_pond2
    
    LBu2 = 0;
    UBu2 = 0;
    
    % active - binary control
elseif scenario.active_controls_enabled_pond2
    
    LBu2 = 0;
    UBu2 = 1;
    
    % passive - open
else
    LBu2 = 1;
    UBu2 = 1;
end

%% Optimal control algorithm
if strcmp(uMode, 'min')
    
    % determine direction of control for pond 1
    multiplier1 = -deriv{1}./A1 + deriv{2}./(2*m*x{2}*L1);
    
    % when the multiplier is positive it indicates pond1 should stop draining
    u1_for_BigX = ( multiplier1 >=0 ).*LBu1 + ( multiplier1 < 0 ).*UBu1;
    
    % the control can only have an effect if the water level is above the
    % outlet invert (i.e. X1 > Z1); use UBu1 as the default signal when the
    % control will not have an effect.
    uOpt{1} = ( x{1} >= Z1 ).*u1_for_BigX + ( x{1} < Z1 ).*UBu1;
    
    
    if(scenario.dim == 3)
        % determine direction of control for pond 2
        multiplier2 = -deriv{3}./A2;
        
        % when the multiplier is positive it indicates pond2 should stop draining
        u2_for_BigX = ( multiplier2 >= 0 ).*LBu2 + ( multiplier2 < 0 ).*UBu2;
        
        % the control can only have an effect if the water level is above the
        % outlet invert (i.e. X2 > Z2); use UBu2 as the default signal when the
        % control will not have an effect.
        uOpt{2} = ( x{3} >= Z2 ).*u2_for_BigX + ( x{3} < Z2 ).*UBu2;
        
    end
    
else
    
    error('Unknown uMode!')
    
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Return a runoff profile for a "two year" rainfall event falling
% on the watershed that drains to pond2. 
% INPUT:
    % tau = time distance in seconds from t_max, (i.e. tau = t_max - t) 
% OUTPUT:
    % r = runoff in cubic feet per second
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function r = pond2_two_year_runoff( tau )

    global config
    global p2_2y
    
    t_seconds = config.simulation_length - tau;
    t_minutes = t_seconds / 60;
    
    runoff_start_offset_minutes = config.design_storm_start_offset_seconds / 60; 
    
    r = interp1(p2_2y(:,1), p2_2y(:,2), t_minutes + runoff_start_offset_minutes);
end
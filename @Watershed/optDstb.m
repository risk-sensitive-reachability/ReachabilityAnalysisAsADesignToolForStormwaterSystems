%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: A stub for the optimal disturbance function used by
%          HJIPDE_solve in helperOC. In our instance the disturbance
%          is non-adversarial so this function does not impact the
%          system's dynamics.
% INPUT:
    % obj, deriv, uMode, parameters used by HJIPDE_solve
    % tau = t_max - t [seconds], where t is the current time in simulation space
    % x = state vector 
% OUTPUT: optimal disturbance vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dOpt = optDstb(obj, tau, x, deriv, dMode)

%% Input processing
if nargin < 5, dMode = 'max'; end % if dMod is not provided, use 'max' as default

if ~iscell(deriv), deriv = num2cell(deriv); end

dOpt = cell(obj.nd, 1);

end
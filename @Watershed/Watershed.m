%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Provides a Watershed class definition inheriting from DynSys base
%          class. This class is used by HJIPDE_solve method in helperOC.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef Watershed < DynSys
    properties
        % Dimensions that are active
        dims
    end
    
    methods
        function obj = Watershed(x, dims)
            
            if nargin <1
                x = zeros(3,1);
            end
            
            if numel(x) ~= obj.nx
                error('Initial state does not have right dimension!');
            end
            
            if ~iscolumn(x)
                x = x';
            end
            
            
            if nargin < 2
                dims = 1:3;
            end
            
            % Basic properties
            obj.nx = length(dims);
            obj.nu = 2;
            obj.nd = 0;
            
            obj.x = x;
            obj.xhist = obj.x;
            
            obj.dims = dims;
        end
        
    end % end methods
end % end classdef

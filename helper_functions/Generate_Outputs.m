%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Generate plots and save simulation artifacts (i.e. matlab environment at end of simulation).
% INPUT:
    % xlab, ylab, zlab, toplab = plot labels
    % myWorld = computed grid and ancillary properties
    % Vstart = values of the surface function, g(x) at tau = 0, or t = t_tmax
    % Vstop =  values of the surface function, g(x) at tau = t_max, or t = 0
% SIDE EFFECTS:
    % Creates atifacts in /outputs/{configID}/{scenarioID}/{current_time}/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = Generate_Outputs(xlab, ylab, zlab, toplab, myWorld, Vstart, Vstop)

global config;
global scenario;

% build output directories
output_dir = sprintf('%s', datestr(now,'mm-dd-yyyy_HH-MM'));

directory = 'outputs';
if (~exist(directory, 'dir')); mkdir(directory); end

directory = strcat(directory,'/',config.id);
if (~exist(directory, 'dir')); mkdir(directory); end%

directory = strcat(directory,'/',scenario.id);
if (~exist(directory, 'dir')); mkdir(directory); end

directory = strcat(directory,'/',output_dir);
if (~exist(directory, 'dir')); mkdir(directory); end


% setup standard three dimensional plot
if scenario.dim == 3
    xlabel( xlab ); ylabel( ylab ); if (scenario.dim == 3), zlabel(zlab); end; title( [scenario.title, toplab] );
    az = 136;
    el = 29;
    view(az, el);
    axis([0, 5.5, 0, 3.5, 0, 4]);
    
    set(get(gca,'ylabel'),'rotation',333,'units', 'Normalized', 'position', [0.15, 0.05, 0])
    set(get(gca,'xlabel'),'rotation',26,'units', 'Normalized', 'position', [0.8, 0.04, 0])
    % setup standard two dimensional plot
else
    visSetIm( myWorld, Vstart, 'k', 0 );
    xlabel( xlab ); ylabel( ylab ); title( [scenario.title, toplab] ); axis([0 5.25 0 3.25]);
end

% save standard plots
path_to_png = strcat(directory,'/',"Scenario",scenario.id,".png");
path_to_fig = strcat(directory,'/',"Scenario",scenario.id,".fig");
saveas(gcf,path_to_png);
% octave does not support saving .fig files
if (~Running_In_Octave()); saveas(gcf,path_to_fig);  end

% if 3-dimensional, also generate plots with reference vector
if scenario.dim == 3
    plot3([1/6 5],[1/6 3], [1/6 3.5], 'k', 'linewidth', 5);
    plot3([1/6 1/6], [1/6 3], [1/6 1/6], ':k', 'linewidth', 2);
    plot3([5 5], [3 3], [1/6 3.5], ':k', 'linewidth', 2);
    plot3([1/6 5], [3 3], [1/6 1/6], ':k', 'linewidth', 2);
    
    % alpha function is not supported in octave
    if (~Running_In_Octave()); alpha(.8); end;
    view(106, 23)
    set(get(gca,'xlabel'),'rotation',55,'units', 'Normalized', 'position', [.97, 0.1, 0]);
    set(get(gca,'ylabel'),'rotation',-7,'units', 'Normalized', 'position', [0.35, -.04, 0])
    
    path_to_png = strcat(directory,'/',"Scenario",scenario.id,"_WithReferenceVector.png");
    path_to_fig = strcat(directory,'/',"Scenario",scenario.id,"_WithReferenceVector.fig");
    saveas(gcf,path_to_png);
    % octave does not support saving .fig files
    if (~Running_In_Octave()); saveas(gcf,path_to_fig);  end
end

% save matlab environment
path_to_mat = strcat(directory,'/',"Scenario",scenario.id,".mat");
save(path_to_mat);
save(path_to_mat,'Vstop','-append');

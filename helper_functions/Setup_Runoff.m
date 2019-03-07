%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Loads runoff data into global variables for later access.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = Setup_Runoff()

% pond1 two year event runoff
% [minutes, cfs]
global p1_2y
p1_2y = csvread('./inputs/pond1_2_year_event.csv');

% pond2 two year event runoff
% [minutes, cfs]
global p2_2y
p2_2y = csvread('./inputs/pond2_2_year_event.csv');

end
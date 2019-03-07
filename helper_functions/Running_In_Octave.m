%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE: Determines if code is running in Octave, rather than Matlab
% RETURNS: true if the environment is Octave.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function isOctave = Running_In_Octave
  isOctave = exist ("OCTAVE_VERSION", "builtin") > 0;
end
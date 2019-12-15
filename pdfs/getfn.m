function filenames = getfn(mydir, pattern)
%GETFN Get filenames in directory and subdirectories.
%
%   FILENAMES = GETFN(MYDIR, PATTERN)
%
% Example: Get all files that end with 'txt' in the current directory and
%          all subdirectories 
%
%    fn = getfn(pwd, 'txt$')
%
%   Thorsten.Hansen@psychol.uni-giessen.de  2016-07-06
if nargin == 0
  mydir = pwd;
end
% computes common variable FILENAMES: get all files in MYDIR and
% recursively traverses subdirectories to get all files in these
% subdirectories: 
getfnrec(mydir) 
% if PATTERN is given, select only those files that match the PATTERN:                 
if nargin > 1 
  idx = ~cellfun(@isempty, regexp(filenames, pattern));
  filenames = filenames(idx);
end
    function getfnrec(mydir)
    % nested function, works on common variable FILENAMES
    % recursively traverses subdirectories and returns filenames
    % with path relative to the top level directory
      d = dir(mydir);
      filenames = {d(~[d.isdir]).name};
      filenames = strcat(mydir, filesep, filenames); 
      dirnames = {d([d.isdir]).name};
      dirnames = setdiff(dirnames, {'.', '..'});  
      for i = 1:numel(dirnames)
        fulldirname = [mydir filesep dirnames{i}];
        filenames = [filenames, getfn(fulldirname)];
      end  
    end % nested function
end
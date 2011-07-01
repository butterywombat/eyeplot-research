function [ output_args ] = eyeplot( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
filterspec = '~/Desktop/school/eye research/pt exports/*.txt'; %set default dir and filetype
[filename, pathname, filterindex] = uigetfile(filterspec);
if isequal(filename,0)
   disp('User selected Cancel')
   return
else
   disp(['User selected', fullfile(pathname, filename), filename])
end

fid=fopen(fullfile(pathname, filename)); %ask for this later so can do primary gaze. works with Olheiser and Vomund LRUD
%max_num_col = 7;
format = '%f %*f %f %*f %*f %f %*f %f %*f %*f %*f %*f %f %*f %*f %f %*f %f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f';
%garbage = 'ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ'
data = textscan(fid, format,'HeaderLines',23,'CollectOutput',1, 'treatAsEmpty', 'ÿ'); %I kept the times but each interval is .016-.017 sec constant so unneeded
%treat all ÿs as NaN so that later can delete all those rows with NaN.
%data = textscan(fid, '%f %*f %f %*f %*f %f %*f %f %*f %*f %*f %*f %f %*f %*f %f %*f %f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f','HeaderLines',23,'CollectOutput',1, 'treatAsEmpty'); %I kept the times but each interval is .016-.017 sec constant so unneeded
data = cell2mat(data); %TODO this may be a better idea to avoid garbagey code like the following...
data(any(isnan(data), 2), :) = []; %deletes all rows that have a NaN
num_rows = length(data(:,1));
%%
%velocity and torsion velocity calculations via forward calculations....
cols = 2:7;
s=data(:,cols); %just calc for all things interested in, so can save a data chart
v = zeros(num_rows, length(cols));
for n=2:(num_rows);
    v(n,:)=(s(n,:)-s(n-1,:))/.170; %.170 hardcoded time difference between measurements for the goggle system
end 
%%
%blink suppression adjustment...
thres = input('Please input blink suppression threshold in deg/s (0 for none)')
    
switch logical(true)
    case thres==0
        disp('No suppression')
    case thres>0
        disp('blink suppression')
        rows_to_remove = any(abs(v)>=thres, 2); %this records the rows that we want to remove for blink suppression! important
        v(rows_to_remove,:) = [];
        data(rows_to_remove,:) = [];
    otherwise
        disp('Unknown method.')
end
%%
%CONSTANTSish...why doesn't matlab have constants?
time = data(:,1);
% left_horiz = data(:,2); %all measurements in degrees or deg/sec for velocity
% left_vert = data(:,3);
% left_tor = data(:,4);
% right_horiz = data(:,5);
% right_vert = data(:,6);
% right_tor = data(:,7);
% 
% left_horiz_v = v(:,1);
% left_vert_v = v(:,2);
% left_tor_v = v(:,3);
% right_horiz_v = v(:,4);
% right_vert_v = v(:,5);
% right_tor_v = v(:,6);

    %plot(time,v,'o') %was done as a check
            
%var_names = ['left_horiz', 'left_horiz_v', 'left_vert', 'left_vert_v', 'left_tor', 'left_tor_v', 'right_horiz', 'right_horiz_v', 'right_vert', 'right_vert_v', 'right_tor', 'right_tor_v']; %string stuff, duno how to use yet

%%
%time bracketing
h = plot(time, data(:,2:4), 'b.', time, data(:,5:7), 'r.'); %plots all on one graph just for time bracketing purposes
hline(0,'k-'); %need the hline and vline .m function files
vline(0,'k-');
title({'Time Bracket';'Click left bound. Hit Enter. Click right bound. Hit Enter. Press enter twice to avoid time bracketing.'});
[x,y] = ginput;    
time0 = x; %need round(x)?
[x,y] = ginput;
time1 = x;
if (isempty(time0) || time0 < 0 || time0 >= time(length(time)))%if user didn't click bounds/bounds exceeded, do not time bracket
    time0 = 0;
end
if (isempty(time1) || time1 <= 0 || time1 > time(length(time)) || time1 <= time0) 
    time1 = time(length(time));
end

%find closest time points to those selected
idx0 = interp1(time,1:numel(time),time0,'nearest') ;
time0 = time(idx0)
idx1 = interp1(time,1:numel(time),time1,'nearest') ;
time1 = time(idx1)

%close(h);

%%
%crop data based on time bracket
data = data(idx0:idx1,:);
v = v(idx0:idx1,:);
time = data(:,1); %update time, using as a contant name convenience only
%%
%plotting options for an extra user-specified plot
%TODO: make the last 2 options the default...
%menu_options = {'1)time [s]' '2)horiz (left-right) [deg]' '3)vert (up-down) [deg]' '4)tor (CW-CCW) [deg]' '5)horiz_v [deg/s]' '6)vert_v [deg/s]'  '7)tor_v [deg/s]' '8)horiz-vert-tor vs time' '9)horiz-vert vs tor (primary gaze)'}; %TODO: deal with velocities.
%defaults will be plotted anyway. show a menu 
menu_options = {'time [s]' 'horiz (left-right) [deg]' 'vert (up-down) [deg]' 'tor (CW-CCW) [deg]' 'horiz_v [deg/s]' 'vert_v [deg/s]'  'tor_v [deg/s]' 'skip extra plot'};

%TODO
chosen_x = menu('Choose another x for extra graph to plot (eye positions vs time, and velocities vs time, and horiz,vert vs tor (for primary gaze files) plots are automatic)', menu_options);
chosen_y = [];

%setup x values to plot
switch chosen_x
    case 0
        disp('User selected Cancel')
        return
    case 1 %if time was picked as the x for the left eye, we use same time values for right eye since they are concurrent measurements
        x_left = time;
        x_right = x_left;
    %menu_options = [menu_options 'horiz-vert-tor [deg]']; %ie, if x=time, give a special option that plots it vs horiz, vert, and tor for convenience
    case {2,3,4}
        x_left = data(:,chosen_x);
        x_right = data(:,chosen_x+3);
    case {5,6,7} %velocity chosen
        x_left = v(:,chosen_x-4); %ex: choosing choice 5=horiz_v, so look at 5-4=1st col in v for left
        x_right = v(:,chosen_x-1); %and 4th col for right eye
    %note that if skipped, no x values set yet!
end

%     case 8 %for hvt vs t initially. must change for tor stuff later.
%         x_left = time; 
%         x_right = xleft;
%         chosen_y = 1:3;

%if (isempty(chosen_y)) %if it's not plot defaults only, show y menu.
if chosen_x ~= 8 %if x is not special case plot, show extra plot y menu.
    chosen_y = menu('Choose a y', menu_options(2:7)); %I left out time as a choice for y, so menu_options start at col 2.
    %choice 1 = horiz, 2 = vert, 3 = tor, 4 = horiz v, 5 = vert v, 6 = tor
    if (chosen_y == 0)
      disp('User selected Cancel');
      return;
    end
end

%%
    %gets the y data sets for later plotting, for extra graph
    if (chosen_y < 4) %ie 'position' rather than velocity etc picked as y
        y_left = data(:,chosen_y+1); %since 'time' choice is left out for y, add 1 to correlate with right column in data matrix; thus choice 1 for y correlates to col 2 in data cols
        y_right = data(:,chosen_y+4); %yleft col + 3 correlates with the same y value type but for right eye instead of left
    else %velocity picked as y
        y_left = v(:,chosen_y-3); %ex: choose choice 4 = horiz v, thus gets 4-3=1st col of v (left horiz v)
        y_right = v(:,chosen_y); %ex: 4th choice = 4th col of v (right horiz v)
    end
    
    %plot and save figure
    plot(x_left, y_left(:,1), 'b.', x_right, y_right(:,1), 'r.');
    axis tight; %rescale axes
    x_axis = menu_options(chosen_x);
    xlabel(x_axis);
    y_axis = menu_options(chosen_y+1); %+1 since menu options still includes time first.
    ylabel(y_axis);
    h = strcat(filename, ': ', y_axis, '-vs-', x_axis);
    title(h);
    hline(0,'k-'); %need the hline and vline .m function files
    vline(0,'k-');
    print(strcat(pathname, 'extra figure'),'-dtiff','-r300');
%csvwrite('filtered_data.csv',data);
%end

%%
%for defaults set hardcoded for now
x_left = time;
x_right = x_left;
chosen_y = 1:3;
%gets the y data sets for later plotting, for extra graph
%TODO code repeat from top.
if (chosen_y < 4) %ie 'position' rather than velocity etc picked as y
    y_left = data(:,chosen_y+1); %since 'time' choice is left out for y, add 1 to correlate with right column in data matrix; thus choice 1 for y correlates to col 2 in data cols
    y_right = data(:,chosen_y+4); %yleft col + 3 correlates with the same y value type but for right eye instead of left
else %velocity picked as y
    y_left = v(:,chosen_y-3); %ex: choose choice 4 = horiz v, thus gets 4-3=1st col of v (left horiz v)
    y_right = v(:,chosen_y); %ex: 4th choice = 4th col of v (right horiz v)
end
for k = 1:3
    plot(x_left, y_left(:,k), 'b.', x_right, y_right(:,k), 'r.');
end

%%
%plot and save figures for all the default graphs
% for k = 1:3 %handle horiz vs time, vert vs time, tor vs time
%     if (k < 4) %ie 'position' rather than velocity etc picked as y
%         y_left = data(:,k+1); %since 'time' choice is left out for y, add 1 to correlate with right column in data matrix; thus choice 1 for y correlates to col 2 in data cols
%         y_right = data(:,k+4); %yleft col + 3 correlates with the same y value type but for right eye instead of left
%     else %velocity picked as y
%         y_left = v(:,k-3); %ex: choose choice 4 = horiz v, thus gets 4-3=1st col of v (left horiz v)
%         y_right = v(:,k); %ex: 4th choice = 4th col of v (right horiz v)
%     end
%     plot(x_left, y_left, 'b.', x_right, y_right, 'r.');
%     switch chosen_x
%         case 8
%             chosen_x = 1; %for time label
%         case 9
%             chosen_x = 4; %for tor label
%     end
axis tight; %rescale axes
x_axis = menu_options(1); %time label
xlabel(x_axis);
y_axis = menu_options(k+1); %+1 since menu options still includes time first.
ylabel(y_axis);
h = strcat(filename, ': ', y_axis, '-vs-', x_axis);
title(h);
hline(0,'k-'); %need the hline and vline .m function files
vline(0,'k-');
print(strcat(pathname, 'figure', num2str(k)),'-dtiff','-r300');
%csvwrite('filtered_data.csv',data);
%%
%begin saving data (data table)
col_headers = {'time [s]' 'right horiz [deg]' 'left horiz' 'right vert' 'left vert' 'right tor' 'left tor' 'right horiz velocity [deg/s] (calculated)' 'left horiz v' 'right vert v' 'left vert v' 'right tor v' 'left tor v'};  
all_raw_data=[data(:,1), data(:,3), data(:,2), data(:,6), data(:,3), data(:,7), data(:,4), v(:,4), v(:,1), v(:,5), v(:,2), v(:,6), v(:,3)];
all_stat_data= {'range: ' sprintf('%.3f, ',range(all_raw_data(:,2:length(all_raw_data(1,:)))));
    'mean: ' sprintf('%.3f, ',mean(all_raw_data(:,2:length(all_raw_data(1,:))))); 
    'stdev: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:))))); 
    'stderror: ' sprintf('%.3f, ',(std(all_raw_data(:,2:length(all_raw_data(1,:)))))/sqrt(length(time)))};
%following manipulation in order to write strings (col
%headers) to a csv file, which can be opened using excel directly. this writes an extra , at the end of each row, but
%easier to understand
fid=fopen(strcat(pathname,'all_data.csv'),'wt');
fprintf(fid, '%s %.3f\n', 'total time selected (s):', time1-time0);
%count_saccades = 1;
%if (count_saccades)
    fprintf(fid, '%s %.2f\n', 'number of saccades: (need to implement)', [1234567]); %TODO
%end
for i=1:4
   fprintf(fid,'%s,',all_stat_data{i,:}); fprintf(fid,'\n');
end
fprintf(fid,'%s,',col_headers{:});
fprintf(fid,'\n');
num_rows = length(all_raw_data(:,1));
for i=1:num_rows
     fprintf(fid,'%.3f,',all_raw_data(i,:));
     fprintf(fid,'\n');
end
fclose(fid);

%saccade detection!!, error bars on graphs!!
%NaNs


%saccade detection prompt, saccade detection, stdev, stderr, range, mean,
%times
%2)export top #s
%plot each eye individually option.
%graph with a bar for stderr?
%equalize?
%find things that are NaN/weird non number values, delete those rows or
%else messes up the rest of the data (eg GoodLRUD stops at 36sec cuz of
%some symbols at the end, and renders mean/etc into NaNs)

%=====================
%TODO: maybe get rid of NaNs
%fourier analysis, power, etc. 


% 
% 3)calculate span/amplitude of the nystagmus over a range of time (avg value?standard error of the mean (SEM) = std deviation/sqrt(num of data pts))
% 	exportable, !!horiz to torsion, vert to torsion (for primary vision)
% -saccade detection: count # of nystagmus, with threshold (velocity spikes 10-30)?small saccades (patients asked to hold still), look for velocity spikes. (still use blink suppression)
% 	look through parsedata, may already be in there.
% 1)time bracketing (to get rid of weird data, for ex), can be visual or pick start/end times
% 2)export (main focus is for primary gaze with/without vision): total time, # of saccades, !!hor-vert-tor deviations and their std errors, make these default exports/plots, plot everything over time with eyes separately!!!?overview
% 
%-look at paper?s plots
%  
% Vomund patient ? size and # of nystagmus dec over time. Can try out on ?no vision? file, should be more pronounced. Velocity spikes threshold 5-50
% 
% Patient conditions: Cavernous malformations in brainstem, MS lesions in brainstem

end


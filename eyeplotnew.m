function [ output_args ] = eyeplot( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
hold off;
filterspec = '~/Desktop/school/eye research/pt exports/*.txt'; %set default dir and filetype
[filename, pathname, filterindex] = uigetfile(filterspec);
if isequal(filename,0)
   disp('User selected Cancel')
   return
else
   disp(['User selected', fullfile(pathname, filename), filename])
end

fid=fopen(fullfile(pathname, filename)); %ask for this later so can do primary gaze. works with Olheiser and Vomund LRUD
format = '%f %*f %f %*f %*f %f %*f %f %*f %*f %*f %*f %f %*f %*f %f %*f %f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f %*f';
data = textscan(fid, format,'HeaderLines',23,'CollectOutput',1, 'treatAsEmpty', 'ÿ'); %I kept the times but each interval is .016-.017 sec constant so unneeded
data = cell2mat(data);
data(any(isnan(data), 2), :) = []; %deletes all rows that have a NaN, which were converted from 'ÿ', clever useful matlab parts
num_rows = length(data(:,1));
%%
%todo - could consider doing this AFTER blinks, but then would need to
%calculate time diff between measurements instead of use static 1/60. maybe
%use ./ operation
cols = 2:7;
s=data(:,cols);
v = zeros(num_rows, length(cols));
%forward calculations for velocity
for n=1:(num_rows-1);
    v(n,:)=(s(n+1,:)-s(n,:))/(1/60); %1/60 hardcoded time difference between measurements for the goggle system
end
%todo deal with left edge! read matlab signal processing sample
v(num_rows,:) = 0; %not a good number to use.
%%
%blink suppression adjustment...
thres = input('Please input blink suppression threshold in deg/s (0 for none). ');
switch logical(true)
    case thres==0
        disp('No suppression.')
    case thres>0
        rows_to_remove = any(abs(v)>=thres, 2); %this records the rows that we want to remove for blink suppression! important
        %removes both eyes if one eye has a blink.
        v(rows_to_remove,:) = [];
        data(rows_to_remove,:) = [];
        disp(sprintf('Blinks suppressed, %d data points will be removed.', length(rows_to_remove)));
    otherwise
        disp('No suppression.')
end

%%
%CONSTANTSish...why doesn't matlab have constants?
time = data(:,1);
%%
%time bracketing
h = plot(time, data(:,2:4), 'b-', time, data(:,5:7), 'r-'); %plots all on one graph just for time bracketing purposes
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
idx0 = interp1(time,1:numel(time),time0,'nearest');
time0 = time(idx0);
idx1 = interp1(time,1:numel(time),time1,'nearest');
time1 = time(idx1);

%close(h);

%%
%crop data based on time bracket
data = data(idx0:idx1,:);
v = v(idx0:idx1,:);
time = data(:,1); %update time, using as a contant name convenience only

pathname = strcat(pathname,'figures/');
%if figures folder doesn't exist, create it
if(~exist(pathname))
    mkdir(pathname);
end

%%
%plotting options for an extra user-specified plot
%TODO: make the last 2 options the default...
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
    case {2,3,4}
        x_left = data(:,chosen_x);
        x_right = data(:,chosen_x+3);
    case {5,6,7} %velocity chosen
        x_left = v(:,chosen_x-4); %ex: choosing choice 5=horiz_v, so look at 5-4=1st col in v for left
        x_right = v(:,chosen_x-1); %and 4th col for right eye
    %note that if skipped, no x values set yet!
end

if chosen_x ~= 8 %if x is not special case plot, show extra plot y menu and then plot/save.
    chosen_y = menu('Choose a y', menu_options(2:7)); %I left out time as a choice for y, so menu_options start at col 2.
    %choice 1 = horiz, 2 = vert, 3 = tor, 4 = horiz v, 5 = vert v, 6 = tor
    if (chosen_y == 0)
      disp('User selected Cancel');
      return;
    end
    %gets the y data sets for later plotting, for extra graph
    if (chosen_y < 4) %ie 'position' rather than velocity etc picked as y
        y_left = data(:,chosen_y+1); %since 'time' choice is left out for y, add 1 to correlate with right column in data matrix; thus choice 1 for y correlates to col 2 in data cols
        y_right = data(:,chosen_y+4); %yleft col + 3 correlates with the same y value type but for right eye instead of left
    else %velocity picked as y
        y_left = v(:,chosen_y-3); %ex: choose choice 4 = horiz v, thus gets 4-3=1st col of v (left horiz v)
        y_right = v(:,chosen_y); %ex: 4th choice = 4th col of v (right horiz v)
    end
    %plot and save figure
    plot(x_left, y_left(:,1), 'b-', x_right, y_right(:,1), 'r-');
    axis tight; %rescale axes
    x_axis = menu_options(chosen_x);
    xlabel(x_axis);
    y_axis = menu_options(chosen_y+1); %+1 since menu options still includes time first.
    ylabel(y_axis);
    h = strcat(filename, ': ', y_axis, '-vs-', x_axis);
    title(h);
    hline(0,'k-'); %need the hline and vline .m function files
    vline(0,'k-');
    leading_name = 'extra-figure-';
    filenamesstruct = dir(strcat(pathname, leading_name,'*.tif'));
    fileindex = size(filenamesstruct);
    fileindex = fileindex(1); %will be 0 if there are no figures of this kind yet
    print(strcat(pathname, leading_name, num2str(fileindex)),'-dtiff','-r300');
end

%%
%for defaults (position vs time graphs) set hardcoded for now
x_left = time;
x_right = x_left;
chosen_y = 1:3;

%gets the y data sets for later plotting, for extra graph
%TODO refactor since code repeated from top.
if (chosen_y < 4) %ie 'position' rather than velocity etc picked as y
    y_left = data(:,chosen_y+1); %since 'time' choice is left out for y, add 1 to correlate with right column in data matrix; thus choice 1 for y correlates to col 2 in data cols
    y_right = data(:,chosen_y+4); %yleft col + 3 correlates with the same y value type but for right eye instead of left
else %velocity picked as y
    y_left = v(:,chosen_y-3); %ex: choose choice 4 = horiz v, thus gets 4-3=1st col of v (left horiz v)
    y_right = v(:,chosen_y); %ex: 4th choice = 4th col of v (right horiz v)
end

peak_table = struct('name',{}, 't',{}, 'v',{}, 's',{});
%this will record all the info on peaks. struct field names are obvious.
%there are 6 of these entries (1- right horiz, 2- left horiz, right vert, left
%vert, right tor, left tor)
col_headers = {'time [s]' 'right horiz [deg]' 'left horiz' 'right vert' 'left vert' 'right tor' 'left tor' 'right horiz velocity [deg/s] (calculated)' 'left horiz v' 'right vert v' 'left vert v' 'right tor v' 'left tor v'};  
for k = 1:3 %TODO maybe refactor so it's 1:6, combine y_left and right? so that no inner for loop/calculations
    plot(x_left, y_left(:,k), 'b-', x_right, y_right(:,k), 'r-');
    axis tight; %rescale axes
    x_axis = menu_options(1); %time label
    xlabel(x_axis);
    y_axis = menu_options(k+1); %+1 since menu options still includes time first.
    ylabel(y_axis);
    h = strcat(filename, ': ', y_axis, '-vs-', x_axis);
    title(h);
    hline(0,'k-'); %need the hline and vline .m function files
    vline(0,'k-');
    leading_name = 'position-vs-time-';
    filenamesstruct = dir(strcat(pathname, leading_name,'*.tif'));
    fileindex = size(filenamesstruct);
    fileindex = fileindex(1); %will be 0 if there are no figures of this kind yet
    print(strcat(pathname, leading_name, num2str(fileindex)),'-dtiff','-r300');
    
    y_both = [y_right(:,k), y_left(:,k)];
    eyes = {' RIGHT' ' LEFT'};
    for i = 1:2 %right eye, left eye
        x = time;
        y = y_both(:,i);
        [maxtab, mintab] = peakdet(y', .5, x');
        plot(x, y,'-',maxtab(:,1),maxtab(:,2),'ro', mintab(:,1), mintab(:,2), 'go', 'linewidth',1);
        xlabel(x_axis);
        ylabel(strcat(y_axis, eyes(i)));
        title(strcat(h, eyes(i)));
        hline(0,'k-');
        vline(0,'k-');
        axis tight;
        leading_name = 'PEAKS-position-vs-time-';
        filenamesstruct = dir(strcat(pathname, leading_name,'*.tif'));
        fileindex = size(filenamesstruct);
        fileindex = fileindex(1); %will be 0 if there are no figures of this kind yet
        print(strcat(pathname, leading_name, num2str(fileindex)),'-dtiff','-r300');
        %size(mintab)
        hold off;
        %TODO: something wrong here!! file names/labels/etc don't match
        %when file counts are off??
        curr_peak_col = k*i;
        peak_table(curr_peak_col).t = maxtab(:,1);
        peak_table(curr_peak_col).v = v(maxtab(:,3));
        peak_table(curr_peak_col).s = maxtab(:,2);
        peak_table(curr_peak_col).name = col_headers{(curr_peak_col)+1}; %better way?
        size(maxtab(:,1))
        %TODO - mins as well!!!
        %save maxtab, mintab, and titles
    end
    
%     for i=1:6
%         
%         %     %this method seems redundant--made matrix into cell array, then get
%         %     %elements of cell array, then save back into cell array. maybe just
%         %     %think about appending to a new cell array per each col thing.
%         %     curr_col = ordered_velocities{i};
%         %     curr_col(non_peak_locs(:,i)) = [];
%         %     ordered_velocities{i} = curr_col;
%         peak_table(i).t = maxtab(:,1);
%         peak_table(i).v = curr_col_v;
%         peak_table(i).s = maxtab(:,2);
%         peak_table(i).name = col_headers{i+7}; %better way?
%     end

end
%aug 7 TODO - velocity outputs using
%peakdet, counts for overall thing, then separate velocity outputs
%center data around means

disp(peak_table);


%%
%for defaults (velocity vs time graphs) set hardcoded for now
x_left = time;
x_right = x_left;
chosen_y = 4:6;
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
    plot(x_left, y_left(:,k), 'b-', x_right, y_right(:,k), 'r-');
    axis tight; %rescale axes
    x_axis = menu_options(1); %time label
    xlabel(x_axis);
    y_axis = menu_options(k+4); %+4 since menu options still includes time, then the positions first.
    ylabel(y_axis);
    h = strcat(filename, ': ', y_axis, '-vs-', x_axis);
    title(h);
    hline(0,'k-'); %need the hline and vline .m function files
    vline(0,'k-');
    %save based on # of 'velocity-vs-time' files, so will always add on
    %instead of overwrite. same with other figures saved.
    leading_name = 'velocity-vs-time-';
    filenamesstruct = dir(strcat(pathname, leading_name,'*.tif'));
    fileindex = size(filenamesstruct);
    fileindex = fileindex(1); %will be 0 if there are no figures of this kind yet
    %match = strncmp(leading_name, name, length(leading_name));
    print(strcat(pathname, leading_name, num2str(fileindex)),'-dtiff','-r300');
end

%%
%begin calculating stats and saving data (data table)
%col_headers = {'time [s]' 'right horiz [deg]' 'left horiz' 'right vert' 'left vert' 'right tor' 'left tor' 'right horiz velocity [deg/s] (calculated)' 'left horiz v' 'right vert v' 'left vert v' 'right tor v' 'left tor v'};  
all_raw_data=[data(:,1), data(:,3), data(:,2), data(:,6), data(:,3), data(:,7), data(:,4), v(:,4), v(:,1), v(:,5), v(:,2), v(:,6), v(:,3)];
%TODO - maybe fix this so that it is always in this order instead of
%varying somehow?
ordered_amps = all_raw_data(:,1:7);
ordered_velocities = all_raw_data(:,8:13); %for convenience reference
%ordered_times = time(:,ones(1,6));

%%
%for defaults (position vs time graphs) set hardcoded for now
x_left = time;
x_right = x_left;
chosen_y = 1:3;
%gets the y data sets for later plotting, for extra graph
%TODO refactor since code repeated from top.
if (chosen_y < 4) %ie 'position' rather than velocity etc picked as y
    y_left = data(:,chosen_y+1); %since 'time' choice is left out for y, add 1 to correlate with right column in data matrix; thus choice 1 for y correlates to col 2 in data cols
    y_right = data(:,chosen_y+4); %yleft col + 3 correlates with the same y value type but for right eye instead of left
else %velocity picked as y
    y_left = v(:,chosen_y-3); %ex: choose choice 4 = horiz v, thus gets 4-3=1st col of v (left horiz v)
    y_right = v(:,chosen_y); %ex: 4th choice = 4th col of v (right horiz v)
end
for k = 1:3
    plot(x_left, y_left(:,k), 'b-', x_right, y_right(:,k), 'r-');
    axis tight; %rescale axes
    x_axis = menu_options(1); %time label
    xlabel(x_axis);
    y_axis = menu_options(k+1); %+1 since menu options still includes time first.
    ylabel(y_axis);
    h = strcat(filename, ': ', y_axis, '-vs-', x_axis);
    title(h);
    hline(0,'k-'); %need the hline and vline .m function files
    vline(0,'k-');
    leading_name = 'position-vs-time-';
    filenamesstruct = dir(strcat(pathname, leading_name,'*.tif'));
    fileindex = size(filenamesstruct);
    fileindex = fileindex(1); %will be 0 if there are no figures of this kind yet
    print(strcat(pathname, leading_name, num2str(fileindex)),'-dtiff','-r300');
end
%%
% x = time;
% y = data(:,4);
% [maxtab, mintab] = peakdet(y', .5, x');
% plot(x,y,'-',maxtab(:,1),maxtab(:,2),'ro','linewidth',1);
% hold on;
% plot(x,y,'-',mintab(:,1),mintab(:,2),'go','linewidth',1);
% size(maxtab)
% size(mintab)
% hold off;



%do times one by one instead beginning of try. continue this if above does
%not work
% for i=1:6 %get times for each peak
%     col_time = time;
%     col_time(non_peak_locs(:,i)) = []; %get rid of the non peaks for each column's individual times.
%     col_header = {'time [s]' 'peak [deg/s]'};
%     col_output = [col_time, ordered_velocities(:,i)];
%     
% end

% x = time;
% y = v(:,3); %left tor v
% [maxtab, mintab] = peakdet(data(:,4), 4, x)
% plot(x,y,'.-',maxtab(:,1),maxtab(:,2),'ro','linewidth',1);


%DUNDUNDUUUUN!! hamsterrr moment of truth--seems ot work. needs more
%saccade sensitivity
%TODO: mins too, and of course smoothing!!!
%test graphs below
plot(x,y,'.-',peak_table(6).t,peak_table(6).v,'ro','linewidth',1);
y = data(:,4);
plot(x,y,'.-',peak_table(6).t,peak_table(6).s,'ro','linewidth',1);


saccade_counts = zeros(1,6);
for i=1:6
    saccade_counts(i) = length(peak_table(i).t);
end
all_stat_data= {
    'largest range: ' sprintf('%.3f, ',range(all_raw_data(:,2:length(all_raw_data(1,:)))));
    'mean: ' sprintf('%.3f, ',mean(all_raw_data(:,2:length(all_raw_data(1,:))))); 
    'stdev: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:))))); 
    'stderror: ' sprintf('%.3f, ',(std(all_raw_data(:,2:length(all_raw_data(1,:)))))/sqrt(length(time)));
    'saccades/nystagmuses: ' strcat(',,,,,,', sprintf('%d, ',saccade_counts))};

%following manipulation in order to write strings (col
%headers) to a csv file, which can be opened using excel directly. this writes an extra , at the end of each row, but
%easier to understand
leading_name = 'all-data-';
filenamesstruct = dir(strcat(pathname, leading_name,'*csv'));
fileindex = size(filenamesstruct);
fileindex = fileindex(1); %will be 0 if there are none of this kind yet
fid=fopen(strcat(pathname, leading_name, num2str(fileindex), '.csv'),'wt');
fprintf(fid, '%s %.3f\n', 'total time selected (s):', time1-time0);
%TODO: right now just adding all saccades - but should just add together
%tor or horiz/vert right?
fprintf(fid, '%s %.2f\n', 'total saccades: (need to implement)', sum(saccade_counts)); %TODO
for i=1:5
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

%tests
%[peakLoc] = peakfinder(data(:,3), thres/60); %since 60 hz
%peakfinder(data(:,2), thres/60);

% peakLoc = peakfinder(data(:,7), thres/60);
% peakfinder(data(:,7), thres/60)
% disp(length(peakLoc));
% peakLoc = peakfinder(data(:,4), thres/60);
% peakfinder(data(:,4), thres/60)
% disp(length(peakLoc));

%other method, findpeaks
x = time;
y = data(:,4);
%P = findpeaks(time, data(:,4), thres, 4, 2, 3);
%disp(length(P));
%plot(x,y,'.-',P(:,2),P(:,3),'ro','linewidth',2);
%t=fpeak(x,y,1,[-inf,inf,-inf,inf]);
%plot(t(:,1),t(:,2),'o');
%plot(x,y,'.-',t(:,1),t(:,2),'ro','linewidth',2);

%disp(length(t));
%TODO close bracket window when done to avoid further thingy errors
%%
%second csv export - individual peak data for each dimension. so x3 files.
%but bottom stats same. just data for that dimension.
for j=1:3
    col_headers = {'peak #', 'peak time [s]' 'amplitude (peak to trough) [deg]' 'peak velocity of rise (only fall for first point) [deg/s]' 'peak velocity of fall [deg/s]'};
    %col_headers_2 = {'horizontal' 'vertical' 'torsional'};
    col_headers_2 = {'OD' 'OS' 'diff (OD-OS)'};
%     amplitude_data = {
%         'Amplitude (peak to trough in [deg]) data:';
%         'total # of peaks'; %move elsewhere? at top?
%         
%         'mean [deg]: ' sprintf('%.3f, ',mean(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         'min [deg]: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         'max [deg]: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         'SEM: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         'stdev: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         
%         
%         velocity_data = {
%         'Velocity (trough to peak (rise) over time in [deg/s]) data:';
%         'rise [deg/s] data';
%         'mean [deg]: ';
%         'min [deg/s]: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         'max [deg/s]: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         'SEM: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%         
%         
%         'stdev: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%    
%     'fall [deg/s] data';
%     'mean [deg]: ';
%     
%     'min [deg/s]: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%    
%     'max [deg/s]: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%     
%     'SEM: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
%    
%     'stdev: ' sprintf('%.3f, ',std(all_raw_data(:,2:length(all_raw_data(1,:)))));
    
    %following manipulation in order to write strings (col
    %headers) to a csv file, which can be opened using excel directly. this writes an extra , at the end of each row, but
    %easier to understand
    leading_name = 'peak-data-';
    filenamesstruct = dir(strcat(pathname, leading_name,'*csv'));
    fileindex = size(filenamesstruct);
    fileindex = fileindex(1); %will be 0 if there are none of this kind yet
    fid=fopen(strcat(pathname, leading_name, num2str(fileindex), '.csv'),'wt');
    fprintf(fid, '%s %.3f\n', 'total time selected (s):', time1-time0);
    %fprintf(fid, '%s %.2f\n', 'total saccades: (need to implement)', sum(saccade_count)); %TODO
%     for i=1:5
%         fprintf(fid,'%s,',all_stat_data{i,:}); fprintf(fid,'\n');
%     end
    fprintf(fid,'%s,',col_headers{:}, col_headers{:});
    fprintf(fid,'\n');
    num_rows = length(peak_table(i).t);
    for i=1:num_rows
        fprintf(fid,'%d,%.3f,%.3f,.%3f', i, peak_table(i).t, peak_table(i).s, peak_table(i).v);
        fprintf(fid,'\n');
    end
    fclose(fid);
end

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


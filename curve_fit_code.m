obj = VideoReader('fin.mov'); % Reads the Video
vid = read(obj);
frames = obj.NumberOfFrames; % Exports the total number of frames to a variable
warning('off'); % Removes all warnings
t = 1;  % Change this value to skips frames

x = 1:t:frames; % Array of all frames
le = length(x);

currDate = strrep(datestr(datetime), ' ', '_');
baseFolder = '/Users/fammas.maz/Downloads/matlab_image/images/';

destinationFolder = strcat(baseFolder, currDate, '/');

mkdir(destinationFolder);

j = 1;

for x = 1:t:frames

    imwrite(vid(:,:,:,x),strcat(destinationFolder,num2str(j),'.png')); % Writes all frames to a the current dir
    j = j+1;

end

dinfo = dir(strcat(destinationFolder,'*.png')); % Selects all the png files extracted earlier
filenames = {dinfo.name};
sorted = natsortfiles(filenames); % Puts them sorted into a cell

s = numel(sorted);
d = destinationFolder;

% Creating different cells for variables

c = cell(1,s);
p = cell(1,s);
v = cell(1,s);
mu = cell(1,s);
S = cell(1,s);
delta = cell(1,s);
y = cell(1,s);
x = cell(1,s);
errorfinal =cell(1,s);

for k=1:s
  % Image Processing
       F = fullfile(d, sorted(1, k));
       F = cell2mat(F);
       c{k} = imread(F);
       I = rgb2gray(c{k});
       BW = im2bw(I, 0.2);
% Collecting Data Points
       [row, col] = find(BW==0);
       row = -1*row;
       y{k} = row;
       x{k} = col;

       i = 1;
       errorfinal{k} = 100;

% Curve fitting and iterating over a single frame 
       while ((errorfinal{k} > 5) && (i <= 10))
           [p{k},S{k},mu{k}] = polyfit(x{k},y{k},i); % Outputs the values of p, S, mu
           [v{k},delta{k}] = polyval(p{k}, x{k}, S{k}, mu{k}); % Outputs the values of v and delta which is abs error
           i = i+1;
           err = delta{k}.^2;
           err_mean = mean(err);
           errorfinal{k} = sqrt(err_mean); % Finds Confidence of the fit
       end
       p{k} = polyfit(x{k},y{k},i-1);
       v{k} = polyval(p{k}, x{k});

       fprintf("\n\nFrame %d Info: \n\n", k)
       fprintf("The Degree of the Equation Fitted is %d\n", i-1)
       fprintf("The Confidence of the fit in Frame %0.3f\n", errorfinal{k})

       u =length(p{k});


       fprintf(['Equation of the curve is:\ny = ' repmat('%0.16fx + ',1,numel(p{k}))] , p{k} )


end

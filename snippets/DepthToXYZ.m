%cd(fileparts(mfilename('fullpath')))
cd('C:\Users\Federico\Desktop\Computer vision\RoomReconstruction\tiffiles');
clear all; close all;

%% Calculating cartesian coordinates
load('panorama.mat');
framepath = panorama;
%depthmat = panorama;
%load(framepath);
depthmat = imrotate(framepath, 90);

% the variables we know (set these yourself)
panoSize = size(depthmat(:,:,1));
width = panoSize(1);
height = panoSize(2);
ycenter = 209.5835;
xcenter = 260.1922;
HfoclenInPixels = 365.5953;
VfoclenInPixels = 365.5953;


% create convinient matrices for the coordinate calculation (way faster than for-loops!)
yv = linspace(0,height-1, height);
yv = yv';
yv = yv - (ycenter);
yv = repmat(yv, 1, width);
yv = yv*-1;

xv = linspace(0,width-1, width);
xv = xv - xcenter;
repmat(xv, height, 1);
xv = repmat(xv, height, 1);



% beginning
i = 1;
while(exist(framepath))
    
    i=i+1;

    % make sure that the frame is compatible with the code
    if (size(depthmat,1)~= height)
        depthmat = rot90(depthmat,-1);
    end
    if (~isfloat(depthmat))
       depthmat = cast(depthmat,'double'); 
    end

    % the actual coordinate calculation
    yw = (depthmat.*yv)/VfoclenInPixels;
    xw = (depthmat.*xv)/HfoclenInPixels;
    zw = depthmat;
    
    
    save(framepath , 'xw', 'yw', 'zw');
    
    framepath = strcat('frame',num2str(i),'.mat');
    try 
        load(strcat('frame',num2str(i),'.mat'));
    catch

    end
end


% For Visualization

%v is used to reduce the number of points to show 
% numPoints = height*width;
% for k=1:100000
%     v(k) = numPoints;
% end
v=randi(height*width,100000,1);

% vectorizing the data, for input to scatter3
xs = xw(:);
ys = yw(:);
zs = zw(:);
%v = size(xs,1)
% Plot
xs = imfill(xs);
ys = imfill(ys);
zs = imfill(zs);
%[xs ys zs] = sphere();
scatter3(xs(v), zs(v), ys(v),30,zs(v),'.');
%[THETA,RHO,Z] = cart2pol(xs,zs,ys);
%scatter3(THETA, Z, RHO,30,Z,'.');
% colomap and bar
colormap(gray);
colorbar;
clear all;
axis equal;
delete('panorama.mat');
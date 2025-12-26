%% Input Kinect
info = imaqhwinfo('kinect'); %Info Kinect
vid = videoinput('kinect',1);%Canale RGB
vid2 = videoinput('kinect',2);%Canale Depth
depthDevice = imaq.VideoDevice('kinect',2);%Stream Canale Depth
% preview(vid); 


% pause(3);
% closepreview(vid);
% preview(vid2);
% pause(3);
% closepreview(vid2);
%%

%% Parametri Acuisizione
%value = input('\nCapture = 0\nFinish = 1\n');
num = 500;%Numero acquisizioni Kinect;
numAcq = 1;
%%
rcDepth = getselectedsource(vid2); %Ottengo depth map
    vid.FramesPerTrigger = 1; %imposto il trigger
    vid2.FramesPerTrigger = 1;
    vid.TriggerRepeat = 1;
    vid2.TriggerRepeat = 1;
    triggerconfig([vid vid2],'manual');%Sincronizzo l'acquisizione manualmente
%% Acquisizione al trigger '0'
%while value~=1 %
for x=1:num
    %pause(1);
    
    %for k =1:num
        start([vid vid2]);%Inizio l'acquisizione stream RGB+Depth
            for i = 1:2
                trigger([vid vid2])
                [imgColor, ts_color, metaData_Color] = getdata(vid);%Ottengo lo stream RGB
                [imgDepth, ts_depth, metaData_Depth] = getdata(vid2);%Ottengo lo stream Depth
            end
        display('Computing PointCloud...');
        xyzPoints = depthToPointCloud(imgDepth,depthDevice);%Converto Depth a coordinate PC
        alignedColorImage = alignColorToDepth(imgDepth,imgColor,depthDevice);%Allineo RGB & Depth
        ptCloud = pointCloud(xyzPoints);%Converto le coordinate in PC
        ptCloud.Color = alignedColorImage;%Allineo i PC
        roomData{1,numAcq} = ptCloud;%Salvo array di PCs
        numAcq = numAcq+1
    end
        clearvars -except roomData i numAcq depthDevice vid vid2 num room;%Cancello vars per nuovo ciclo
        
    %end
    %clear value;
   % value = input('Capture = 0\nFinish = 1\n');%Richiesta nuova acquisizione
%end
clearvars -except roomData room; close all;
%save('room.mat');%Salvataggio array di PCs
%clear all; close all;

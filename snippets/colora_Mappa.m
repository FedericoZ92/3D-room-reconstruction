%% Select Folder.
d = dir('C:\Users\Federico\Desktop\Computer vision\RoomReconstruction\*.MAT');
numElem = length(d);
%%

%% 

%%
maxDistKinect = 8000;
maxValuint16 = 65535;
multFact = maxValuint16/maxDistKinect;
%%
% maxVal = 0;
% for i=1:numElem
%     format = '.MAT';
%     Name = 'Depthframe';
%     num = int2str(i);
%     Vect = sprintf('%s%s%s',Name, num, format);
%     load(Vect);
%     maxElem = max(depthmat(:));
%     if maxElem>maxVal
%         maxVal = maxElem;
%     end
% end
%multConst = ((2^(16))-1)/maxVal;
for i=1:numElem
    format = '.MAT';
    Name = 'Depthframe';
    num = int2str(i);
    Vect = sprintf('%s%s%s',Name, num, format);
    load(Vect);
    width = size(depthmat,1);
    heigth = size(depthmat,2);
    for j=1:width
        for k=1:heigth
            Image(j,k) = depthmat(j,k).*(multFact);
        end
    end
    roundImg = floor(Image);
    roundImg = imrotate(roundImg, 270);
    grayImg = uint16(roundImg);%im2double
    imgName = sprintf('%d.tiff', i);
    imwrite(grayImg, imgName);
    clearvars -except numElem i multFact;
end
%%
l = size(roomData,2);
for i=1:l
    roomData1{i} = pcdenoise(roomData{i});
end
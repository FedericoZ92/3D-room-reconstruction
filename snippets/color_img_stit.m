clc;
clear all;
close all;
 
I1 = imread('4.tiff');
I2 = imread('5.tiff');

F = im2double(I1);
S = im2double(I2);
F(:,:,2) = F(:,:,1);
F(:,:,3) = F(:,:,1);
S(:,:,2) = S(:,:,1);
S(:,:,3) = S(:,:,1);
[rows cols] = size(F(:,:,1));

Tmp = [];

temp = 0;

for j = 1:cols-5% to prevent j to go beyond boundaries.
    for i = 1:rows
        temp = temp + (F(i,j,1) - S(i,1,1))^2;
        temp = temp + (F(i,j+1,1) - S(i,2,1))^2;
        temp = temp + (F(i,j+2,1) - S(i,3,1))^2;
        temp = temp + (F(i,j+3,1) - S(i,4,1))^2;
        temp = temp + (F(i,j+4,1) - S(i,5,1))^2;
    end
    Tmp = [Tmp temp]; % Tmp keeps growing, forming a matrix of 1*cols
    temp = 0;
end
% 

[Min_value, Index] = min(Tmp);

n_cols = Index + cols - 1;% New column of output image.

Opimg = [];
for i = 1:rows
    for j = 1:Index-1
        for y = 1:3
            Opimg(i,j,y) = F(i,j,y);% First image is pasted till Index.
        end
    end
    for k = Index:n_cols-1
        for y = 1:2
            Opimg(i,k,y) = S(i,k-Index+1,y);%Second image is pasted after Index.
        end
    end    
end

[r_Opimg c_Opimg] = size(Opimg(:,:,1));


subplot(1,3,1);
imshow(F);axis ([1 c_Opimg 1 c_Opimg])
title('First Image');

subplot(1,3,2);
imshow(S);axis ([1 c_Opimg 1 c_Opimg])
title('Second Image');

subplot(1,3,3);
imshow(Opimg);axis ([1 c_Opimg 1 c_Opimg])
title('Stitched Image');


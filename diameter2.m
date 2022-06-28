%% Import Image

clear;
clc;

obj = imread('ball.jpg');
imshow(obj)

%% Segment Image

%Divide image "obj" into its respective RGB intensities
red = obj(:,:,1);
green = obj(:,:,2);
blue = obj(:,:,3);

figure(1)
subplot(2,2,1); imshow(obj); title('Original Image');
subplot(2,2,2); imshow(red); title('Red Plane');
subplot(2,2,3); imshow(green); title('Green Plane');
subplot(2,2,4); imshow(blue); title('Blue Plane');

%Threshold the blue plane
figure(2)
level = 0.37;
bw2 = imbinarize(blue,level);
subplot(2,2,1); imshow(bw2); title('Blue plane thresholded');

%% Remove Noise

%Fill any holes
fill = imfill(bw2,'holes');
subplot(2,2,2); imshow(fill); title('Holes filled');

%Remove and blobs on the border of the image
clear = imclearborder(fill);
subplot(2,2,3); imshow(clear); title('Remove blobs on border');

%Remove blobs that are smaller than 7 pixels across
se = strel('disk',7);
open = imopen(fill,se);
subplot(2,2,4); imshow(open); title('Remove small blobs');

%% Measure Object Diameter


%Show result
figure(3)
imshow(obj)
d = imdistline(gca); %Include a line to physically measure the ball
api=iptgetapi(d);
%
pause();
%
dist=api.getDistance();
u=menu('Choose Measuring unit','Pixels','Centimeters','Inches');
if(u==1)
    fprintf('The length of the object is: %0.2f Pixels',dist)
elseif(u==2)
    dist_cm=dist*0.0264583333;
    fprintf('The length of the object is: %0.2f CMs',dist_cm)
else
    dist_in=dist*0.01041666666667;
    fprintf('The length of the object is: %0.2f Inches',dist_in)
end
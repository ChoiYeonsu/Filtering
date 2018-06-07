close all;
clc;
clear all

img = imread('bab.png');
if size(img,3)==3
    img = rgb2gray(img);
end
subplot(1,2,1); imshow(img)
title('image with Noise');


sigma = input('sigma=');
filter_size = 5 * sigma;

padding = floor(filter_size/2)
[x,y]=meshgrid(-padding:padding, -padding:padding);
img_padding = zeros(size(img) + padding*2);
M = size(x,1)-1;
N = size(y,1)-1;
e = -(x.^2+y.^2)/(2*sigma*sigma);
kernel = exp(e)/(2*pi*sigma*sigma);

for k=1:size(img,1)
    for l=1:size(img,2)
         img_padding(k+padding, l+padding) = img(k,l);
    end
end

output = zeros(size(img));

for i=1:size(img_padding,1)-M
    for j=1:size(img_padding,2)-N
        Temp = img_padding(i:i+M,j:j+M).*kernel;
        output(i,j)=sum(Temp(:));
    end
end
img = uint8(img);
output = uint8(output);

subplot(1,2,2); imshow(output)
title('filter Image');
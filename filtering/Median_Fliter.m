close all;
clc;
clear all

img = imread('salt_pepper.png');
%filter size
filter_size = input('filter_size = ');
padding = (filter_size-1)/2;
Median_filter = zeros(filter_size, filter_size);
img_padding = zeros(size(img) + padding*2);

%������ ������ �е�
for x=1:size(img,1)
    for y=1:size(img,2)
        img_padding(x+padding, y+padding) = img(x,y);
    end
end
%���ο� ���� 
new_img = zeros(size(img));

%������ ���͸� ����
for i = 1:size(img,1)
    for j = 1:size(img,2)
        for x = 1:filter_size
            for y = 1:filter_size
                Median_filter(x,y) = img_padding(i+x-1, j+y-1);
            end
        end
        sort_median=sort(Median_filter(:));
        %�迭�� �߾Ӱ� ���
        new_img(i,j) = sort_median((filter_size^2+1)/2);
    end
end

new_img = uint8(new_img);

subplot(1,2,1);imshow(img);title('salt pepper image');
subplot(1,2,2);imshow(new_img);title(sprintf('filter size=%d',filter_size));
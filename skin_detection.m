clc;
close all;
clear all;

% read image RGB
img_rgb = imread('images/img_1.jpg');

% Otsu binarization and thresholding of image
img_grayscale = rgb2gray(img_rgb);
bw_threshold_level = graythresh(img_grayscale);
img_bw = imbinarize(img_grayscale, bw_threshold_level);
img_bw = uint8(img_bw);

% first thresholding pass
img_no_bg = (img_rgb .* img_bw);
figure;
imshow(img_no_bg);

% initialize thresholding masks
threshold_H = zeros(size(img_rgb(:, :, 1)));
threshold_Cb = zeros(size(img_rgb(:, :, 1)));
threshold_Cr = zeros(size(img_rgb(:, :, 1)));

% to HSV threshold and remove non-potential skin pixels
img_HSV = rgb2hsv(img_no_bg);
img_H = img_HSV(:, :, 1);
threshold_H(img_H <= 0.95) = 1;

% to YCbCr threshold and remove non-potential skin pixels
img_YCbCr = rgb2ycbcr(img_no_bg);
img_Cb = img_YCbCr(:, :, 2);
threshold_Cb(img_Cb >= 90 & img_Cb <= 120) = 1;
img_Cr = img_YCbCr(:, :, 3);
threshold_Cr(img_Cr >= 140 & img_Cr <= 170) = 1;

% consolidate into a single thresholding mask
threshold_img = cat(3, threshold_H, cat(3, threshold_Cb, threshold_Cr));
threshold_img = sum(threshold_img, 3);
threshold_img(threshold_img < 3) = 0;
threshold_img(threshold_img > 0) = 1;

% second thresholding pass
threshold_img = uint8(threshold_img);
img_skin_only = threshold_img .* img_no_bg;
figure;
imshow(img_skin_only);

% average remaining pixels for skin tone estimation
[skin_pixel_rows, skin_pixel_cols] = find(threshold_img == 1);
skin_pixel_indices = [skin_pixel_rows, skin_pixel_cols];

skin_pixel_colors = zeros(size(skin_pixel_indices, 1), 3);
for i = 1:size(skin_pixel_indices)
    color = img_no_bg(skin_pixel_indices(i, 1), skin_pixel_indices(i, 2), :);
    skin_pixel_colors(i, :) = reshape(color, 1, 3);
end

mean_color_RGB = mean(skin_pixel_colors, 1);
disp(mean_color_RGB);

patch_color = [mean_color_RGB(1)/255 mean_color_RGB(2)/255 mean_color_RGB(3)/255];
x = [0 1 1 0];
y = [0 0 1 1];
figure;
patch(x,y, patch_color);



% Kavish Patel
% Project #2
% runme.m
% Edge Enhancement using Roberts Gradient Masks (my Convolution)

% Clear workspace and close all figures
clc; clear; close all;

% Load the image
input_image = 'airplane_grayscale.png';
if ~isfile(input_image)
    error('The input image file "%s" is missing.', input_image);
end
img = imread(input_image);
img = im2gray(img);
img = double(img); % Convert to double for computations

% Parameters
T = 25; % Threshold
LG = 255; % Gradient scaling factor (for replacement)
LB = 0;  % Brightness scaling factor (for replacement)

% Define Roberts masks
Gx = [1 0; 0 -1];
Gy = [0 1; -1 0];

% Call the my_convolution function for each gradient
grad_x = my_convolution(img, Gx); % Gradient along Gx
grad_y = my_convolution(img, Gy); % Gradient along Gy

% Compute gradient magnitude
gradient_magnitude = sqrt(grad_x.^2 + grad_y.^2);

% Gradients based on requirements:
% 1. Grad1: Replace values by gradient in img if gradient > T, else keep original
grad1 = img;
grad1(gradient_magnitude > T) = gradient_magnitude(gradient_magnitude > T);

% 2. Grad2: Replace values by LG in img if gradient > T, else keep original
grad2 = img;
grad2(gradient_magnitude > T) = LG;

% 3. Grad3: Replace values by gradient in img if gradient > T, else replace with LB
grad3 = LB * ones(size(img)); % Initialize with LB
grad3(gradient_magnitude > T) = gradient_magnitude(gradient_magnitude > T);

% 4. Grad4: Replace values by LG in img if gradient > T, else replace with LB
grad4 = LB * ones(size(img)); % Initialize with LB
grad4(gradient_magnitude > T) = LG;

% Display all images
figure;

% Original Image
subplot(3, 2, 1), imshow(uint8(img)), title('Original Image');

% Gradients (Magnitude)
subplot(3, 2, 2), imshow(abs(gradient_magnitude), []), title('Gradient Magnitude');

% Processed Gradients (Grad1, Grad2, Grad3, Grad4)
subplot(3, 2, 3), imshow(uint8(grad1)), title('Grad1: G(f(x,y)) if G(f(x,y)) > T; else f(x,y)');
subplot(3, 2, 4), imshow(uint8(grad2)), title('Grad2: LG if G(f(x,y)) > T; else f(x,y)');
subplot(3, 2, 5), imshow(uint8(grad3)), title('Grad3: G(f(x,y)) if G(f(x,y)) > T; else LB');
subplot(3, 2, 6), imshow(uint8(grad4)), title('Grad4: LG if G(f(x,y)) > T; else LB');


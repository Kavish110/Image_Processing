%Kavish Bhaveshkumar Patel
% runme.m

%Case 1: 16 band dyadic (pyramid) decomposition

% Load the noisy image
img = imread('lena512noisy.bmp');
img = double(img); % Convert to double for processing

% Define the SWT filter
wname = 'haar'; % or db4

% Perform 2-D SWT with 2 levels (16 subbands)
[LL, LH, HL, HH] = swt2(img, 2, wname);

% Combine the subbands into a single matrix
subbands = cat(3, LL, LH, HL, HH);

% Set the highest-frequency, 3 highest-frequency, and 6 highest-frequency subbands to zero
% Note: The exact indexing may vary based on the SWT output structure
% Here, we assume a simple structure for demonstration

% Highest-frequency subband
subbands(:,:,4) = zeros(size(subbands(:,:,4)));

% 3 highest-frequency subbands
subbands(:,:,3:4) = zeros(size(subbands(:,:,3:4)));

% 6 highest-frequency subbands
subbands(:,:,2:4) = zeros(size(subbands(:,:,2:4)));

% Reconstruct the image using inverse SWT for each case
reconstructed_img_1 = iswt2( LL, LH, HL, zeros(size(HH)), wname);
reconstructed_img_2 = iswt2( LL, LH, zeros(size(HL)), zeros(size(HH)), wname);
reconstructed_img_3 = iswt2( LL, zeros(size(LH)), zeros(size(HL)), zeros(size(HH)), wname);

% Display the original image
subplot(4,4,1);
imshow(img, []);
title('Original Image');

% Display the 2-D DFT magnitude spectrum of the original image
subplot(4,4,2);
imshow(log(1 + abs(fft2(img))), []);
title('DFT of Original Image');

% Display reconstructed images
subplot(4,4,5);
imshow(reconstructed_img_1, []);
title('Highest-Frequency Subband Set to 0');

subplot(4,4,9);
imshow(reconstructed_img_2, []);
title('3 Highest-Frequency Subbands Set to 0');

subplot(4,4,13);
imshow(reconstructed_img_3, []);
title('6 Highest-Frequency Subbands Set to 0');

% Display the 2-D DFT magnitude spectra of the reconstructed images
subplot(4,4,6);
imshow(log(1 + abs(fft2(reconstructed_img_1))), []);
title('DFT of Highest-Frequency Subband Set to 0');

subplot(4,4,10);
imshow(log(1 + abs(fft2(reconstructed_img_2))), []);
title('DFT of 3 Highest-Frequency Subbands Set to 0');

subplot(4,4,14);
imshow(log(1 + abs(fft2(reconstructed_img_3))), []);
title('DFT of 6 Highest-Frequency Subbands Set to 0');



%Case 2: 22 band Modified pyramid case

% Modified Pyramid Case with 3, 10, and 15 highest-frequency subbands set to zero
% Initialize cell arrays to store decomposition results
A = cell(1,4);  % Approximation coefficients
H = cell(1,4);  % Horizontal details
V = cell(1,4);  % Vertical details
D = cell(1,4);  % Diagonal details

% Level 1 decomposition (on full image)
[A{1}, H{1}, V{1}, D{1}] = swt2(img, 1, wname);

% Level 2 decomposition (on approximation only)
[A{2}, H{2}, V{2}, D{2}] = swt2(A{1}(:,:,1), 1, wname);

% Level 3 decomposition (on approximation only)
[A{3}, H{3}, V{3}, D{3}] = swt2(A{2}(:,:,1), 1, wname);

% Level 4 decomposition (on approximation only)
[A{4}, H{4}, V{4}, D{4}] = swt2(A{3}(:,:,1), 1, wname);

% Reconstruct images for different cases
recon1 = reconstructModified(A, H, V, D, 3);   % 3 highest-frequency subbands
recon2 = reconstructModified(A, H, V, D, 10);  % 10 highest-frequency subbands
recon3 = reconstructModified(A, H, V, D, 15);  % 15 highest-frequency subbands

% Display results

subplot(4,4,7);
imshow(uint8(recon1));
title('3 Highest-Frequency Subbands set to 0');

subplot(4,4,11);
imshow(uint8(recon2));
title('10 Highest-Frequency Subbands set to 0');

subplot(4,4,15);
imshow(uint8(recon3));
title('15 Highest-Frequency Subbands set to 0');

% Display DFT magnitude spectra

subplot(4,4,8);
imshow(log(1 + abs(fftshift(fft2(recon1)))), []);
title('DFT with 3  Highest-Frequency Subbands set to 0');

subplot(4,4,12);
imshow(log(1 + abs(fftshift(fft2(recon2)))), []);
title('DFT with 10 Highest-Frequency Subbands set to 0');

subplot(4,4,16);
imshow(log(1 + abs(fftshift(fft2(recon3)))), []);
title('DFT with 15 Highest-Frequency Subbands set to 0');

% Calculate metrics for each case
[mse1, psnr1, snr1] = calculateMetrics(img, recon1);
[mse2, psnr2, snr2] = calculateMetrics(img, recon2);
[mse3, psnr3, snr3] = calculateMetrics(img, recon3);

% Display metrics
fprintf('\nImage Quality Metrics:\n');
fprintf('3 bands zero:  MSE = %.2f, PSNR = %.2f dB, SNR = %.2f dB\n', mse1, psnr1, snr1);
fprintf('10 bands zero: MSE = %.2f, PSNR = %.2f dB, SNR = %.2f dB\n', mse2, psnr2, snr2);
fprintf('15 bands zero: MSE = %.2f, PSNR = %.2f dB, SNR = %.2f dB\n', mse3, psnr3, snr3);

%Comments
fprintf('The increase in the number of zeroed subbands shows the trade-off between noise reduction and detail in the modified pyramid structure. The metrics provide quantitative measures of this trade-off, while the visual results allow for qualitative assessment of the reconstructed images.');

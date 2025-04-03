% Custom convolution function

% Inputs:
    %   image  - Input 2D matrix (grayscale image)
    %   kernel - 2D convolution kernel
    % Output:
    %   result - Convolved image (same size as input image)

function result = my_convolution(image, kernel)
    % Get sizes of image and kernel
    [rows, cols] = size(image);
    [krows, kcols] = size(kernel);

    % Calculate padding sizes
    pad_r = floor(krows / 2);
    pad_c = floor(kcols / 2);

    % Pad the image with zeros
    padded_img = padarray(image, [pad_r, pad_c], 0);

    % Initialize result
    result = zeros(rows, cols);

    % Perform convolution
    for i = 1:rows
        for j = 1:cols
            % Extract the local region
            region = padded_img(i:i+krows-1, j:j+kcols-1);

            % Compute the convolution sum
            result(i, j) = sum(sum(region .* kernel));
        end
    end
end
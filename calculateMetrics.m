% Calculate and display quality metrics
function [mse, psnr, snr] = calculateMetrics(original, reconstructed)
    mse = mean((original(:) - reconstructed(:)).^2);
    psnr = 10 * log10(255^2/mse);
    signal_power = mean(original(:).^2);
    noise_power = mse;
    snr = 10 * log10(signal_power/noise_power);
end
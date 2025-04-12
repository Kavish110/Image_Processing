# Image Processing Projects in MATLAB

This repository contains two mini-projects focused on digital image processing using MATLAB:

1. **Wavelet-Based Image Reconstruction and Quality Assessment**
2. **Edge Enhancement using Custom Convolution and Roberts Gradient**

---

## 📁 Wavelet-Based Image Reconstruction

This project uses Stationary Wavelet Transform (SWT) to analyze and reconstruct images after zeroing out certain high-frequency subbands. The goal is to evaluate the effect of frequency domain filtering on visual quality.

### Files

- `runme.m`: Main script to perform decomposition, reconstruction, and metric calculation.
- `reconstructModified.m`: Reconstructs images with selected frequency bands zeroed.
- `calculateMetrics.m`: Computes MSE, PSNR, and SNR for quality evaluation.

### Input

- Requires `lena512noisy.bmp` image in the working directory.

### Output

- Displays original, reconstructed images, and their DFTs.
- Prints image quality metrics (MSE, PSNR, SNR) for reconstructed results.

---

## 📁 Edge Enhancement using Custom Convolution

This project demonstrates how edge detection and enhancement can be performed using custom convolution and Roberts gradient masks. A user-defined convolution function is implemented to process the image, and edge details are enhanced based on gradient magnitude thresholds.

### Files

- `runme.m`: Main script that loads an image, computes gradients, applies edge enhancement strategies, and visualizes results.
- `my_convolution.m`: Implements custom 2D convolution using nested loops.

### Input

- Requires `airplane_grayscale.png` image in the working directory.

### Output

- Displays:
  - Original image
  - Gradient magnitude
  - Four gradient-enhanced versions based on different replacement rules.

### Processing Details

- **Roberts masks** are applied to compute edge gradients.
- Four versions of the enhanced image are created by combining gradient thresholds with fixed or original pixel values.

---

## ✅ Requirements

- MATLAB (R2021a or newer recommended)
- Image Processing Toolbox (for `im2gray`, etc.)
- Wavelet Toolbox (for SWT-related operations)

---


## 📁 Canny Edge detection

-Canny edge detection is a technique to extract useful structural information from different vision objects and dramatically reduce the amount of data to be processed. It has been widely applied in various computer vision systems. Canny has found that the requirements for the application of edge detection on diverse vision systems are relatively similar.
## 🧑‍💻 Author

**Kavish Bhaveshkumar Patel**

---

## 📌 Notes

- Ensure required image files (`lena512noisy.bmp`, `airplane_grayscale.png`) are placed in the same folder before running scripts.
- All computations use grayscale versions of images.
- Gradient-based enhancement shows the visual impact of different post-processing conditions.


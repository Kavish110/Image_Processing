# Canny Edge Detection in MATLAB (From Scratch)

This repository contains a custom implementation of the Canny edge detection algorithm in MATLAB. It demonstrates:
- Gaussian smoothing
Use a Gaussian filter to smooth the image and remove high-frequency noise.
- Gradient computation
Compute intensity gradients in the x and y directions. Calculate gradient magnitude and orientation.
- Non-maximum suppression
Thin out edges by suppressing all gradient magnitudes that are not local maxima along the gradient direction
- Double thresholding
High threshold: Edges above this threshold are considered strong.
Low threshold: Edges below this threshold are considered weak and require connection to strong edges for final acceptance.
- Edge tracking by hysteresis
Connect weak edges to strong edges if they are adjacent (8-connectivity). Retain weak edges that connect to strong edges; discard all others.


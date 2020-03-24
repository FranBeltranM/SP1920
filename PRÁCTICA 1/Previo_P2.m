C = imread("C1.jpg")

ROI = C < 120
imshow(ROI)
numPix = sum(ROI(:));

[f c] = find(ROI);
numPix2 = length(f);
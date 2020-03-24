clear all; clc;

I = imread('X.jpg');
Imagen = imread('ImagenBinaria.tif');

ROI = I<120;

Imagen

[Ietiq s] = Funcion_etiquetar(Imagen>100);
s

R = [255 0 0 255 255 0];
G = [0  255 0 255 0 255];
B = [0 0 255 0 255 255];

iColor = cat(3,Ietiq, Ietiq, Ietiq);
iColorR = iColor(:,:,1);
iColorG = iColor(:,:,2);
iColorB = iColor(:,:,3);

for i=1:s
    iColorR(iColorR == i) = R(i);
    iColorG(iColorG == i) = G(i);
    iColorB(iColorB == i) = B(i);
end

iColor = cat(3, iColorR, iColorG, iColorB);

imtool(iColor)
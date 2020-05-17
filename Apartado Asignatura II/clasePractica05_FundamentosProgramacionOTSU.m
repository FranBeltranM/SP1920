%% MÉTODO DE OTSU

clear, clc, close all
addpath('Funciones')
addpath('Imagenes')

I = imread('Matric.tif');
imshow(I), figure, imhist(I)

g_otsu = funcion_otsu(I)
255 * graythresh(I)

%% FUNCIÓN OTSU PARA DOS UMBRALES

I = imread('Matric2.tif');
close all,
figure, imshow(I), figure, imhist(I)

g_otsu = funcion_otsu(I)

[g1, g2] = funcion_otsu_2umb(I)

figure,
subplot(3,1,1), imshow(uint8(I))
subplot(3,1,2), funcion_visualiza(uint8(I), I<g1, [255 0 0])
subplot(3,1,3), funcion_visualiza(uint8(I), I>g1 & I<g2, [0 255 0])


%% APLICACIÓN EN OTRAS IMÁGENES

Ic = imread('nube.tif');
I = rgb2gray(Ic);
close all,
figure, imshow(Ic), figure, imhist(I)

T = funcion_otsu(I)

figure,
subplot(1,2,1), imshow(uint8(Ic))
subplot(1,2,2), funcion_visualiza(uint8(Ic), I>T, [255 255 0])

[g1, g2] = funcion_otsu_2umb(I)

figure,
subplot(1,3,1), imshow(uint8(Ic))
subplot(1,3,2), funcion_visualiza(uint8(Ic), I>g1, [255 255 0])
subplot(1,3,3), funcion_visualiza(uint8(Ic), I>g1 & I<g2, [255 0 0])

%% PRÁCTICA
clear, clc, close all

I1 = imread('A1.jpg');
I2 = imread('A2.jpg');
I3 = imread('A3.jpg');

g1_MinEntreMax = funcion_MinEntreMax(rgb2gray(I1), []);
g2_MinEntreMax = funcion_MinEntreMax(I2, []);
g3_MinEntreMax = funcion_MinEntreMax(I3, []);

g1_isodata = funcion_isodata(imhist(rgb2gray(I1)), 0);
g2_isodata = funcion_isodata(imhist(I2), 0);
g3_isodata = funcion_isodata(imhist(I3), 0);

g1_otsu = funcion_otsu(rgb2gray(I1));
g2_otsu = funcion_otsu(I2);
g3_otsu = funcion_otsu(I3);

[g1_MinEntreMax g2_MinEntreMax g3_MinEntreMax;
    g1_isodata g2_isodata g3_isodata;
    g1_otsu g2_otsu g3_otsu]

g1_otsuM = 255 * graythresh(rgb2gray(I1));
g2_otsuM = 255 * graythresh(I2);
g3_otsuM = 255 * graythresh(I3);

[g1_otsuM g2_otsuM g3_otsuM]
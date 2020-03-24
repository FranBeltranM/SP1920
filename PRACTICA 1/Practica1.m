% ----------------------------------------------------------------------------------------------------
% 8) Calcula en Matlab la imagen complementaria de Imagen1 , denominándola
% Imagen2. Visualiza esta imagen con la instrucción imtool. Guarda esta imagen en
% un fichero de imagen del mismo formato que la imagen original empleando la instrucción imwrite.

Imagen1 = imread("P1_1.jpg");

R=255-Imagen1(:,:,1);
G=255-Imagen1(:,:,2);
B=255-Imagen1(:,:,3);

RGB = struct('R', R, 'G', G, 'B', B);

Imagen2 = uint8([]);

Imagen2(:,:,1) = RGB.R;
Imagen2(:,:,2) = RGB.G;
Imagen2(:,:,3) = RGB.B;

%Imagen2 = cat(3, RGB.R, RGB.G, RGB.B);

figure, subplot(1,2,1), imshow(Imagen1), subplot(1,2,2), imshow(Imagen2)

% ----------------------------------------------------------------------------------------------------
% 9) 10)

Imagen3 = Imagen1(:,:,1);

Imagen4=imadjust(Imagen3,[],[],1.5);
Imagen5=imadjust(Imagen3,[],[],0.5);

figure, subplot(2,3,1), imshow(Imagen3), subplot(2,3,2), imshow(Imagen4), subplot(2,3,3), imshow(Imagen5);
subplot(2,3,4), imhist(Imagen3), subplot(2,3,5), imhist(Imagen4), subplot(2,3,6), imhist(Imagen5);

% ----------------------------------------------------------------------------------------------------
% 11)

Imagen6 = imabsdiff(Imagen4, Imagen5);
figure, subplot(1,3,1), imshow(Imagen4), subplot(1,3,2), imshow(Imagen5), subplot(1,3,3), imshow(Imagen6);

% Intentar funcion -> compara_matrices(matrizA, matrizB) sin devolver nada
% Hacer display con 2 mensajes, display('Matrices idénticas'), o display('Matrices distintas')

% Hacer función -> imabsdiff(imagenA, imagenB) -> otra imagenC, lo mismo que imabsdiff(nativa de matlab)
% Comprobar que hace lo mismo que la nativa

clear; clc;
Ic = imread("P1_1.jpg");
I = Ic(:,:,2);

h = imhist(I);
hm = funcion_imhist_v1(I);
hm2 = funcion_imhist_v2(I);

% x = 107 Y = 1056
funcion_compara_matrices(hm2,h)
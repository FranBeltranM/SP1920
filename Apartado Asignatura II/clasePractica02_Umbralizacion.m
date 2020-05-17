%% INTRODUCCIÓN AL PROBLEMA DE SEGMENTACIÓN - HISTOGRAMA BIMODAL
%% CLASES OBJETO-FONDO BIEN SEPARADAS

clear, clc, close all
addpath('Imagenes')
addpath('Funciones')

I = imread('Matric.tif');
imshow(I)
figure, imhist(uint8(I))


%% OBJETIVO: SELECCIONAR DE FORMA AUTOMÁTICA UMBRALES DE SEPARACIÓN ENTRE CLASES


%% PRIMERA OPCIÓN BÁSICA: UTILIZAR ESTADÍSTICOS SIMPLES: EJEMPLO - VALOR MEDIO

I = double(I);
T = mean(I(:));
Ib = I<T;
figure,
subplot(2,1,1),imshow(uint8(I))
subplot(2,1,2),funcion_visualiza(uint8(I),Ib,[255 0 0])


%% PEQUEÑO PARENTESIS - TERMINAMOS DE SEGMENTAR LOS CARACTERES
% ASUMIMOS QUE CONOCEMOS NUMERO DE CARACTERES, NOS QUEDAMOS CON LOS MÁS
% GRANDES

numCaracteres = 7;

[Ietiq, Nobj] = bwlabel(Ib);
stats = regionprops(Ietiq, 'Area');
areas = cat(1, stats.Area);
areas_ord = sort(areas,'descend');
numPix = areas_ord(numCaracteres);
IbFiltrada = bwareaopen(Ib, numPix);
figure,
subplot(3,1,1), imshow(uint8(I))
subplot(3,1,2), funcion_visualiza(uint8(I),Ib,[255 0 0])
subplot(3,1,3), funcion_visualiza(uint8(I),IbFiltrada,[0 255 0])

close all,
figure,
subplot(4,1,1), imshow(uint8(I))
subplot(4,1,2), funcion_visualiza(uint8(I),Ib,[255 0 0])
subplot(4,1,3), funcion_visualiza(uint8(I),IbFiltrada,[0 255 0])

Ietiq = bwlabel(IbFiltrada);
R = uint8(I); G = R; B = R;
colores = uint8((255*rand(numCaracteres)));

for i=1:numCaracteres
   IbFiltrada_i = Ietiq == i;
   R(IbFiltrada_i) = colores(i,1);
   G(IbFiltrada_i) = colores(i,2);
   B(IbFiltrada_i) = colores(i,3);
end

subplot(4,1,4), imshow(cat(3,R,G,B));


%% RETOMAMOS HISTOGRAMA BIMODAL, CON CLASES OBJETO-FONDO BIEN SEPARADOS

% UMBRALES BASADOS EN ESTADÍSTICOS SIMPLES: EJEMPLO - VALOR MEDIO
clear, clc, close all
addpath('Funciones')
addpath('Imagenes')
I = imread('Matric.tif');
I = double(I);
T = mean(I(:));
Ib = I<T;
figure,
subplot(3,1,1), imshow(uint8(I))
subplot(3,1,2), imhist(uint8(I))
subplot(3,1,3), funcion_visualiza(uint8(I), Ib, [255 0 0])
title(['Umbral definido como valor medio: ', num2str(T)])


% CLASES SEPARADAS PERO DESBALANCEADAS: EL UMBRAL ESTÁ MUY ESCORADO HACIA
% LA CLASE MÁS NUMEROSA. MEJOR: MÉTODO DE MÍNIMO ENTRE MÁXIMOS

[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMax(I)
Ib = I < g_MinEntreMax;
figure,
subplot(2,1,1), imshow(uint8(I))
subplot(2,1,2), funcion_visualiza(uint8(I), Ib, [255 0 0])
figure, imhist(uint8(I))
title(['Umbral: ' num2str(g_MinEntreMax)])

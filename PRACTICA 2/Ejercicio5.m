clc; clear all;

I = imread('ImagenBinaria.tif');

Ib = I>128;

%% COMPROBACIONES
Ietiq = Funcion_etiquetar(Ib);
areas = Calcula_Areas(Ietiq)
sort(areas)

%% RESULTADO
Imagen_filtrada = Filtra_Objetos(Ib, 4676);

imshow(Imagen_filtrada)
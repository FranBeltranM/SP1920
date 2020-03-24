clear all; clc;

I = imread('ImagenBinaria.tif');

tic
[Ietiq,s] = Funcion_etiquetar(double(I>128));
toc

imtool(Ietiq)
%% AREA
Areas = Calcula_Areas(Ietiq)

%% CENTROIDES
Centroides = Calcula_Centroides(Ietiq)

figure, imshow(Ietiq), hold on, plot(Centroides(:,1), Centroides(:,2), '*r')

%% Objetos de area mayor y area menor
[Areas_ordenadas Index] = sort(Areas, 'descend')

CentAreasMayorMenor = Centroides([Index(1) Index(end)],:);

plot(CentAreasMayorMenor(:,1), CentAreasMayorMenor(:,2), '*b')
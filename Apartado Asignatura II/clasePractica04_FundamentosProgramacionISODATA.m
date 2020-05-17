%% RIDLER AND CALVARD - ISODATA

clear, clc, close all
addpath('Funciones')
addpath('Imagenes')

I = imread('Matric.tif');
Id = double(I);

h = imhist(I);

%% Programación función de interés y comprobación
gIni = 50; gFin = 125;
gMean = calcula_valor_medio_region_histograma(h, gIni, gFin);

Ib = I>=gIni-1 & I<=gFin-1;
sum(Ib(:))
mean(I(Ib))

%% Programación isodata

umbralParada = 0;
varControl = true;

gIni = 1; gFin = 256;
T = calcula_valor_medio_region_histograma(h, gIni, gFin);

while varControl

    gIni = 1; gFin = round(T);
    gMean1 = calcula_valor_medio_region_histograma(h, gIni, gFin);
    
    gIni = round(T)+1; gFin = 256;
    gMean2 = calcula_valor_medio_region_histograma(h, gIni, gFin);
    
    newT = mean([gMean1 gMean2]); % esta forma de calcularla
    % acepta que gMean1 o gMean2 puedan ser conjuntos vacíos
    
    if abs(T-newT) <= umbralParada
        varControl = false;
    end
    
    T = newT;
end

T = T-1
funcion_isodata(h, umbralParada)
%% CLASES DESBALANCEADAS: MÉTODO MÍNIMO ENTRE MÁXIMOS

clear, clc, close all
addpath('Funciones')
addpath('Imagenes')

I = imread('Matric.tif');
Id = double(I);
[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMax(Id,[])
Ib = I<g_MinEntreMax;

close all,
subplot(2,1,1), imshow(I)
subplot(2,1,2), funcion_visualiza(I, Ib, [255 0 0])
figure, imhist(I)
title(['Umbral: ' num2str(g_MinEntreMax)])

%% POGRAMACIÓN MÍNIMO ENTRE MÁXIMOS

% IMPORTANTE: Consideramos en toda la programación niveles de gris de 1 a
% 256, después al resultado le restamos una unidad

% Objetivo: calcular los dos máximos correspondientes a las clases
% principales del histograma y después el valor mínimo entre ellos.

% 1.- Nivel de gris del máximo mayor:

[h, nivelesGris] = imhist(I); % I tipo uint8
[numPixMax, g1max] = max(h); % MUCHO CUIDADO: el nivel de gris real es g1max-1

close all, imhist(I); axis([0 255 0 max(h)+1000]), title(num2str(g1max))

% 2.- Nivel de gris del máximo correspondiente a la segunda contribución de
% píxels:

% Hay que asegurarse que la separación entre los dos máximos sea suficiente
% para evitar que ambos se encuentren en la misma clase.

% Evaluar para cada nivel de gris: [(g - g1max)^2 * h(g) ], 1 ? g ? 256
% El nivel de gris del máximo de la segunda contribución será el que tiene
% el valor máximo

valores2Max = zeros(256,1);

for g=1:256
    valores2Max(g) = ((g-g1max)^2)*h(g);
end

[~,g2max] = max(valores2Max);
close all, imhist(I); axis([0 255 0 max(h)+1000]), title(num2str(g2max))

% 3.- Calcular el mínimo entre máximos:

% Vamos a calcular el mínimo de h garantizando que ese mínimo esté entre
% los dos máximos

% En el vector h vamos a modificar todos los valores que no se encuentren
% entre los dos máximos y les vamos a asignar el número máximo de valores
% el histograma - así podemos hacer el mínimo del vector global del vector
% y acceder al índice donde se alcanza





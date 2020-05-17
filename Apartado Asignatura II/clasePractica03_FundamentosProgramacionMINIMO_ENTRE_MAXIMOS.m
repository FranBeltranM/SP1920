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
% del histograma - así podemos hacer el mínimo del vector global del vector
% y accedes al índice donde se alcanza

if gmax1<gmax2
   h(1:gmax1) = numPixMax;
   h(gmax2:256) = numPixMax;
   gmax1 = gmax1 - 1;
   gmax2 = gmax2 - 1;
else
    h(1:gmax2) = numPixMax;
    h(gmax1:256) = numPixMax;
    gmax2 = gmax1 - 1;
    gmax1 = gmax2 - 1;
end

close all, imhist(I), axis([0 255 0 max(h)+1000]), figure, stem(0:255,h,'.r')

[~, indice] = min(h);
g_MinEntreMax = indice - 1;


%% OBSERVACIÓN: método sensible a ruido en h

%% EJEMPLO SUAVIZADO DE HISTOGRAMA

horig = imhist(uint8(I));
horig_norm = (1/max(horig))*horig;

valorMaxRuido = 0.05;

h = horig_norm + valorMaxRuido*rand(size(horig)); % h: h ruidoso
close all
figure, plot(0:255, horig_norm, 'r'),
figure, plot(0:255, h, 'g')

% Ejemplo de suavizado

hs = h;
hs(1) = (h(1)+h(2))/2; hs(256) = (h(255)+h(256))/2;

for i=2:255
   hs(i) = (h(i-1)+h(i)+h(i+1))/3; 
end

figure, plot(0:255,hs,'b')

valoresAleatorios = rand(size(horig));
h = horig_norm;

for i=1:256
   if rand(1) > 0.95
       h(i) = 0.4*rand(1);
   end
end

close all
figure, plot(0:255, horig_norm, 'r'),
figure, plot(0:255, h, 'g')

hs = h;
hs(1) = (h(1)+h(2))/2; hs(256) = (h(255)+h(256))/2;

for i=2:255
   hs(i) = (h(i-1)+h(i)+h(i+1))/3; 
end

figure, plot(0:255,hs,'b')



vectorPesos = [1 2 4 8 4 2 1];
hSuav = funcion_suaviza_vector_medias_moviles(h,vectorPesos);
figure, plot(0:255, hSuav,'b')


%% FUNCIÓN MÍNIMO ENTRE MÁXIMOS CON POSIBILIDAD DE SUAVIZADO PREVIO SI EL
%% VECTOR DE PESOS NO ES CONJUNTO VACÍO

close all
vectorPesos = [1 2 4 2 1];
[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMax(I, vectorPesos)
Ib = I<g_MinEntreMax;
figure,
subplot(2,1,1), imshow(uint8(I));
subplot(2,1,2), funcion_visualiza(uint8(I), Ib, [255 0 0])

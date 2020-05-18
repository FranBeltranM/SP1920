%% Reconocimiento basado en calculo compacticidad de cada objeto

%% REGLA DE DECISIÓN POR TEORÍA

% Regla de decisión
% Si per.2 / área < 14.3 entonces objeto = circulo.
% Si 14.3 < per.2 / área < 18.4 entonces objeto = cuadrado.
% Si 18.4 < per.2 / área entonces objeto = triángulo.

%% IMPLEMENTACIÓN

addpath('Funciones');
addpath('Imagenes');

I = imread('Func.jpg');

Ib = I < 255 * graythresh(I);

[Ietiq, N] = bwlabel(Ib);

stats = regionprops(Ietiq, 'Area', 'Perimeter');
areas = cat(1, stats.Area);
perimetros = cat(1, stats.Perimeter);
c = (perimetros.^2)./areas;
close all
for i=1:N
    figure,
    funcion_visualiza(I, Ietiq==i, [255 255 0])
    
    if c(i) < 14.3
        title(['Círculo - C = ' num2str(c(i)) ])
    elseif c(i) > 18.4
        title(['Triangulo - C = ' num2str(c(i)) ])
    else
        title(['Cuadrado - C = ' num2str(c(i)) ])
    end
end


%% ESTO NO SE HACE ASÍ
%% EL CLASIFICADOR SE DISEÑA EN BASE A LOS VALORES DE LOS DESCRIPTORES
%% EN EJERCICIOS CONOCIDOS SIMILARES - NO DE CONOCIMIENTO TEÓRICO

addpath('FotosEntrenamiento')

nombres{1} = 'Circ_ent.JPG';
nombres{2} = 'Cuad_ent.JPG';
nombres{3} = 'Trian_ent.JPG';

I = imread(nombres{1});

Ib = I < 255*graythresh(I);

[Ietiq, N] = bwlabel(Ib);

stats = regionprops(Ietiq, 'Area', 'Perimeter');
areas = cat(1, stats.Area);
perimetros = cat(1, stats.Perimeter);
c = (perimetros.^2)./areas;

valorMedio = mean(c)

%% CALCULO DE COMPACTICIDAD-EXCENTRICIDAD DE TODOS LOS OBJETOS
nombres{1} = 'Circ_ent.JPG';
nombres{2} = 'Cuad_ent.JPG';
nombres{3} = 'Trian_ent.JPG';
numClases = 3; % SÓLO TENEMOS UNA IMÁGEN POR CLASE - NO VA A SER LO NORMAL

X = [];
Y = [];

for i=1:numClases
    
    I = imread(nombres{i});
   
    Ib = I < 255*graythresh(I);

    [Ietiq, N] = bwlabel(Ib);
    stats = regionprops(Ietiq, 'Area', 'Perimeter', 'Eccentricity');
    areas = cat(1, stats.Area);
    perimetros = cat(1, stats.Perimeter);
    compacticidad = (perimetros.^2)./areas;
    excentricidad = cat(1, stats.Eccentricity);
    
    datos = [compacticidad excentricidad];
    
    X = [X; datos];
    Y = [Y; i*ones(N,1)];

end

%% Representación datos en espacio de ccas: compacticidad-excentricidad

% Partimos de X-Y

% Respecto las clases:
simbolos = {'*r', '*b', '*k'};
nombreClase{1} = 'Circulos';
nombreClase{2} = 'Cuadrados';
nombreClase{3} = 'Triangulos';
codifClases = unique(Y);
numClases = length(codifClases);

% Respecto los descriptores
espacioCcas = [1 2];
nombreDescriptores{espacioCcas(1)} = 'compacticidad';
nombreDescriptores{espacioCcas(2)} = 'excentricidad';

figure, hold on
for i=1:numClases
    
   datosClase = X(Y==codifClases(i),espacioCcas);
   plot(datosClase(:,1), datosClase(:,2), simbolos{i});
    
end

legend(nombreClase)
xlabel(nombreDescriptores{espacioCcas(1)})
ylabel(nombreDescriptores{espacioCcas(2)})

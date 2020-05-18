clear
clc
close all
addpath('Imagenes')
addpath('Funciones')

% CALCULAR LOS MOMENTOS DE HU DE LA PRIMERA LETRA X

I = imread('X.jpg');
Ib = I < 255*graythresh(I);
Ietiq = bwlabel(Ib);
Ib1 = Ietiq == 1;
figure, imshow(Ib1)
hu = Funcion_Calcula_Hu(Ib1);

% CALCULAR EN X, LOS MOMENTOS DE HU DE TODAS LAS LETRAS X

I = imread('X.jpg');
Ib = I < 255*graythresh(I);
[Ietiq, N] = bwlabel(Ib);

X = [];

for i=1:N
    
    hu = Funcion_Calcula_Hu(Ietiq == i);
    
    X = [X; hu'];
    
end

% CALCULAR EN X, LOS MOMENTOS DE HU DE TODAS LAS LETRAS X Y LETRAS Y

nombreClases = [];
nombreClases{1,1} = 'X';
nombreClases{2,1} = 'Y';
extension = '.jpg';

X = [];
numClases = length(nombreClases);

for i=1:numClases
    
    nombreImagen = [nombreClases{i} extension];
    I = imread(nombreImagen);
    umbral = graythresh(I);
    Ibin = I < 255*umbral;
    
    [Ietiq, N] = bwlabel(Ibin);
    
    for j=1:N
       
        Iobjeto = Ietiq == j;
        m = Funcion_Calcula_Hu(Iobjeto);
        X = [X; m'];
        
    end
    
end

% CALCULAR EN Y, MATRIZ DE CODIFICACIÓN DE SALIDA DE LOS DATOS DE X

nombreClases = [];
nombreClases{1,1} = 'X';
nombreClases{2,1} = 'Y';
extension = '.jpg';

X = [];
Y = [];
numClases = length(nombreClases);
codifClases = 1:numClases;

for i=1:numClases
    
    nombreImagen = [nombreClases{i} extension];
    I = imread(nombreImagen);
    umbral = graythresh(I);
    Ibin = I < 255*umbral;
    
    [Ietiq, N] = bwlabel(Ibin);
    
    for j=1:N
       
        Iobjeto = Ietiq == j;
        m = Funcion_Calcula_Hu(Iobjeto);
        X = [X; m'];
        
    end
    
    Y = [Y; codifClases(i)*ones(N,1)];
    
end

% GUARDAR LA INFORMACIÓN EN DIRECTORIO DE DATOS GENERADOS

save('./DatosGenerados/conjunto_datos', 'X', 'Y')

% REPRESENTAR EN EL ESPACIO POR DOS-TRES DESCRIPTORES
% LAS MUESTRAS DE LETRAS X Y LETRAS Y
% HACER PROGRAMACIÓN GENÉRICA

funcion_representa_datos(X, Y, espacioCcas, nombresProblema)

espacioCcas = [1 3];
espacioCcas = [1 5 7];

nombreDescriptores = {'Hu1', 'Hu2', 'Hu3', 'Hu4', 'Hu5', 'Hu6', 'Hu7'};
nombreClases{1} = 'Letras X';
nombreClases{2} = 'Letras Y';
simbolosClases{1} = '*r';
simbolosClases{2} = '*b';

% funcion_representa_datos_sinEstructura(X, Y, espacioCcas, nombreDescriptores, nombreClases, simbolosClases)

nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;
save('./DatosGenerados/nombresProblema', 'nombresProblema')

funcion_representa_datos(X, Y, espacioCcas, nombresProblema)

%% Observaciones:
% La función sabe la dimensión del espacio por el vector espacioCcas: si
% tiene 3 elementos utiliza plot3 y construye zlabel

% La función calcula internamente las variables del problema:
% [numMuestras, numDescriptores] = size(X);
% codifClases = unique(Y);
% numClases = length(codifClases);

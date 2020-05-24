clear
close all
addpath('Datos')

% EJEMPLO DE DISTRIBUCIÓN DE DATOS - ESPACIO DE CARACTERÍSTICAS
% BIDIMENSIONAL
% OBJETOS DE UNA CLASE DE CARACTERIZACIÓN POR X1. X2

load DatosBasicos.mat

[numDatos, numCcas] = size(datos);
x1 = datos(:,1);
x2 = datos(:,2);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representación de datos
    DatosEjeX = x1;
    DatosEjeY = x2;
    plot(DatosEjeX, DatosEjeY, '*r')
    axis([0 6 0 10])
    legend('Datos de objetos de una Clase')
    xlabel(nombreCcas{1}), ylabel(nombreCcas{2});
    grid on

% Punto Medio
M = mean(datos);
hold on, plot(M(1), M(2), 'xb')

% Varianza Caracteristicas 1 y 2

V1 = var(datos(:,1),1) % V1 = ( (1-2)^2 + (1-2)^2 + (3-2)^2 + (3-2)^2 + (2-2)^2) / 5
V2 = var(datos(:,2),1) % V2 = ( (3-4)^2 + (5-4)^2 + (3-4)^2 + (7-4)^2 + (2-4)^2) / 5
V12 = ( (1-2)*(3-4) + (1-2)*(5-4) + (3-2)*(3-4) + (3-2)*(7-4) + (2-2)*(2-4) ) / 5

HCovarianza = cov(datos,1)

%% CALCULO DE DISTANCIA EUCLIDEA ENTRE EL PUNTO MEDIO Y UN PUNTO CUALQUIERA
% DISTANCIA EUCLIDEA AL CUADRADO

clear, close all
addpath('Datos')

load DatosBasicos.mat
[numDatos, numCcas] = size(datos);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representación de datos
    DatosEjeX = datos(:,1);
    DatosEjeY = datos(:,2);
    plot(DatosEjeX, DatosEjeY, '*r')
    axis([0 6 0 10])
    legend('Datos de objetos de una Clase')
    xlabel(nombreCcas{1}), ylabel(nombreCcas{2});
    grid on

% Punto Medio
M_vector_fila = mean(datos);
hold on, plot(M(1), M(2), 'xb')

x1 = 3; x2 = 5; X = [x1 ; x2];
M = M_vector_fila';
d_2 = ((X-M)'*(X-M))

% Planteamiento teórico Distancia del Centro a cualquier punto dado por x1
% y x2

    x1 = sym('x1', 'real');
    x2 = sym('x2', 'real');

    X = [x1; x2];
    d_2 = expand((X-M)'*(X-M));
    x1 = 3; x2 = 5; eval(d_2)

















clear; close all

%% Carga de datos
addpath('../02_ExtracionDatos/VariablesGeneradas')
addpath('./FuncionesDatos')
load('../02_ExtracionDatos/VariablesGeneradas/conjunto_de_datos');
load('../02_ExtracionDatos/VariablesGeneradas/DatosColor');
load('../02_ExtracionDatos/VariablesGeneradas/DatosColorFondo');

% Lecturas de variables interesantes
[numDatos, numAtributos] = size(X);
valoresY = unique(Y);
numClases = length(valoresY);

% Ejercicio, representar en espacio RGB,
% los valores RGB de los pixeles de color
filasColor = Y == valoresY(2);

ValoresR = X(filasColor,1);
ValoresG = X(filasColor,2);
ValoresB = X(filasColor,3);

plot3(ValoresR, ValoresG, ValoresB, '.r')

% Añadir los valores RGB de los pixeles de fondo en otro color
filasFondo = Y == valoresY(1);

ValoresR = X(filasFondo,1);
ValoresG = X(filasFondo,2);
ValoresB = X(filasFondo,3);

hold on, plot3(ValoresR, ValoresG, ValoresB, '.b')

% Estructura leyenda de la gráfica
xlabel('Componente Roja'), ylabel('Componente Azul')
valorMin = 0; valorMax = 255;
axis([valorMin valorMax valorMin valorMax valorMin valorMax])
legend('Datos Color', 'Datos Fondo')


%% Automatización de la representación gráfica
[numDatos, numAtributos] = size(X);
valoresY = unique(Y);
numClases = length(valoresY);

colores = {'.r', '.b'};
nombreClases{1} = {'Muestras de colores de fondo de la escena'};
nombreClases{2} = {'Muestras del color del seguimiento'};

figure
for i=1:numClases
    filas = Y == valoresY(i);
    
    ValoresR = X(filas,1);
    ValoresG = X(filas,2);
    ValoresB = X(filas,3);

    plot3(ValoresR, ValoresG, ValoresB, string(colores{i}))
    hold on;
end

hold off;
xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul');
valorMin = 0; valorMax = 255;
axis([valorMin valorMax valorMin valorMax valorMin valorMax])
legend(string(nombreClases))

representa_datos(X,Y)



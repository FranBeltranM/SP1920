%% CARGA DE INFORMACIÓN: Datos y variables del problema

clear, clc, close all

addpath('DatosGenerados')
addpath('Funciones')

load conjunto_datos.mat
load nombresProblema.mat

% Variables del problema
[numMuestras, numDescriptores] = size(X);
codifClases = unique(Y);
numClases = length(codifClases);

%% REPRESENTAR LOS DATOS EN ESPACIOS DE CARACTERÍSTICAS DOS A DOS

% Utilizar la funcion_representa_datos(X, Y, espacioCcas, nombresProblema)

for i=1:2:numDescriptores-1
   
    espacioCcas = [i i+1];
    funcion_representa_datos(X, Y, espacioCcas, nombresProblema)
    % la función abre una ventana tipo figure
    
end

%% REPRESENTACIÓN HISTOGRAMA Y DIAGRAMA DE CAJAS DE CADA DESCRIPTOR

% Dos ventanas tipo figure por cada descriptor, una para representar
% histogramas y otra para representar diagramas de caja

% En cada una de ellas se representan los datos del descriptor para las
% distintas clases del problema en gráficas independientes

% - Histogramas: tantas filas de gráficas como clases -
% subplot(numClases, 1, i)
% - Diagramas de caja: tantas columnas de gráficas como clases -
% subplot(1, numClases, i)

nombreDescriptores = nombresProblema.descriptores;
nombreClases = nombresProblema.clases;
close all
datosDescriptores = []; % Cada fila una clase, cada columna una medida,
% tercera dimensión para el descriptor

for j=1:numDescriptores
   
    vMin = min(X(:,j)); % Para las representaciones
    vMax = max(X(:,j));
    
    hFigure = figure; hold on
    bpFigure = figure; hold on
    
    
    for i=1:numClases
        
       Xij = X(Y==codifClases(i),j); % datos clase i del descriptor j
       numDatosClase = size(Xij, 1);
       
       % Algunos valores representativos de la muestra
       valor_medio = mean(Xij);
       desv_tipica = std(Xij);
       mediana = median(Xij);
       Xij_ord = sort(Xij);
       Q1 = Xij_ord(round(0.25*numDatosClase));
       Q3 = Xij_ord(round(0.75*numDatosClase));
       
       % rango_intercuartílico = Q3-Q1;
       
       datosDescriptores(i,:,j) = [valor_medio desv_tipica Q1 mediana Q3 min(Xij) max(Xij)];
       
       figure(hFigure)
       subplot(numClases,1,i), hist(Xij),
       xlabel(nombreDescriptores{j})
       axis([ vMin vMax 0 numMuestras/4])
       title(nombreClases{i})
       
       figure(bpFigure)
       subplot(1, numClases,i), boxplot(Xij)
       xlabel('Diagrama de Caja')
       ylabel(nombreDescriptores{j})
       axis([ 0 2 vMin vMax ])
       title(nombreClases{i})
    end
end


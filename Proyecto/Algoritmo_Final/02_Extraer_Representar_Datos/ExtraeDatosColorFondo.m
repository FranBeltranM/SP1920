clear
addpath('Funciones')
addpath('../01_GeneracionMaterial')

%% Lectura de imágenes y extracción de datos
% Leemos imágenes de calibración
load GeneracionImagenesEntrenamiento_Calibracion.mat
[N, M, NumComp, NumImag] = size(imagenes);

% Vemos las imágenes
for i=1:NumImag
    imshow(imagenes(:,:,:,i)), title(['Imagen número: ', num2str(i)])
    pause
end

%% DatosColor
DatosColor = [];
for i=5:NumImag
    I = imagenes(:,:,:,i);

    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    ROI = roipoly(I);
    
    DatosColor = [DatosColor; i*ones(length(R(ROI)),1) R(ROI) G(ROI) B(ROI)];
end

%% DatosFondo
DatosFondo = [];
NumVeces = 4; % Número de veces que llamamos a roipoly por imagen
for i=1:4
    I = imagenes(:,:,:,i);

    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    for j=1:NumVeces % Búcle con el que tomaremos además 4 muestras de cada imagen
        ROI = roipoly(I);
        DatosFondo = [DatosFondo; i*ones(length(R(ROI)),1) R(ROI) G(ROI) B(ROI)];
    end
end

save('./VariablesGeneradas/DatosColor', 'DatosColor');
save('./VariablesGeneradas/DatosFondo', 'DatosFondo');
save('./VariablesGeneradas/DatosColorFondo','DatosColor', 'DatosFondo');

%% Generar conjunto de datos final X e Y
X = [DatosColor(:,2:4) ;            DatosFondo(:,2:4)];
Y = [ones(size(DatosColor,1),1) ;  zeros(size(DatosFondo,1),1)];

% La toma de datos debería acabar guardando la información
save('./VariablesGeneradas/conjunto_de_datos_original','X','Y');

%% Representación de la información
clear
load ('./VariablesGeneradas/conjunto_de_datos_original')
close all
representa_datos_color_seguimiento_fondo(X,Y)

%% Detección y eliminación de outliers
% Generación conjunto final de datos

pos_outliers = funcion_detecta_outliers_clase_interes(X,Y);

X(pos_outliers,:) = [];
Y(pos_outliers) = [];

representa_datos_color_seguimiento_fondo(X,Y)

save('./VariablesGeneradas/conjunto_de_datos','X','Y')












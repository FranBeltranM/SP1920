load ImagenesEntrenamiento_Calibracion.mat

[N, M, NumComp, NumImag] = size(imagenes);

% Vemos las imágenes

% for i=1:NumImag
%    imshow(imagenes(:,:,:,i)), title(num2str(i))
%    pause
% end

%% Automatización del proceso para adquirir muestras de color de varias imágenes
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

save('./DatosColor', 'DatosColor');

%% DatosFondo
DatosFondo = [];

% Bucle para las 4 imagenes
for i=1:4
    I = imagenes(:,:,:,i);

    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    for j=1:4 % Búcle con el que tomaremos además 4 muestras de cada imagen
        ROI = roipoly(I);
        DatosFondo = [DatosFondo; i*ones(length(R(ROI)),1) R(ROI) G(ROI) B(ROI)];
    end
end

save('./DatosFondo', 'DatosFondo');
save('./DatosColorFondo','DatosColor', 'DatosFondo');

%% Generar conjunto de datos final X e Y

X = [DatosColor(:,2:4) ;            DatosFondo(:,2:4)];

Y = [ones(size(DatosColor,1),1) ;  zeros(size(DatosFondo,1),1)];

% La toma de datos debería acabar guardando la información
save('./VariablesGeneradas/conjunto_de_datos','X','Y');













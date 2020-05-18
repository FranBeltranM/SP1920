% REPETIR EJERCICIO ANTERIOR INCORPORANDO EL DESCRIPTOR EXTENT DE
% REGIONPROPS

% CALCULAR X-Y

addpath('Funciones')
addpath('DatosGenerados')
addpath('Imagenes')

nombreClases = [];
nombreClases{1,1} = 'X';
nombreClases{2,1} = 'Y';
extension = '.jpg';

numClases = length(nombreClases);
X = [];
Y = [];

for i=1:numClases
   
    nombreImagen = [nombreClases{i} extension];
    I = imread(nombreImagen);
    
    % Función OTSU %
    umbral = graythresh(I);
    Ibin = I < 255*umbral;
    
    IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
    
    if sum(IbinFilt(:) > 0)
        
        [Ietiq, N] = bwlabel(IbinFilt);
        XImagen = funcion_calcula_descriptores_extent_hu_imagen(Ietiq, N);
        YImagen = i*ones(N,1);
        
    else
        
        XImagen = [];
        YImagen = [];
        
    end
    
    X = [X; XImagen];
    Y = [Y; YImagen];
    
end

save('./DatosGenerados/conjunto_datos', 'X', 'Y')

nombreDescriptores = {'Extension', 'Hu1', 'Hu2', 'Hu3', 'Hu4', 'Hu5', 'Hu6', 'Hu7'}
nombreClases{1} = 'Letra X';
nombreClases{2} = 'Letra Y';
simbolosClases{1} = '*r';
simbolosClases{2} = '*b';

nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;
save('./DatosGenerados/nombresProblema', 'nombresProblema')


%% DEFINICIÓN DE EXTENT

% Bounding-box: rectángulo más pequeño que contiene la región
% Extensión: relación de píxeles del objeto en su bounding-box
% Extent = Area / boundingboxArea

IbinObjeto = Ietiq==1;
figure, imshow(IbinObjeto)

% Calculo BBox manual
% Calculo de bounding box manual
[f,c] = find(IbinObjeto);
fmin = min(f); fmax = max(f);
cmin = min(c); cmax = max(c);
BBoxObjeto = IbinObjeto(fmin:fmax, cmin:cmax);
figure, imshow(BBoxObjeto)

% Representamos con line el BBox sobre la imagen binaria original
% Primero:
% - Coordenadas X (columna) de los puntos inicial y final de la línea
% Segundo:
% - Coordenadas Y (filas) de esos puntos

figure, imshow(IbinObjeto), hold on
line([cmin, cmin], [fmin, fmax], 'Color', 'r')
line([cmax, cmax], [fmin, fmax], 'Color', 'r')
line([cmin, cmax], [fmin, fmin], 'Color', 'r')
line([cmin, cmax], [fmax, fmax], 'Color', 'r')
hold off

% Calculo con regionprops Matlab
stats = regionprops(IbinObjeto, 'BoundingBox');
bb = cat(1, stats.BoundingBox);
% columna-fila: esquina superior izquierda
% ancho alto
fminM = bb(2);
cminM = bb(1);
fmaxM = fminM + bb(4);
cmaxM = cminM + bb(3);
figure, imshow(IbinObjeto), hold on
line([cminM, cminM], [fminM, fmaxM], 'Color', 'r')
line([cmaxM, cmaxM], [fminM, fmaxM], 'Color', 'r')
line([cminM, cmaxM], [fminM, fminM], 'Color', 'r')
line([cminM, cmaxM], [fmaxM, fmaxM], 'Color', 'r')

datosBB = [fmin fmax cmin cmax; fminM fmaxM cminM cmaxM]

% Si calculamos el bounding box manualmente, hay que reajustar los valores
% de fmin, fmax, cmin, cmax para que incluya a todos los píxeles del objeto

fmin = fmin-0.5;
fmax = fmax+0.5;
cmin = cmin-0.5;
cmax = cmax+0.5;

datosBB = [fmin fmax cmin cmax; fminM fmaxM cminM cmaxM]


% Calculo manual del descriptor
numPixBB = (cmax-cmin)*(fmax-fmin);
numPixObj = sum(IbinObjeto(:));
extentObjeto = numPixObj/numPixBB


%% DEFINICIÓN DE SOLIDITY

% Convex-Hull: polígono convexo más pequeño quep uede contener el objeto
% (Apartado 4.2.2 Tema 4: Descripción de objetos - formas de obtenerlo)

% Solidez: proporción de los píxeles del objeto en su convex-hull

% solidity = Area/ConvexArea

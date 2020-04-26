clear, close all

%% Rutas a directorios con información
addpath('../02_Extraer_Representar_Datos/VariablesGeneradas')
addpath('Funciones')

%% Lectura y representación de datos
load conjunto_de_datos.mat
representa_datos(X,Y)

%% Agrupamiento de datos y representación -clase de interés
% Datos de esa clase de interés
valoresY = unique(Y);
FoI = Y == valoresY(2);
Xcolor = X(FoI,:);

numAgrupaciones = 2;
idx = funcion_kmeans(Xcolor, numAgrupaciones);

% Representa agrupaciones
close all,
representa_datos(X,Y)
representa_datos_fondo(X,Y), hold on
representa_datos_color_seguimiento_por_agrupacion(Xcolor, idx)

%% Cálculo de las esferas de cada agrupación
% Ahora:
% datosEsferasAgrupación = ...
% calcula_datos_esfera_agrupacion(Xcolor_agrupacion, X, Y);

% 1.- Calcula centroide de los puntos de seguimiento de la agrupación:
% Rc, Gc, Bc
% 2.- Calcula vector distancias entre el centroide anterior y cada uno de
% los puntos de Xcolor_agrupación
% 3.- Calcula vector distancias entre el centriode anterior y cada uno de
% los puntos de las meustras de fondo que hay en x
% 4.- Calcular r1 y r2 a partir de los vectores distancia anteriores
% 5.- Calcular el radio de compromiso r12
% 6.- Devolver datosEsferasAgrupacion = [Rc, Gc, Bc, r1, r2, r12] (vector
% fila)

datosMultiplesEsferas = zeros(numAgrupaciones,6);
% Variable que contiene los datos de todas las esferas de todas las
% agrupaciones
% Filas: tantas como agrupaciones
% Columnas: 3 valores para el centroide, 3 para radios
for i=1:numAgrupaciones
   Xcolor_i = Xcolor(idx==i,:);
   datosMultiplesEsferas(i,:) = calcula_datos_esfera_agrupacion(Xcolor_i, X, Y);
end

%% Representamos esferas en espacio de características
close all
valoresCentros = datosMultiplesEsferas(:,1:3);
valoresRadios = datosMultiplesEsferas(:,4:6);
significadoRadios{1} = 'Radio sin ruido';
significadoRadios{2} = 'Radio sin perdida';
significadoRadios{3} = 'Radio compromiso';

for i=1:size(valoresRadios,2)
   figure(i), set(i, 'Name', significadoRadios{i})
   representa_datos_fondo(X,Y), hold on
   representa_datos_color_seguimiento_por_agrupacion(Xcolor, idx)
   for j=1:numAgrupaciones
       representa_esfera(valoresCentros(j,:), valoresRadios(j,i))
   end
end

save('./VariablesGeneradas/datos_multiples_esferas', 'datosMultiplesEsferas')

%% EJERCICIO PROPUESTO

% APLICAR ESTA TÉCNICA DE CLASIFICACIÓN EN LAS IMÁGENES DE CALIBRACIÓN

% POR CADA IMAGEN DE CALIBRACIÓN SE DEBE GENERAR UNA VENTANA TIPO FIGURE
% CON CUATRO GRÁFICAS (SUBPLOT DE DOS FILAS Y DOS COLUMNAS DE GRÁFICAS):

% PRIMEAR GRÁFICA: IMAGEN DE COLOR DE CALIBRACIÓN ORIGINAL

% SEGUNDA GRÁFICA: IMAGEN ANTERIOR DONDE SE VISUALIZAN EN UN COLOR LOS
% PÍXELES QUE SE DETECTAN COMO DEL COLOR DE SEGUIMIENTO UTILIZANDO EL RADIO
% DEL PRIMER CRITERIO: r1 (SE DETECTAN TODOS LOS PÍXELES DEL COLOR). PARA
% ELLO UTILIZA LA FUNCION_VISUALIZA

% TERCERA Y CUARTA GRÁFICA: IGUAL PARA LOS RADIOS r2 (NO DETECTA RUIDO) Y
% r12 (RADIO DE COMPROMISO).

% --------------------------------------------------
% EN LA ESTRATEGIA BASADA EN UNA ESFERA PARA MODELAR TODOS LOS DATOS DE
% COLOR, SE IMPLEMENTÓ PARA RESOLVER ESTE EJERCICIO LA FUNCIÓN:
% Ib_deteccion_por_distancia = ...
% calcula_deteccion_1esfera_en_imagen(I, centroides_radios);

% AHORA, CUANDO SE CONSIDERAN MÚLTIPLES ESFERAS PARA MODELAR DATOS DE COLOR
% POR DISTINTAS AGRUPACIONES:

% Ib = calcula_deteccion_multiples_esferas_en_imagen(I, centroides_radios)

% Un pixel de I es el color del objeto de seguimiento si su punto (R,G,B)
% está dentro de cualquiera de las esferas dadas en la variable
% centroides_radios

clear, clc;

load('../01_GeneracionMaterial/GeneracionImagenesEntrenamiento_Calibracion.mat');
load('../02_Extraer_Representar_Datos/VariablesGeneradas/conjunto_de_datos.mat')
load('./VariablesGeneradas/datos_multiples_esferas.mat')
addpath('Funciones')

titulos(1) = "Imagen Original";
titulos(2) = "Imagen sin ruido r1: ";
titulos(3) = "Imagen sin perdida r2: ";
titulos(4) = "Imagen compromiso r12: ";

for i=1:size(imagenes,4)
    I = imagenes(:,:,:,i);
    subplot(2,2,1), imshow(I), title([titulos(1) num2str(i)]);
    
    for j=1:3
       Ib = calcula_deteccion_multiples_esferas_en_imagen(I, [datosMultiplesEsferas(:,1:3) datosMultiplesEsferas(:,j+3)]);
       hold on, subplot(2,2,j+1), funcion_visualiza(I, Ib, [255 255 0]), title(titulos(j+1));
    end
    
    pause
end

close all











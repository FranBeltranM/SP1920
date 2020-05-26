%% PROGRAMACIÓN GENERACIÓN CONJUTNO DE DATOS X-Y

%% LECTURA AUTOMATIZADA DE LAS IMÁGENES DE ENTRENAMIENTO DISPONIBLES

% LECTURA AUTOMATIZADA DE IMÁGENES
addpath('Imagenes/Entrenamiento/')
addpath('Funciones')

nombres{1} = 'Circulo';
nombres{2} = 'Cuadrado';
nombres{3} = 'Triangulo';

numClases = 3;
numImagenesPorClase = 2;

for i=1:numClases
   
    for j=1:numImagenesPorClase
        
        nombreImagen = [nombres{i} num2str(j, '%02d') '.jpg']
        I = imread(nombreImagen);
        
    end
    
end

%% -----------------------------------
%% 1.- GENERACIÓN CONJUNTO DE DATOS X-Y
%% -----------------------------------

X = [];
Y = [];

%% PARA CADA IMAGEN:

%% 1.1.- BINARIZAR CON METODOLOGÍA DE SELECCIÓN AUTOMÁTICA DE UMBRAL (OTSU)

% Genera: Ibin

%% 1.2.- ELIMINAR POSIBLES COMPONENTES CONECTADAS RUIDOSAS:

% COMPONENTE RUIDOSA:
% COMPONENTES DE MENOS DEL 0.1% DEL NÚMERO TOTAL DE PÍXELES DE LA IMAGEN
% O NÚMERO DE PÍXELES DE MENOR ÁREA DEL OBJETO MAYOR /5
% SE DEBE CUMPLIR CUALQUIERA DE LAS DOS CONDICIONES

% Genera IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);


%% 1.3.- ETIQUETAR.

% Genera matriz etiquetada Ietiq y número N de agrupaciones conexas

%% 1.4.- CALCULAR TODOS LOS DESCRIPTORES DE CADA AGRUPACIÓN CONEXA

% Genera XImagen - matriz de N filas y 23 columnas (los 23 descriptores
% generados en el orden indicado en la práctica)

% XImagen = funcion_calcula_descriptores_imagen(Ietiq, N);


%% 1.5.- GENERAR Yimagen

% Genera Yimagen - matriz de N filas y 1 columna con la codificación
% empleada para la clase a la que pertenecen los objetos de la imagen


%% -----------------------------------
%% 2.- GENERACIÓN VARIABLE TIPO STRUCT nombresProblema
%% -----------------------------------

% nombreDescriptores = {'XXX', 'XXX', 'XXX', 'XXX', ... HASTA LOS 23}

% nombreClases:
nombreClases{1} = 'XXX';
nombreClases{2} = 'XXX';
...
    
% simboloClases: simbolos y colores para representar las muestras de cada
% clase

% simbolosClases{1} = '*r';
% simbolosClases{2} = 'XXX';
% ...

% -----------------------------------
% nombresProblema = [];
% nombresProblema.descriptores = nombreDescriptores;
% nombresProblema.clases = nombreClases;
% nombresProblema.simbolos = simbolosClases;

%% -----------------------------------
%% 3.- GUARDAR CONJUNTO DE DATOS Y NOMBRES DEL PROBLEMA
% (EN DIRECTORIO DATOSGENERADOS)
%% -----------------------------------
























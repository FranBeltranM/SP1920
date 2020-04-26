clear, close all;

%% Rutas a directorios con información

addpath('../02_ExtracionDatos/VariablesGeneradas/')
addpath('../03_RepresentacionInformacion/FuncionesDatos')
addpath('Funciones')
addpath('Videos_ejemplo')

%% Lectura de conjunto de datos
% Visualización del video inicial
implay('01_ColorAzul.avi')

% Datos extraídos de imágenes de calibración
load conjunto_de_datos.mat

%% Representamos datos
representa_datos(X,Y)

%% Estrategia de clasificación
% Basada en establecer en una región del espacio de características
% que englobe a todas las muestras de la clase correspondiente a los
% píxeles que son del color del objeto de seguimiento

% Datos de esa clase de interés
valoresY = unique(Y);
FoI = Y == valoresY(2); % Filas de la clase de interés - color de seguimiento
Xclase = X(FoI,:);

% Valores representativos de esa clase: Valores medios, máximo y mínimos
% de cada atributo (R,G,B)
valoresMedios = mean(Xclase);
valoresMaximos = max(Xclase);
valoresMinimos = min(Xclase);

%% Primera opción
% Caracterización de la región de interés basada en establecer un prisma
% rectangular en el espacio RGB asociado al color de seguimiento

% Dimensiones del prisma basada en valores máximos y mínimos
% de esta forma engloba a todos los pixeles del color
Rmin = valoresMinimos(1); Rmax = valoresMaximos(1);
Gmin = valoresMinimos(2); Gmax = valoresMaximos(2);
Bmin = valoresMinimos(3); Bmax = valoresMaximos(3);

% Representación del prisma en el espacio de características
close all
...funcion

% Clasificador: regla de decisión sencilla
% Considerar que un píxel caracterizado por R, G y B es del color si:
% (Rmin < R < Rmax) && (Gmin < G < Gmax) && (Bmin < B < Bmax)
hold on, ...funcion

% Conclusón:
% Si se utiliza este esquema de clasificación para analizar los frames del
% vídeo:

% Por cada frame y cada pixel del mismo:
% 1.- Sacar sus valores R, G, B
% 2.- Evaluar la regla de decisión anterior y generar imagen binaria
% 3.- Etiquetar agrupaciones conexas de 1's y calcular sus centroides
% 4.- Modificar el frame original para visualizar los centroides con cajas
% de 3x3.
% 5.- Generar vídeo de salida con los frames procesados

% implay(video)

% Observación: si se pierde el objeto es porque las muestras de color
% extraídas de las imágenes de clasificación no han sido representativas,
% no hay ninguna imagen que haya caracterizado el color del objeto en esa
% posición donde se pierde el seguimiento.

%% Segunda opción
% Caracterización basada en superficie esférica centrada en color medio

% Centro de la Esfera: Color medio
valoresMedios = mean(Xclase);
Rc = valoresMedios(1); Gc = valoresMedios(2); Bc = valoresMedios(3);

% Representamos el centroide sobre la nube de puntos del color de
% seguimiento
close all, representa_datos(X,Y)
hold on, plot3(Rc,Gc,Bc, '*k')

% Para calcular radios representativos de posibles esferas:
% Depende del criterio: Ver enunciado .pdf, comienzo apartado 3.1

% 1.- No perder el objeto en ninguna posición
% El radio (r1) de la esfera debe ser igual a la distancia entre el
% centroide de la esfera y el punto de la nube de puntos del color de
% seguimiento que se encuentre más lejos de ese centroide.

% 2.- No detectar nada de ruido de fondo
% El radio (r2) debe situarse a la distancia entre el centroide de la
% esfera y el punto más cercano de la nube de puntos de fondo

% 3.- Compromiso entre detección de objeto y ruido de fondo
% Sólo tiene sentido si r2 es menor que r1
% Este criterio busca un compromiso entre detección de objeto y ruido:
% este radio de comprimos (r12) será el valor medio de los dos radios
% anteriores

% Para implementar este concepto, diseñar la siguiente función:

% Pasos de la función:
% 1.- Calcula el centroide de la nube de puntos del color de seguimiento:
% Rc, Gc, Bc
% 2.- Calcula vector distancias entre el centroide anterior y cada uno de
% los puntos de X (hay muestras del color del objeto y de fondo)
% 3.- Extrae los valores de cada clase: por una parte los valores de
% distancia entre el centroide y las muestras del color del objeto y, por
% otra, los valores de distancias entre el centroide y las muestras de
% fondo.
% 4.- Calcular r1 y r2 a partir de los vectores distancia anteriores.
% 5.- Calcular el radio de compromiso r12.
% 6.- Devolver datosEsfera = [Rc, Gc, Bc, r1, r2, r12] (vector fila)

datosEsfera = calcula_datos_esfera(X,Y);

% Extraemos en variables la información de datosEsfera
Rc = datosEsfera(1);
Gc = datosEsfera(2);
Bc = datosEsfera(3);
RadioSinPerdida = datosEsfera(4);
RadioSinRuido = datosEsfera(5);
RadioCompromiso = datosEsfera(6);

% Ayuda Matlab: Calculo de distancias de un punto a una nube de puntos

% Representamos las tres esferas en el espacio de características junto con
% las muestra de color y fondo

% Ayuda Matlab: Representación superficie esférica en enunciado PDF:
% Función: representa_esfera

close all
centroide = datosEsfera(1:3); radios = datosEsfera(4:6);
for i=1:length(radios)
    representa_datos(X,Y)
    hold on, representa_esfera(centroide, radios(i)), hold off
    title(['Esfera de radio: ' num2str(radios(i))])
end

close all

% Clasificador basado en superficie esférica: Regla de decisión sencilla
% Considerar que un píxel caracterizado por R, G y B es del color si:
% la distancia (R,G,B) del píxel y el centro de la esfera (Rc, Gc, Bc)
% es menor que el Radio que se haya elegido según el criterio

% 1.- Cargar datos de la esfera: Centroide (Rc, Gc, Bc) y Radio R
% 2.- Por cada frame y pixel del mismo:
% 2.1.- Sacar los valores R, G, B del pixel bajo consideración
% 2.2.- Evaluar la distancia d entre (R,G,B) y (Rc,Gc,Bc)
% 2.3.- Si d < Radio de la esfera R: entonces el pixel es del color
% 2.4.- La regla anterior aplicada a todos los píxeles genera una imagen
% binaria - modificar el frame original para visualizar los centroides de
% las agrupaciones con cajas 3x3
% 2.5.- Generar video de salida con los frames procesados

% Importante: Implementación matricial
% Por cada frame: Icolor
% R = double(Icolor(:,:,1)), G=double(Icolor(:,:,2)),
% B=double(Icolor(:,:,3))
% Matriz distancia MD = sqrt( (R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2 )
% Imagen binaria de puntos detectados como del color: Ib = MD < R;
%
% Analizar componentes conectadas y calcular sus centroides para modificar
% el frame del vídeo de salida
% De la imagen dados por sus valores RGB al centroide de la esfera:

load('../01_GenerarMaterial/ImagenesEntrenamiento_Calibracion')
ejercicio_final(imagenes, datosEsfera)

% Ejercicio antes de abordar la siguiente etapa del algoritmo final

% Diseñar todas las funciones a las que se hace referencia en este vídeo
% para esta opción de clasificación basada en caracterizar la nube de puntos
% del color por medio de una única esfera

% Aplicar esta técnica de clasificación en las imágenes de calibración

% Por cada imagen de calibración se debe generar una ventana tipo figure
% con cuatro gráfica (subplot de dos filas y dos columnas de gráficas):

% Primera gráfica: imagen de color de calibración original

% Segunda gráfica: imagen anterior donde se visualizan en un color los
% pixeles que se detectan como del color de seguimiento utilizando el radio
% del primer criterio: r1 (se detectan todos los píxeles del color). Para
% ello utiliza la función_visualiza

% Tercera gráfica y cuarta gráfica: igual para los radios r2 (no detecta ruido) y r12 (radio
% de compromiso)
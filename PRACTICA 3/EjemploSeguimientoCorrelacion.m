clear all; clc;
% Función que devuelve una estructura con información del hardware de adquisición de imágenes
% disponible, incluyendo los adaptadores de video instalados
datos=imaqhwinfo;

% Función que devuelve una estructura con información del dispositivo de video instalado
datos=imaqhwinfo('winvideo');

% Función para crear el objeto de video que contiene la configuración del
% dispositivo de adquisición de imágenes (WebCam, cámara...) y
% con el que Matlab se comunicará con
% el dispositivo de adquisición de imágenes (Webcam, cámara,...)
video=videoinput('winvideo',1,'RGB24_320x240'); %
video.ReturnedColorSpace='grayscale';

% CAPTURAMOS UNA IMAGEN PARA EXTRAER LA PLANTILLA
preview(video) % se abra una pantalla gráfica que muestra lo que visualiza la cámara (1fps)

I = getsnapshot(video);
% captura la imagen que se está visualizando la cámara en el momento de la llamada
% antes de capturar hay que previsualizar (si no se captura una imagen en
% negro)
% Pasamos a una imagen intensidad
I=RGB2gray(I);

% De forma manual
imtool(I) % para mostrar la imagen por imtool y sacar las coordenadas de la plantilla
imtool close all
fila1=50; fila2=75; columna1=155; columna2=180;
Plantilla=I(fila1:fila2,columna1:columna2);
imshow(Plantilla)

% De forma automatizada
% Utilizamos la instrucción roipoly para seleccionar un área de interés
% Pinchamos cuatro veces crear el polígono de interés y doble click.
sample_regions(:,:) = roipoly(I); % Matriz lógica, donde a 1 se marcan
%los píxeles de interés
[filas columnas]=find(sample_regions==1); % Coordenadas de los pixeles que integran
% la region de interés
fila1=min(filas); fila2=max(filas);
columna1=min(columnas); columna2=max(columnas);
Plantilla=I(fila1:fila2,columna1:columna2);
imshow(Plantilla)
[NT MT]=size(Plantilla);

% Para capturar una secuencia de frames:
video.TriggerRepeat=inf; % set(video,'TriggerRepeat',Inf);

% número de disparos programados para el dispositivo.
video.FrameGrabInterval=5; % de todos los frames que se capturan, sólo se van grabando de 5 en 5.

start(video) % el dispositivo de video empieza a funcionar con la configuración almacenada en el objeto.

while (video.FramesAcquired<150)
    I=getdata(video,1); % captura un frame guardado en memoria.
    %I=rgb2gray(I);
    ncc = normxcorr2(Plantilla,I);
    [Nncc Mncc]=size(ncc);
    ncc=ncc(1+floor(NT/2):Nncc-floor(NT/2),1+floor(MT/2):Mncc-floor(MT/2));
    [i j]=find(ncc==max(ncc(:)));
    imshow(I),hold on, plot(j,i,'R*'),hold off
end

stop(video)
delete(video);
clear video;
clear all; clc;
% Funci�n que devuelve una estructura con informaci�n del hardware de adquisici�n de im�genes
% disponible, incluyendo los adaptadores de video instalados
datos=imaqhwinfo;

% Funci�n que devuelve una estructura con informaci�n del dispositivo de video instalado
datos=imaqhwinfo('winvideo');

% Funci�n para crear el objeto de video que contiene la configuraci�n del
% dispositivo de adquisici�n de im�genes (WebCam, c�mara...) y
% con el que Matlab se comunicar� con
% el dispositivo de adquisici�n de im�genes (Webcam, c�mara,...)
video=videoinput('winvideo',1,'RGB24_320x240'); %
video.ReturnedColorSpace='grayscale';

% CAPTURAMOS UNA IMAGEN PARA EXTRAER LA PLANTILLA
preview(video) % se abra una pantalla gr�fica que muestra lo que visualiza la c�mara (1fps)

I = getsnapshot(video);
% captura la imagen que se est� visualizando la c�mara en el momento de la llamada
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
% Utilizamos la instrucci�n roipoly para seleccionar un �rea de inter�s
% Pinchamos cuatro veces crear el pol�gono de inter�s y doble click.
sample_regions(:,:) = roipoly(I); % Matriz l�gica, donde a 1 se marcan
%los p�xeles de inter�s
[filas columnas]=find(sample_regions==1); % Coordenadas de los pixeles que integran
% la region de inter�s
fila1=min(filas); fila2=max(filas);
columna1=min(columnas); columna2=max(columnas);
Plantilla=I(fila1:fila2,columna1:columna2);
imshow(Plantilla)
[NT MT]=size(Plantilla);

% Para capturar una secuencia de frames:
video.TriggerRepeat=inf; % set(video,'TriggerRepeat',Inf);

% n�mero de disparos programados para el dispositivo.
video.FrameGrabInterval=5; % de todos los frames que se capturan, s�lo se van grabando de 5 en 5.

start(video) % el dispositivo de video empieza a funcionar con la configuraci�n almacenada en el objeto.

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
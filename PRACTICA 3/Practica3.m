clear all;
clc;

% Funci�n que devuelve una estructura con informaci�n del hardware de
% adquisici�n de im�genes
% disponible, incluyendo los dos adaptadores de v�deo instalados

% imaqhwinfo

datos = imaqhwinfo

% Funci�n que devuelve una estructura con informaci�n del dispositivo de
% v�deo instalado

datos = imaqhwinfo('winvideo')

datos.DeviceInfo
datos.DeviceInfo.SupportedFormats

% Funci�n para crear el objeto de v�deo que contiene la configuraci�n del
% dispositivo de adquisici�n de im�genes (WebCam,...) y con el que Matlab
% se comunicar� con el dispositivo de adquisici�n de im�genes (WebCam,...)

video = videoinput('winvideo', 1, 'RGB24_320x240');

% Para acceder a la informaci�n de este objeto Matlab:
get(video)

% Para ver una peque�a descripci�n de lo que es cada par�metro:
imaqhelp videoinput

% Todos estos par�metros son modificables abriendo el objeto de v�deo.
% Doble click en el workspace.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para capturar una imagen independiente (no afecta el n�mero de disparos y
% frames por disparos):

preview(video)
% se abre una pantalla gr�fica que numera lo que visualiza la c�mara
I = getsnapshot(video);
% captura la imagen que se est� visualizando la c�mara
% en el momento de la llamada
% Antes de capturar hay que previsualizar (si no se captura una imagen en
% negro)

imtool(I)

%Imod = ycbcr2rgb(I);
%imshow(Imod);

% Por defecto mi c�mara est� en RGB
%video.ReturnedColorSpace = 'rgb';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VIDEO: Adquisici�n de im�genes, frames, continuada. Par�metros de
% inter�s.

video.TriggerRepeat = 3; % set(video, 'TriggerRepeat', 3);
% n�mero de disparos adicionales programados para el dispositivo.
% si tiene un valor 3, se ejecutan 4 disparos.

% video.TriggerRepeat = inf; % set(video, 'TriggerRepeat', inf);
% con esta configuraci�n, infinitos disparos.

video.FramesPerTrigger = 3;
% n�mero de im�genes o frames que se capturan por disparo.

video.FrameGrabInterval = 3;
% Respecto a los frames que la c�mara

% Comenzar a capturar
start(video)

% Detener grabaci�n
stop(video)

% Funci�n getdata
% permite cargar en matlab im�genes guardas en memoria


% Pruebas

video.TriggerRepeat = 1;
video.FramesPerTrigger = 25;
video.FrameGrabInterval = 2;

start(video)

N = ((video.TriggerRepeat+1)*video.FramesPerTrigger);

video.FramesAcquired
video.FramesAvailable

% Proporciona informaci�n de lo que tenemos almacenado
video

figure, hold on
for i=1:N
    I = getdata(video,1);
    imshow(I);
end

video.FramesAcquired
video.FramesAvailable

% Proporciona informaci�n de lo que tenemos almacenado
video

I = getdata(video,N);
[Filas Columnas Bandas Imagenes] = size(I);

for i=1:N
   imagen=I(:,:,1,i);
   figure,hold on,imshow(imagen)
end

close all

% SEGUNDA OPCI�N QUE ES LA QUE VAMOS A UTILIZAR
% Se programan infinitos disparos y el v�deo termina cuando se han
% adquirido de la memoria un n�mero determinado de frames

video.TriggerRepeat = 1;
% n�mero de im�genes o frames que se capturan por disparo

video.FrameGrabInterval = 2; % Hacer para un valor de 10 y 20;

start(video)
numero = 0;
contador = [];

while(video.FramesAcquired<50)
    I = getdata(video,1);
    % Captura un frame guardado en memoria.
    
    numero = numero+1;
    contador = [contador; video.FramesAcquired video.FramesAvailable numero];
    
    imshow(I)
end

% UN EJEMPLO
video = videoinput('winvideo', 1, 'RGB24_320x240');
%video.ReturnedColorSpace = 'rgb';
video.TriggerRepeat = inf;
video.FrameGrabInterval = 3;
start(video)
TIEMPO = [];

while (video.FramesAcquired < 100)
    [I,TIME,METADATA] = getdata(video,1);
    TIEMPO = [TIEMPO; TIME METADATA.AbsTime];
    imshow(I)
end

stop(video)
video


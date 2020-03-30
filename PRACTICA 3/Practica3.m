clear all;
clc;

% Función que devuelve una estructura con información del hardware de
% adquisición de imágenes
% disponible, incluyendo los dos adaptadores de vídeo instalados

% imaqhwinfo

datos = imaqhwinfo

% Función que devuelve una estructura con información del dispositivo de
% vídeo instalado

datos = imaqhwinfo('winvideo')

datos.DeviceInfo
datos.DeviceInfo.SupportedFormats

% Función para crear el objeto de vídeo que contiene la configuración del
% dispositivo de adquisición de imágenes (WebCam,...) y con el que Matlab
% se comunicará con el dispositivo de adquisición de imágenes (WebCam,...)

video = videoinput('winvideo', 1, 'RGB24_320x240');

% Para acceder a la información de este objeto Matlab:
get(video)

% Para ver una pequeña descripción de lo que es cada parámetro:
imaqhelp videoinput

% Todos estos parámetros son modificables abriendo el objeto de vídeo.
% Doble click en el workspace.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para capturar una imagen independiente (no afecta el número de disparos y
% frames por disparos):

preview(video)
% se abre una pantalla gráfica que numera lo que visualiza la cámara
I = getsnapshot(video);
% captura la imagen que se está visualizando la cámara
% en el momento de la llamada
% Antes de capturar hay que previsualizar (si no se captura una imagen en
% negro)

imtool(I)

%Imod = ycbcr2rgb(I);
%imshow(Imod);

% Por defecto mi cámara está en RGB
%video.ReturnedColorSpace = 'rgb';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VIDEO: Adquisición de imágenes, frames, continuada. Parámetros de
% interés.

video.TriggerRepeat = 3; % set(video, 'TriggerRepeat', 3);
% número de disparos adicionales programados para el dispositivo.
% si tiene un valor 3, se ejecutan 4 disparos.

% video.TriggerRepeat = inf; % set(video, 'TriggerRepeat', inf);
% con esta configuración, infinitos disparos.

video.FramesPerTrigger = 3;
% número de imágenes o frames que se capturan por disparo.

video.FrameGrabInterval = 3;
% Respecto a los frames que la cámara

% Comenzar a capturar
start(video)

% Detener grabación
stop(video)

% Función getdata
% permite cargar en matlab imágenes guardas en memoria


% Pruebas

video.TriggerRepeat = 1;
video.FramesPerTrigger = 25;
video.FrameGrabInterval = 2;

start(video)

N = ((video.TriggerRepeat+1)*video.FramesPerTrigger);

video.FramesAcquired
video.FramesAvailable

% Proporciona información de lo que tenemos almacenado
video

figure, hold on
for i=1:N
    I = getdata(video,1);
    imshow(I);
end

video.FramesAcquired
video.FramesAvailable

% Proporciona información de lo que tenemos almacenado
video

I = getdata(video,N);
[Filas Columnas Bandas Imagenes] = size(I);

for i=1:N
   imagen=I(:,:,1,i);
   figure,hold on,imshow(imagen)
end

close all

% SEGUNDA OPCIÓN QUE ES LA QUE VAMOS A UTILIZAR
% Se programan infinitos disparos y el vídeo termina cuando se han
% adquirido de la memoria un número determinado de frames

video.TriggerRepeat = 1;
% número de imágenes o frames que se capturan por disparo

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


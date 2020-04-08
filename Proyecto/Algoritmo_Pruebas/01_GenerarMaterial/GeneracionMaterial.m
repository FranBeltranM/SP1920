%% Comprobación del número de frames con los que trabaja la cámara

%salida = imaqhwinfo('macvideo')
%salida.DeviceInfo.SupportedFormats
entrada = videoinput('macvideo', 1, 'YCbCr422_1280x720');
entrada.ReturnedColorSpace = 'rgb';
entrada.TriggerRepeat = inf; % Disparos continuados
entrada.FrameGrabInterval = 1;

preview(entrada)

start(entrada)
TIEMPO = [];

while (entrada.FramesAcquired < 150)
    [I TIME] = getdata(entrada,1);
    TIEMPO = [TIEMPO; TIME];
    imshow(I)
end

stop(entrada)
entrada
entrada.flusdata(entrada)

% La cámara trabaja a 30 fps

%% Grabación del vídeo de ensayo
clear; clc;

% Configuración entrada
entrada = videoinput('macvideo', 1, 'YCbCr422_320x240');
set(entrada, 'LoggingMode', 'memory')

% Configuración grabación
entrada.ReturnedColorSpace = 'rgb'; % Espacio de color RGB
entrada.TriggerRepeat = inf; % Disparos continuados
entrada.FrameGrabInterval = 3; % 3 para grabar a 10 fps

% Configuración salida
objeto_avi = VideoWriter('./Grabaciones/salida.avi', 'Uncompressed AVI');
objeto_avi.FrameRate = 10; % Framerate de 10 FPS, para que coincida con nuestra entrada
open(objeto_avi)

start(entrada)
% Necesitamos 300 frames -> 300 frames / 10 frames/seg = 30 seg.
while(entrada.FramesAcquired < 300)
    frame = getdata(entrada,1);
    imshow(frame)
    writeVideo(objeto_avi, frame)
end

stop(entrada)
close(objeto_avi)
close all;

%% Generación imágenes Calibración
clear; clc;

% Configuración entrada vídeo
video = VideoReader('./Grabaciones/salida.avi');

% Lectura de información significativa
% get(video)
NumeroFrames = video.NumFrames; % Número de frames
NumFilasFrame = video.Height;   % Númreo de filas
NumColumnasFrame = video.Width; % Número de columnas
FPS = video.FrameRate;          % Framerate del vídeo

% for i=1:NumeroFrames
%    I = read(video, i);
%    imshow(I), title(num2str(i))
%    pause
% end

% Los 8 primeros frames
% Es donde aparece mi persona para comprobar la originalidad del vídeo
% Además elegimos también 4 frames de fondo, donde nuestra mano aparece sin nada

imagenes = [];
imagenes = cat(4,read(video,37), read(video,57), read(video, 66), read(video,80));

% A continuación, vamos a elegir frames random de 8 en 8
for i=125:8:NumeroFrames
    imagenes = cat(4, imagenes, read(video,i));
end

for i=1:size(imagenes,4)
    hold on
    imshow(imagenes(:,:,:,i));
    pause
end

save('ImagenesEntrenamientoCalibracion', 'imagenes')

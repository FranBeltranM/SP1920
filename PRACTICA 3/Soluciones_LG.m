%% Práctica 3 - Realizada con Lectura y Grabación de Archivos
%% Introducción a la adquisición de imágenes digitales en MatLab
%% Francisco Jesús Beltrán Moreno
%% Ejercicio 3
clear; clc;

% Configuración entrada
entrada = videoinput('macvideo', 1, 'YCbCr422_480X270');
set(entrada, 'LoggingMode', 'memory')

% Configuración grabación
entrada.ReturnedColorSpace = 'rgb';
entrada.TriggerRepeat = Inf;
entrada.FrameGrabInterval = 3;

% Configuración salida
objeto_avi = VideoWriter('Grabaciones/Ejercicio_3.avi', 'Uncompressed AVI'),;
objeto_avi.FrameRate = 10;
open(objeto_avi)

% Distintos valores posibles
%gamma=0:0.05:4; % Oscurece
gamma=4:-0.05:0; % Aclara

start(entrada)

for i=1:length(gamma)
    I = getdata(entrada,1);
    I = imadjust(I, [],[], gamma(i));
    imshow(I)
    writeVideo(objeto_avi, I);
end

stop(entrada)
close(objeto_avi)

%% Ejercicio 4
clear; clc;

% Configuración entrada
salida = videoinput('macvideo', 1, 'YCbCr422_480X270');
set(salida, 'LoggingMode', 'memory')

% Configuración grabación
salida.ReturnedColorSpace = 'grayscale';
salida.TriggerRepeat = Inf;
salida.FramesPerTrigger = 5; % 2 Frames por disparo
salida.FrameGrabInterval = 1; % ~30fps/6 = 5 fps

% Salida
objeto_avi = VideoWriter('Grabaciones/Ejercicio_4.avi', 'Uncompressed AVI');
objeto_avi.FrameRate = 5;
open(objeto_avi)

umbral = 0:255;

start(salida)

for i=1:length(umbral)
   I = getdata(salida,1);
   Ib = (I > umbral(i));
   
   writeVideo(objeto_avi, double(Ib));
   
   imshow(Ib)
end

stop(salida)
close all;
close(objeto_avi)

umbral = 255:-1:0;
% start(video)
% 
% for i=1:length(umbral)
%    I = getdata(video,1);
%    Ib = (I > umbral(i));
%    funcion_visualiza(I, Ib, [255 0 0])
% end
% 
% stop(video)

%% Ejercicio 5
clear; clc;

% Configuración WebCam
entrada = videoinput('macvideo', 1, 'YCbCr422_480X270');
set(entrada, 'LoggingMode', 'memory')

% Configuración grabación
entrada.ReturnedColorSpace = 'grayscale';
entrada.TriggerRepeat = Inf;
entrada.FrameGrabInterval = 3;  % 3 veces la capacidad de la cámara

% Salida
objeto_avi = VideoWriter('./Grabaciones/Ejercicio_5.avi', 'Uncompressed AVI');
objeto_avi.FrameRate = 5;
open(objeto_avi)

start(entrada)

frame_ant = getdata(entrada,1); % Cogemos el primer frame

while( entrada.FramesAcquired < 100 )
    frame = getdata(entrada,1);
    Imag_dif = imabsdiff(frame_ant, frame);
    frame_ant = frame;
    imshow(Imag_dif)
    
    writeVideo(objeto_avi, Imag_dif);
end

stop(entrada)
close all;
close(objeto_avi)

%% Ejercicio 6
clear; clc;

% Configuración de la WebCam
video = videoinput('macvideo', 1, 'YCbCr422_480X270');
video.ReturnedColorSpace = 'grayscale';

% Formato grabación
video.TriggerRepeat = Inf;
video.FrameGrabInterval = 3;

% Variables
Umbral = 100;

start(video)

% Capturamos el primer frame
frame_ant = getdata(video,1);

while( video.FramesAcquired < 150 )
    frame = getdata(video,1);
    
    Imag_dif = imabsdiff(frame_ant, frame);
    
    Mov_sig = (Imag_dif > Umbral);
    
    subplot(1,3,1), imshow(frame_ant);
    subplot(1,3,2), imshow(Imag_dif);
    subplot(1,3,3), imshow(Mov_sig);
    
    frame_ant = frame;
end

stop(video)

%% Ejercicio 7
clear; clc;

% Configuración de la WebCam
video = videoinput('macvideo', 1, 'YCbCr422_480X270');
video.ReturnedColorSpace = 'grayscale';

% Formato grabación
video.TriggerRepeat = Inf;
video.FrameGrabInterval = 2;

% Variables
Umbral = 100;
start(video)

% Capturamos el primer frame
frame_ant = getdata(video,1);

while( video.FramesAcquired < 500 )
    frame = getdata(video,1);
    Imag_dif = imabsdiff(frame_ant, frame);
    Mov_sig = (Imag_dif > Umbral);
    
    [Ietiq N] = bwlabel(Mov_sig);
    
    if N > 0
       stats = regionprops(Ietiq, 'Area', 'Centroid');
       
       areas = cat(1, stats.Area);
       centroides = cat(1, stats.Centroid);
       
       [areas_ord indices] = sort(areas, 'descend');
       
       coord_x = centroides(indices(1),1);
       coord_y = centroides(indices(1),2);
    else
        coord_x = 1;
        coord_y = 1;
    end
    
    frame_ant = frame;
    subplot(1,2,1), imshow(frame); hold on, plot(coord_x,coord_y, 'R*'), hold off;
    subplot(1,2,2), imshow(Mov_sig); hold on, plot(coord_x, coord_y, 'R*'), hold off;
end

stop(video)
%% Práctica 3
%% Introducción a la adquisición de imágenes digitales en MatLab
%% Francisco Jesús Beltrán Moreno
%% Ejercicio 1 & 2
clear; clc;

% Configuración WebCam
video = videoinput('macvideo', 1, 'YCbCr422_480X270');
video.ReturnedColorSpace = 'rgb';

% Formato de grabación
video.TriggerRepeat = Inf;
video.FramesPerTrigger = 1; % 2 Frames por disparo
video.FrameGrabInterval = 6; % ~30fps/6 = 5 fps

%preview(video)
% Tomamos una captura de la cámara
preview(video)
Ic = getsnapshot(video);

% Matriz de Intensidades calculada con las componentes RGB
I = uint8((double(Ic(:,:,1))+double(Ic(:,:,2))+double(Ic(:,:,3))/3));

umbrales = [50 130 210];

subplot(2,2,1), imshow(I), title('Imagen Original')

for i=1:length(umbrales)
   Umbral = umbrales(i);
   
   Ib = (I > Umbral);
   
   [Ietiq,N] = bwlabel(Ib);
   
   stats = regionprops(Ietiq, 'Area', 'Centroid');
   
   areas = cat(1,stats.Area);
   centroides = cat(1,stats.Centroid);
   
   [areas_ord,indices] = sort(areas, 'descend');
   
   subplot(2,2,i+1), funcion_visualiza(Ic, Ib, [255 255 0]); title(['Pixeles con I mayor que ' num2str(Umbral)]);
   hold on, plot(centroides(:,1), centroides(:,2), '*r'), plot(centroides(indices(1),1), centroides(indices(1),2),'*b');
   hold off
end
%% SEGUNDA PARTE
%% Ejercicio 3
clear all; clc;

% Configuración WebCam
datos = imaqhwinfo('macvideo')
video = videoinput('macvideo', 1, 'YCbCr422_480X270');
video.ReturnedColorSpace = 'rgb';

% Formato captura
video.TriggerRepeat = Inf;
video.FrameGrabInterval = 2;

% Distintos valores posibles
%gamma=0:0.05:4; % Oscurece
gamma=4:-0.05:0; % Aclara

preview(video)
start(video)

for i=1:length(gamma)
    I = getdata(video,1);
    I = imadjust(I, [],[], gamma(i));
    imshow(I)
end

stop(video)

%% Ejercicio 4
clear all; clc;

% Configuración WebCam
datos = imaqhwinfo('macvideo')
video = videoinput('macvideo', 1, 'YCbCr422_480X270');
video.ReturnedColorSpace = 'grayscale';

% Formato grabación
video.TriggerRepeat = Inf;
video.FramesPerTrigger = 5; % 2 Frames por disparo
video.FrameGrabInterval = 1; % ~30fps/6 = 5 fps

umbral = 0:255;

start(video)

for i=1:length(umbral)
   I = getdata(video,1);
   Ib = (I > umbral(i));
   imshow(Ib)
end

stop(video)

umbral = 255:-1:0;
start(video)

for i=1:length(umbral)
   I = getdata(video,1);
   Ib = (I > umbral(i));
   funcion_visualiza(I, Ib, [255 0 0])
end

stop(video)

%% Ejercicio 5
clear all; clc;

% Configuración WebCam
datos = imaqhwinfo('macvideo')
video = videoinput('macvideo', 1, 'YCbCr422_480X270');
video.ReturnedColorSpace = 'grayscale';

% Formato grabación
video.FrameGrabInterval = 3;

preview(video)
start(video)

frame_ant = getdata(video,1); % Cogemos el primer frame

while( video.FramesAcquired < 100 )
    frame = getdata(video,1);
    Imag_dif = imabsdiff(frame_ant, frame);
    frame_ant = frame;
    imshow(Imag_dif)
end

stop(video)

%% Ejercicio 6
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
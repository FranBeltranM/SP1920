%% Ejercicio Propuesto
% Grabar un vídeo a 10fps de 15 segundos que muestre sobre las imágenes a
% color capturadas por una webcam un cuadrado de 3x3 rojo que se mueva de
% forma aleatoria (en cada imagen, se establecerá de forma aleatoria la
% posición central del cuadrado utilizando la función de Matlab rand).

clear;

% Configuración entrada
entrada = videoinput('macvideo', 1, 'YCbCr422_480X270');
set(entrada, 'LoggingMode', 'memory')

% Configuración grabación
entrada.ReturnedColorSpace = 'rgb';
entrada.TriggerRepeat = Inf;
entrada.FrameGrabInterval = 3;  % 3 veces la capacidad de la cámara

% Configuración salida
Resolucion = entrada.VideoResolution;
NumFilas = Resolucion(2);
NumColumnas = Resolucion(1);
NumFrames = 150;

% Salida
objeto_avi = VideoWriter('Ejercicio_propuesto.avi', 'Uncompressed AVI');
objeto_avi.FrameRate = 10;
open(objeto_avi)

% Valores random donde representar la caja roja
ValoresX = round( (NumColumnas-1) * rand(150,1) + 1);
ValoresY = round( (NumFilas-1) * rand(150,1) + 1 );

start(entrada)

while(entrada.FramesAcquired < 150)
   I = getdata(entrada,1);
      
   x = ValoresX(entrada.FramesAcquired,1);  % Columna
   y = ValoresY(entrada.FramesAcquired,1);  % Fila
   
   % Comprobamos que no lleguemos a las esquinas necesitamos vecindad 3
   if(y>1 && y<NumFilas) && (x>1 && x<NumColumnas)
       I(y-1:y+1, x-1:x+1, 1) = 255;
       I(y-1:y+1, x-1:x+1, 2:3) = 0;
   end
   
   imshow(I)
   
   writeVideo(objeto_avi, I);
end

stop(entrada)
close(objeto_avi)
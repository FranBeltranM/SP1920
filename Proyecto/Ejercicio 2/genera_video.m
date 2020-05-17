%% DIFERENCIA DE IMÁGENES
clear, clc;
addpath('VariablesRequeridas')
addpath('Funciones')
%% LECTURA VIDEO DE ENTRADA
nombre_archivo_video_entrada='01_ColorAzul.avi';
videoInput = VideoReader(nombre_archivo_video_entrada);
[numFrames, numFilasFrame, numColumnasFrame, FPS] = carga_video_entrada(videoInput);

%% GENERACIÓN VÍDEO DE SALIDA
nombre_archivo_video_salida = 'video_salida_01_ColorAzul_v2';
videoOutput = VideoWriter(nombre_archivo_video_salida);
videoOutput.FrameRate = FPS;
open(videoOutput)

color = [0 255 0];

umbral = 50;
I_ant = read(videoInput,1);
for i=2:numFrames
    I = read(videoInput,i);
    Ib_f = imabsdiff(I_ant, I);
    Ib = (Ib_f > umbral);
    
    I_f = funcion_visualiza(I, Ib, color);
    
    writeVideo(videoOutput, I_f);
    I_ant = I;
end

close(videoOutput);
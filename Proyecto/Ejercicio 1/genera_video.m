%% RUTAS A DIRECTORIOS Y CARGA DE INFORMACIÓN
clear, clc;
addpath('VariablesRequeridas')
addpath('Funciones')

%% DATOS CLASIFICADOR
load parametros_clasificador.mat

%% LECTURA VIDEO DE ENTRADA
nombre_archivo_video_entrada='01_ColorAzul.avi';
videoInput = VideoReader(nombre_archivo_video_entrada);
[numFrames, numFilasFrame, numColumnasFrame, FPS] = carga_video_entrada(videoInput);

%% GENERACIÓN VÍDEO DE SALIDA
nombre_archivo_video_salida = 'video_salida_01_ColorAzul';
videoOutput = VideoWriter(nombre_archivo_video_salida);
videoOutput.FrameRate = FPS;
open(videoOutput)

color = [255 255 0];

for i=1:numFrames
    I = read(videoInput,i);
    numEsferas = size(datosMultiplesEsferas_clasificador,1);
    
    R = double(I(:,:,1));
    G = double(I(:,:,2));
    B = double(I(:,:,3));
    
    Ib = zeros(size(I,1),size(I,2));
    
    for j=1:numEsferas
        Rc = datosMultiplesEsferas_clasificador(j,1);
        Gc = datosMultiplesEsferas_clasificador(j,2);
        Bc = datosMultiplesEsferas_clasificador(j,3);
        
        radio = datosMultiplesEsferas_clasificador(j,4);

        MD = sqrt( (R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2 );

        % Matriz lógica
        Ib = or(Ib, MD < radio);
    end
    
    Ib_clear = Filtra_Objetos(Ib, numPix);
    
    if ( sum(Ib_clear(:)) == 0 )
        writeVideo(videoOutput, I);
    else
        [Ietiq, numAgrupaciones] = Funcion_etiquetar(Ib_clear);
        
        areas = Calcula_Areas(Ietiq);

        if( length(areas) == 1)
            pos_obj_mayor_area = 1;
        else
            pos_obj_mayor_area = find(areas==(max(areas)));
        end
        
        centroides = Calcula_Centroides(Ietiq);
        
        fila = int64(centroides(pos_obj_mayor_area,2));
        columna = int64(centroides(pos_obj_mayor_area,1));
        
        if ( (columna-1 > 0 || columna+1 < numColumnasFrame) && (fila-1 > 0 || fila+1 < numFilasFrame) )
            I(fila, columna,:) = color;
            I(fila+1, columna,:) = color;
            I(fila-1, columna,:) = color;
            I(fila, columna+1,:) = color;
            I(fila, columna-1,:) = color;
            I(fila+1, columna+1,:) = color;
            I(fila+1, columna-1,:) = color;
            I(fila-1, columna+1,:) = color;
            I(fila-1, columna+1,:) = color;
            I(fila-1, columna-1,:) = color;
        else
            I(fila,columna,:) = color;
        end
        
        writeVideo(videoOutput, I);
    end
end

close(videoOutput);
function funcion_reconocedor_X_Y_porHu1(nombreImagen)

    addpath('Funciones')
    addpath('Imagenes')
    addpath('DatosGenerados')

    umbralHu1 = 1.1;
    load nombresProblema.mat;
    nombreClases = nombresProblema.clases;
    
    I = imread(nombreImagen);
    
    % Función OTSU
    umbral = graythresh(I);
    Ibin = I < 255*umbral;
    
    if sum(Ibin(:)) > 0
       
        % Filtramos %
        IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
        
        % Etiquetamos %
        [Ietiq, N] = bwlabel(IbinFilt);
        
        % Sacamos nuestra X %
        XTest = funcion_calcula_Hu_objetos_imagen(Ietiq, N);
        
        % Representamos %
        for i=1:N
           
            Iobjeto = Ietiq == i;
            figure, funcion_visualiza(I, Iobjeto, [255 255 0])
            
            if XTest(i,1) > umbralHu1
                title(nombreClases{1})
            else
                title(nombreClases{2})
            end
        end
    end
end
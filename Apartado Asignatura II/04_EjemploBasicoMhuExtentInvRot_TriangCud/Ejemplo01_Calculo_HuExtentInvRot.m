addpath('Funciones')
addpath('DatosGenerados')
addpath('Imagenes')

nombreClases = [];
nombreClases{1,1} = 'Cuadrados';
nombreClases{2,1} = 'Triangulos';
extension = '.jpg';

numClases = length(nombreClases);
X = [];
Y = [];


for i=1:numClases
   
    nombreImagen = [nombreClases{i} extension];
    I = imread(nombreImagen);
    
    % Función OTSU %
    umbral = graythresh(I);
    Ibin = I < 255*umbral;
    
    IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
    
    if sum(IbinFilt(:) > 0)
        
        [Ietiq, N] = bwlabel(IbinFilt);
        XImagen = funcion_calcula_descriptores_extentInvRot_hu_imagen(Ietiq, N);
        YImagen = i*ones(N,1);
        
    else
        
        XImagen = [];
        YImagen = [];
        
    end
    
    X = [X; XImagen];
    Y = [Y; YImagen];
    
end

save('./DatosGenerados/conjunto_datos', 'X', 'Y')

nombreDescriptores = {'Extension', 'ExtensionInvRot', 'Hu1', 'Hu2', 'Hu3', 'Hu4', 'Hu5', 'Hu6', 'Hu7'};
nombreClases{1} = 'Cuadrados';
nombreClases{2} = 'Triangulos';
simbolosClases{1} = '*r';
simbolosClases{2} = '*b';

nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;

save('./DatosGenerados/nombresProblema', 'nombresProblema')

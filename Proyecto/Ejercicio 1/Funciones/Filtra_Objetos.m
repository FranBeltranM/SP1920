function mfiltrada = Filtra_Objetos(matriz_binaria, numPix)

    [matriz_etiquetada,num_objetos] = Funcion_etiquetar(matriz_binaria);
    
    areas = Calcula_Areas(matriz_etiquetada);
    
    obj_mayores = find(areas>numPix);
    
    mfiltrada = zeros(size(matriz_etiquetada));
    
    for obj=1:length(obj_mayores)
       for x=1:size(matriz_etiquetada,1)
          for y=1:size(matriz_etiquetada,2)
             if matriz_etiquetada(x,y) == obj_mayores(obj)
                mfiltrada(x,y)=1; 
             end
          end
       end
    end
    
end
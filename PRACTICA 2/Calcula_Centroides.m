function centroides = Calcula_Centroides(matriz_etiquetada)

    num_obj = length(unique(matriz_etiquetada))-1;
    
    centroides = [];
    
    areas = Calcula_Areas(matriz_etiquetada);
    
    for obj=1:num_obj
       media_x=0;
       media_y=0;
        for x=1:size(matriz_etiquetada,1)
            for y=1:size(matriz_etiquetada,2)
                if(matriz_etiquetada(x,y)==obj)
                    media_x = media_x + x;
                    media_y = media_y + y;
                end
            end
        end
        
        media_x = media_x / areas(obj);
        media_y = media_y / areas(obj);
        
        centroides(obj,1) = media_y;
        centroides(obj,2) = media_x;
    end

end
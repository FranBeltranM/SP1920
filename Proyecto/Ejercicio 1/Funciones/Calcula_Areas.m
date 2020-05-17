function areas = Calcula_Areas(matriz_etiquetada)
    
    areas = [];
    
    % Número de objetos, -1 para eliminar el fondo %
    num_obj = length(unique(matriz_etiquetada))-1;
    
    for i=1:num_obj
        suma = sum(sum(matriz_etiquetada==i));
        areas = [areas; suma];
    end
end
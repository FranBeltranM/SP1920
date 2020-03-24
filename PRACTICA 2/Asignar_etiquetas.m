function [etiq, num_etiquetas] = Asignar_etiquetas(etiq, tipo_exploracion)
    % Numero de etiquetas distintas %
    etiquetas = unique(etiq);
    % Eliminamos la etiqueta número 0 %
    etiquetas = etiquetas(2:end);

    if (tipo_exploracion == "filas")
        for fila=1:size(etiq,1)
            for col=1:size(etiq,2)
                if ( etiq(fila,col) ~= 0 )
                    etiq(fila,col) = find(etiquetas==etiq(fila,col));
                end
            end
        end
    elseif (tipo_exploracion == "columnas")
        for col=1:size(etiq,2)
            for fila=1:size(etiq,1)
                if ( etiq(fila,col) ~= 0 )
                    etiq(fila,col) = find(etiquetas==etiq(fila,col));
                end
            end
        end
    end
    
    % Devolvemos el número de etiquetas %
    num_etiquetas = length(etiquetas);
end
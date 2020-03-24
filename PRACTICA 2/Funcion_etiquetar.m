% Función_etiquetar(Imagen_binaria, Ietiq)
function [etiq, num_etiquetas] = Funcion_etiquetar(Image_Binario) % Devolvemos elementos de la imagen + 1
    % DECLARACIÓN VARIABLES %
    Image_Binario = padarray(Image_Binario, [1 1]); % MATRIZ AMPLIADA CON BORDES A 0
    etiq = zeros(size(Image_Binario)); % SOLUCIÓN
    [nF nC] = size(Image_Binario);
    contador = 1; % PRIMERA ETIQUETA
    
    % CREACIÓN DE ETIQUETA ÚNICA %
    for L=1:nF
        for P=1:nC
            if(Image_Binario(L,P) == 1)
                etiq(L,P) = contador;
                contador = contador + 1;
            end
        end
    end
    
    % Paso de arriba-abajo
    cambio = true; % SUPONEMOS QUE TENEMOS QUE HACER CAMBIO DE ETIQUETA
    while(cambio==true)
        cambio = false;
        for L=1:nF
           for P=1:nC
                if ( etiq(L,P)~=0 )
                    % MINIMO DE ESA ETIQUETA Y SUS VECINOS %
                    M = min( [etiq(L,P) vecinos(etiq, L, P)] );
                    if ( M ~= etiq(L,P) )
                        cambio = true;
                        etiq(L,P) = M;
                    end
                end
            end
        end

    % Paso de abajo-arriba
        for L=nF:1
            for P=nC:1
                if ( etiq(L,P)~=0 )
                    % MINIMO DE ESA ETIQUETA Y SUS VECINOS %
                    M = min( [Ietiq(L,P) vecinos(etiq, L,P)] );
                    if ( M ~= etiq(L,P) )
                        cambio = true;
                        etiq(L,P) = M;
                    end
                end
            end
        end
    end
    
    % ASIGINACIÓN DE ETIQUETAS FINALES %
    etiquetas = unique(etiq);
    etiquetas = etiquetas(2:end);

    for fila=1:size(etiq,1)
        for col=1:size(etiq,2)
            if ( etiq(fila,col) ~= 0 )
                etiq(fila,col) = find(etiquetas==etiq(fila,col));
            end
        end
    end
    
    num_etiquetas = length(etiquetas);
    
end
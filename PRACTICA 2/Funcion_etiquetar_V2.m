function [etiq, num_etiquetas] = Funcion_etiquetar_V2(Image_Binario, vecindad, tipo_exploracion) % Devolvemos elementos de la imagen + 1
    % DECLARACIÓN VARIABLES %
    % Matriz ampliada con bordes a 0
    Image_Binario = padarray(Image_Binario, [1 1]);
    % Matriz solución %
    etiq = zeros(size(Image_Binario));
    [nF,nC] = size(Image_Binario);
    
     % Primera etiqueta %
    contador = 1;
    
    if (tipo_exploracion == "filas")
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
        cambio = true;
        % SUPONEMOS QUE TENEMOS QUE HACER CAMBIO DE ETIQUETA
        while(cambio==true)
            cambio = false;
            for L=1:nF
                for P=1:nC
                    if ( etiq(L,P)~=0 )
                        % MINIMO DE ESA ETIQUETA Y SUS VECINOS %
                        M = min( [etiq(L,P) vecinos_v2(etiq, L, P, vecindad)] );
                        if ( M ~= etiq(L,P) )
                            cambio = true;
                            etiq(L,P) = M;
                        end
                    end
                end
            end

        % Paso de abajo-arriba
            for L=1:nF
                for P=1:nC
                    if ( etiq(L,P)~=0 )
                        % MINIMO DE ESA ETIQUETA Y SUS VECINOS %
                        M = min( [etiq(L,P) vecinos_v2(etiq, L, P, vecindad)] );
                        if ( M ~= etiq(L,P) )
                            cambio = true;
                            etiq(L,P) = M;
                        end
                    end
                end
            end
        end
    
    elseif ( tipo_exploracion == "columnas" )
        % CREACIÓN DE ETIQUETA ÚNICA %
        for P=1:nC
            for L=1:nF
                if(Image_Binario(L,P) == 1)
                    etiq(L,P) = contador;
                    contador = contador + 1;
                end
            end
        end
        
        % Paso de arriba-abajo
        cambio = true;
        % SUPONEMOS QUE TENEMOS QUE HACER CAMBIO DE ETIQUETA
        while(cambio==true)
            cambio = false;
            for P=1:nC
                for L=1:nF
                    if ( etiq(L,P)~=0 )
                        % MINIMO DE ESA ETIQUETA Y SUS VECINOS %
                        M = min( [etiq(L,P) vecinos_v2(etiq, L, P, vecindad)] );
                        if ( M ~= etiq(L,P) )
                            cambio = true;
                            etiq(L,P) = M;
                        end
                    end
                end
            end

        % Paso de abajo-arriba
            for P=1:nC
                for L=1:nF
                    if ( etiq(L,P)~=0 )
                        % MINIMO DE ESA ETIQUETA Y SUS VECINOS %
                        M = min( [etiq(L,P) vecinos_v2(etiq, L, P, vecindad)] );
                        if ( M ~= etiq(L,P) )
                            cambio = true;
                            etiq(L,P) = M;
                        end
                    end
                end
            end
        end
    end    
    
    % ASIGINACIÓN DE ETIQUETAS FINALES %
    [etiq,num_etiquetas] = Asignar_etiquetas(etiq, tipo_exploracion);
end
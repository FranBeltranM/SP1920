function sol = vecinos_v2(I, fila, columna, tipo)

    sol = [];

% Nos pasan fila y columna de un elemento del que tenemos que devolver sus vecinos con vecindad 4
    if ( tipo == 4)
        if( I(fila+1,columna) ~= 0 )
            sol = [sol I(fila+1,columna)];
        end

        if( I(fila-1,columna) ~= 0 )
            sol = [sol I(fila-1,columna)];
        end

        if( I(fila,columna+1) ~= 0 )
            sol = [sol I(fila,columna+1)];
        end

        if( I(fila,columna-1) ~= 0 )
            sol = [sol I(fila,columna-1)];
        end
    elseif ( tipo == 8 )
        for i=fila-1:fila+1
            for j=columna-1:columna+1
                if( (I(i,j) ~= 0) && (i ~= fila) && (j~= columna) )
                    % Excluimos el elemento central %
                    sol = [sol I(i,j)];
                end
            end
        end
    end
end
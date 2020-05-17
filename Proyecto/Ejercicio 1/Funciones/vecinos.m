function sol = vecinos(I, fila, columna)

    sol = [];

% Nos pasan fila y columna de un elemento del que tenemos que devolver sus vecinos con vecindad 4    
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
end
function representa_datos_color_seguimiento_por_agrupacion(X,idx)
    valoresY = unique(idx);
    numClases = length(valoresY);

    colores = {'.k', '.m', '.c', '.g', '.b', '.k','.y', '.m', '.c', '.g', '.b', '.y'};

    for i=1:numClases
        filas = idx == valoresY(i);

        ValoresR = X(filas,1);
        ValoresG = X(filas,2);
        ValoresB = X(filas,3);

        plot3(ValoresR, ValoresG, ValoresB, string(colores{i}))
%         pause
    end
    
end
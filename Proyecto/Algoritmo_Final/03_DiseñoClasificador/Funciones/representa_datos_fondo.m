function representa_datos_fondo(X,Y)
    % Valores únicos de Y {0,1}
    valoresY = unique(Y);
    
    % Vector de colores
    colores = {'.r', '.y', '.m', '.c', '.g', '.w'};
    
    % Valores referentes al fondo
    filas = Y == valoresY(1);

    ValoresR = X(filas,1);
    ValoresG = X(filas,2);
    ValoresB = X(filas,3);

    plot3(ValoresR, ValoresG, ValoresB, string(colores{1}))

    xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul');
    valorMin = 0; valorMax = 255;
    axis([valorMin valorMax valorMin valorMax valorMin valorMax])
end
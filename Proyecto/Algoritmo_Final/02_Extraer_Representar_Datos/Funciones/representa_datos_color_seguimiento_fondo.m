function representa_datos_color_seguimiento_fondo(X,Y)
    valoresY = unique(Y);
    numClases = length(valoresY);

    colores = {'.r', '.b'};
    nombreClases{1} = {'Muestras de colores de fondo de la escena'};
    nombreClases{2} = {'Muestras del color del seguimiento'};

    figure
    for i=1:numClases
        filas = Y == valoresY(i);

        ValoresR = X(filas,1);
        ValoresG = X(filas,2);
        ValoresB = X(filas,3);

        plot3(ValoresR, ValoresG, ValoresB, string(colores{i}))
        hold on;
    end

    hold off;
    xlabel('Componente Roja'), ylabel('Componente Verde'), zlabel('Componente Azul');
    valorMin = 0; valorMax = 255;
    axis([valorMin valorMax valorMin valorMax valorMin valorMax])
    legend(string(nombreClases))
end
function T_otsu = funcion_otsu(I)

    h = imhist(uint8(I));
    
    % Consideramos en toda la programación niveles de gris de 1 a 256,
    % después al resultado le restamos una undiad
    
    gIni = 1; gFin = 256;
    [gmedio, numPix] = calcula_valor_medio_region_histograma(h, gIni, gFin);

    var = zeros(256,1); % Para almacenar la varianza enre clases
    
    for g=2:255 % los extremos de g=0 y g=255, no son posibles umbrales
       T = g;
       var(g) = calcula_varianza_entre_clases(T, h, numPix, gmedio);
    end
    
    [~, indice] = max(var);
    
    T_otsu = indice-1;
end

function var = calcula_varianza_entre_clases(T, h, numPix, gmedio)
    gIni = 1; gFin = 256;
    
    T = round(T);
    
    N1 = sum(h(gIni:T));
    N2 = sum(h(T+1:gFin));
    
    w1 = N1 / numPix;
    w2 = N2 / numPix;
    
    u1 = calcula_valor_medio_region_histograma(h, gIni, T);
    
    if isempty(u1)
       u1 = 0;
    end
    
    u2 = calcula_valor_medio_region_histograma(h, T+1, gFin);
    
    if isempty(u2)
       u2 = 0;
    end

    var = w1 * ((u1-gmedio)^2) + w2 *((u2-gmedio)^2);
end
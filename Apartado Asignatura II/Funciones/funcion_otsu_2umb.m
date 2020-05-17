function [T1, T2] = funcion_otsu_2umb(I)

    h = imhist(uint8(I));
    
    % Consideramos en toda la programación niveles de gris de 1 a 256,
    % después al resultado le restamos una undiad
    
    gIni = 1; gFin = 256;
    [gmedio, numPix] = calcula_valor_medio_region_histograma(h, gIni, gFin);

    var = zeros(256,1); % Para almacenar la varianza enre clases
    umbrales = [];
    ind = 0;
    
    for g1=2:254 % los extremos de g=0 y g=255, no son posibles umbrales
        for g2=g1+1:255
            ind = ind+1;
            T1 = g1;
            T2 = g2;
            umbrales = [umbrales; [T1-1 T2-1]];
            var(ind) = calcula_varianza_entre_3clases(T1, T2, h, numPix, gmedio);
        end
    end
    
    [~, indice] = max(var);
    
    T1 = umbrales(indice,1);
    T2 = umbrales(indice,2);
end

function var = calcula_varianza_entre_3clases(T1, T2, h, numPix, gmedio)
    gIni = 1; gFin = 256;
    
    T1 = round(T1);
    T2 = round(T2);
    
    N1 = sum(h(gIni:T1));
    N2 = sum(h(T1+1:T2));
    N3 = sum(h(T2+1:gFin));
    
    w1 = N1 / numPix;
    w2 = N2 / numPix;
    w3 = N3 / numPix;
    
    u1 = calcula_valor_medio_region_histograma(h, gIni, T1);
    
    if isempty(u1)
       u1 = 0;
    end
    
    u2 = calcula_valor_medio_region_histograma(h, T1+1, T2);
    
    if isempty(u2)
       u2 = 0;
    end

    u3 = calcula_valor_medio_region_histograma(h, T2+1, gFin);
    
    if isempty(u3)
       u3 = 0;
    end

    var = w1 * ((u1-gmedio)^2) + w2 *((u2-gmedio)^2) + w3 *((u3-gmedio)^2);
end
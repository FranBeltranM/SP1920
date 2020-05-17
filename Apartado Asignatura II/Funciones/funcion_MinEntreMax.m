function [g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMax(I, vectorPesos)
    h = imhist(uint8(I));
    
    if not(isempty(vectorPesos))
        
        h = funcion_suaviza_vector_medias_moviles(h, vectorPesos);
        
    end
    
    % Calcular máximo global
    [numPixMax, gmax1] = max(h);
    
    % Calcular otro máximo, función ponderación
    valores2Max = zeros(256,1);

    for g=1:256
        valores2Max(g) = ((g-gmax1)^2)*h(g);
    end
    
    [~, gmax2] = max(valores2Max);
    
    % Descartar valores que no se encuentren entre los máximos
    if gmax1 < gmax2 % esto es, gmax1 está a la izquierda de gmax2
        h(1:gmax1) = numPixMax;
        h(gmax2:256) = numPixMax;
        
        % Devolver número de grises reales
        gmax1 = gmax1 - 1;
        gmax2 = gmax2 - 1;
    else
        h(1:gmax2) = numPixMax;
        h(gmax1:256) = numPixMax;
        
        % Devolver numero de grises reales EN ORDEN
        temp = gmax1;
        gmax1 = gmax2-1;
        gmax2 = temp-1;
    end
    
    g_MinEntreMax = find(h==min(h),1)-1;
end

function hs = funcion_suaviza_vector_medias_moviles(h, pesos)

    amp = floor(length(pesos)/2);
    
    pesos = (1/sum(pesos))*pesos; % para que se haga un promedio
    
    pesos = pesos(:)'; % vector fila siempre
    hc = h(:); % vector columnas siempre
    hamp = [hc(amp+1:-1:2) ; hc ; hc(end-1:-1:end-amp)];
    
    hs = zeros(size(h));
    
    for i=1:length(h)
        ind_hamp = i + amp;
        hs(i) = pesos*hamp(ind_hamp-amp:ind_hamp+amp);  
    end
    
end
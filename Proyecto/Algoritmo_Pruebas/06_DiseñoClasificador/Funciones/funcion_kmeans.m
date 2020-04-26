function idx = funcion_kmeans(X, k)
    idx = agrupa_por_desviacion(X,k);
    
    MatricesIguales = false;
    
    while not(MatricesIguales)
       centroides = calcula_centroides(X, idx);
       
       idx_new = calcula_agrupacion(X, centroides);
       
       MatricesIguales = compara_matrices(idx, idx_new);
       
       idx = idx_new;
    end
end

function idx = agrupa_por_desviacion(X, k)
    idx = zeros(size(X,1),1);

    % 1.1. Identificar atributo de máxima dispersion
    desviacion_atributos = std(double(X));
    maxima_desv = max(desviacion_atributos);
    CoI = find(maxima_desv==desviacion_atributos);
    
    % 1.3. Calcular valores representativos
    vMin = min(X(:, CoI));
    vMax = max(X(:, CoI))+0.1;
    
    % Cálculo amplitud intervalo
    longitudIntervalo = (vMax - vMin) / k;
    
    valorInicial = vMin;
    valorFinal = vMin + longitudIntervalo;
    
    for i=1:k
        % Si el valor está en el intervalo
        idx(X(:,CoI) >= valorInicial & X(:,CoI) < valorFinal) = i;
        
        valorInicial = valorFinal;
        valorFinal = valorFinal + longitudIntervalo;
    end
    
    %% Comprobación intervalos correctos
%     unique(idx)
%     for i=1:k
%         [i size(find(idx==i),1)]
%     end
end

function centroides = calcula_centroides(X, idx)
    numAgrupaciones = length(unique(idx));
    centroides = zeros(numAgrupaciones,3);
    
    for i=1:numAgrupaciones
       centroides(i,:) = mean(X(idx==i,:));
    end
end

function idx = calcula_agrupacion(X, centroides)
    numCentroides = size(centroides,1);
    datosT = double(X');
    idx = zeros(size(X,1),1);
    
    % En cada fila, la distancia de ese dato (columna) al centroide de la
    % agrupación
    distancias = zeros(size(centroides,1), size(X,1));
    
    for i=1:numCentroides
       % Matriz ampliada repitiendo el valor del centroide i en columnas
       centroideAmp = repmat(centroides(i,:)', 1, size(datosT,2));
       
       % Cálculo de la distancia de cada dato a ese centroide
       distancias(i,:) = sqrt(sum((datosT - centroideAmp).^2));
    end
    
    % Asignación de cada dato al centroide de menor distancia
    for j=1:length(idx)
       idx(j) = find(distancias(:,j) == min(distancias(:,j)));
    end
end

function var = compara_matrices(matriz1, matriz2)
    var = (matriz1 == matriz2);
end
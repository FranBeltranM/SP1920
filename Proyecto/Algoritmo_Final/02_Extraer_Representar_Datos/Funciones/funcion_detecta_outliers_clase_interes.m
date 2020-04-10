function pos_outliers = funcion_detecta_outliers_clase_interes(X,Y)
    pos_outliers = [];
    
    valoresY = unique(Y);
    FoI = Y == valoresY(2); % Filas de la clase de interés - color de seguimiento
    Xclase = X(FoI, :);

    numDatosClase = size(Xclase,1);
    numAtributos = size(Xclase,2);
    datosAtributos = [];
    rangoOutliersAtributos1 = [];
    rangoOutliersAtributos2 = [];
    nombreAtributos = {'R', 'G', 'B'};

    for i=1:numAtributos
        x = Xclase(:,i); % Datos del atributo

        % Algunos valores representativos de la muestra
        valor_medio = mean(x);
        desv_tipica = std(double(x));
        mediana = median(x);
        x_ord = sort(x);
        Q1 = x_ord(round(0.25*numDatosClase));
        Q3 = x_ord(round(0.75*numDatosClase));
        rango_intercuartilico = Q3-Q1;

        datos = [valor_medio; desv_tipica; double(Q1); double(mediana); double(Q3); double(min(x)); double(max(x))];
        datosAtributos = [datosAtributos datos];
        
        f1 = double(Q1-1.5*rango_intercuartilico);
        f2 = double(Q3+1.5*rango_intercuartilico);
        rangoOutliersAtributos1 = [rangoOutliersAtributos1 [f1;f2]];

        f1 = valor_medio-3*desv_tipica;
        f2 = valor_medio+3*desv_tipica;
        rangoOutliersAtributos2 = [rangoOutliersAtributos2 [f1;f2]];

    end
    
    R = X(:,1);
    G = X(:,2);
    B = X(:,3);

    % Cálculo de la media y desviación en R, G y B de la clase de interés
    medias = mean(X(FoI,:)) ; desv = std(double(X(FoI,:)));
    Rmean = medias(1); Rstd = desv(1);
    Gmean = medias(2); Gstd = desv(2);
    Bmean = medias(3); Bstd = desv(3);

    % Cómo de exigente queremos que sea
    factor_outlier = 3;

    % Consideramos que una instancia es un outlier si en cualquiera de sus
    % atributos el valor está fuera del rango:
    % [media_atributo -3*sigma_atributo, media_atributo + 3*sigma_atributo]
    outR = (R > Rmean + factor_outlier*Rstd) | (R < Rmean - factor_outlier*Rstd);
    outG = (G > Gmean + factor_outlier*Gstd) | (G < Gmean - factor_outlier*Gstd);
    outB = (B > Bmean + factor_outlier*Bstd) | (B < Bmean - factor_outlier*Bstd);

    % Únicamente validamos los outliers de las filas de la clase
    outR = and(FoI,outR);
    outG = and(FoI,outG);
    outB = and(FoI,outB);

    % Un outlier es una instancia que tiene un 1 binario en cualquiera
    % de esos canales
    outR_G = or(outR, outG);
    out_R_G_B = or(outR_G,outB);

    % Calculamos las posiciones de los outliers detectados
    pos_outliers = find(out_R_G_B);
end
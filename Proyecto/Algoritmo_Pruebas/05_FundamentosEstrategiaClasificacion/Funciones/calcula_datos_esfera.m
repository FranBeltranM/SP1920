function sol = calcula_datos_esfera(X,Y)
    % Variables %
    valoresY = unique(Y);
    PixelesColor = (Y==valoresY(2));
    PixelesFondo = (Y==valoresY(1));
    Cclase = X(PixelesColor,:);
    Fclase = X(PixelesFondo,:);
    
    % Centroide nube de color seguimiento
    valoresMedios = mean(Cclase);
    Rc = valoresMedios(1); Gc = valoresMedios(2); Bc = valoresMedios(3);
    PosCentroide = [Rc Gc Bc]';
    
    % Cálculo nubes de puntos %
    NubePuntosColor = double(Cclase(:,:))';
    NubePuntosFondo = double(Fclase(:,:))';
    
    PampColor = repmat(PosCentroide,1,size(NubePuntosColor,2));
    PampFondo = repmat(PosCentroide,1,size(NubePuntosFondo,2));
    
    vectorDistanciaC = sqrt( sum((PampColor-NubePuntosColor).^2) );
    vectorDistanciaF = sqrt( sum((PampFondo-NubePuntosFondo).^2) );
    
    radio1 = vectorDistanciaC(1);
    for i=1:size(vectorDistanciaC,2)
        if radio1 <= vectorDistanciaC(i)
            radio1 = vectorDistanciaC(i);
        end
    end
    
    radio2 = vectorDistanciaF(2);
    for i=1:size(vectorDistanciaF,2)
        if radio2 >= vectorDistanciaF(i)
            radio2 = vectorDistanciaF(i);
        end
    end
    
    radio2 = radio2-1;
    
    radio12 = mean([radio1 radio2]);
    sol = [Rc Gc Bc radio1 radio2 radio12];
end
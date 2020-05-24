function IbinFilt = funcion_elimina_regiones_ruidosas(Ibin)
    
    [N,M] = size(Ibin);
    Ibin2 = bwareaopen(Ibin, round(0.001*N*M)); % Valor *NumPix
    
    if sum(Ibin2>0)
       Ietiq = bwlabel(Ibin2); % Matriz etiquetada
       
       % Calculamos las areas de los objetos para un segundo filtrado
       stats = regionprops(Ietiq, 'Area');
       areas = cat(1, stats.Area);
       
       % Si los objetos son menores que este valor, se eliminan
       numPix = floor(max(areas)/5);
       
       IbinFilt = bwareaopen(Ibin2, numPix);
        
    else
        IbinFilt = Ibin2;
    end
    

end
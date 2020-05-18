function X = funcion_calcula_Hu_objetos_imagen(Ietiq, N)
    
    X = [];
    
    for i=1:N
        
        Ibin_i = Ietiq == 1;
        
        m = Funcion_Calcula_Hu(Ibin_i);
        X(i,:) = m';
        
    end
    
end
function Extent = funcion_calcula_Extent(Matriz_Binaria)
    
    Ibin_centrada = Funcion_Centra_Objeto(Matriz_Binaria);
    
    Ex = [];
    
    for i=0:5:355
        
        Ibin_rotada = imrotate(Ibin_centrada, i);
        stats = regionprops(Ibin_rotada, 'Extent');
        ExtentImagen = cat(1, stats.Extent);
        
        Ex = [Ex ExtentImagen];
        
    end
    
    Extent = max(Ex);
    
end
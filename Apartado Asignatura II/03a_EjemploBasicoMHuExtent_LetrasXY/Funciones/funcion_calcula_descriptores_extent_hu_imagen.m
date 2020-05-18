function XImagen = funcion_calcula_descriptores_extent_hu_imagen(Ietiq,N)
    
    stats = regionprops(Ietiq, 'Extent');
    
    ExtentImagen = cat(1, stats.Extent);
    HuImagen = funcion_calcula_Hu_objetos_imagen(Ietiq, N);
    XImagen = [ExtentImagen HuImagen];

end
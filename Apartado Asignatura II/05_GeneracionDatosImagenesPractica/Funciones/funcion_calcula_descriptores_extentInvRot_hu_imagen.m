function XImagen = funcion_calcula_descriptores_extentInvRot_hu_imagen(Ietiq,N)
    
    stats = regionprops(Ietiq, 'Extent');
    
    ExtentImagen = cat(1, stats.Extent);
    ExtentIR_HuImagen = funcion_calcula_ExtentIR_Hu_objetos_imagen(Ietiq, N);
    XImagen = [ExtentImagen ExtentIR_HuImagen];

end
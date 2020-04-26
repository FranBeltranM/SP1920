function representa_esfera(centroide, radio)
    [R,G,B] = sphere(100);
    
    x = radio(1,1)*R(:) + centroide(1);
    y = radio(1,1)*G(:) + centroide(2);
    z = radio(1,1)*B(:) + centroide(3);
    
    plot3(x,y,z, '.y')
end
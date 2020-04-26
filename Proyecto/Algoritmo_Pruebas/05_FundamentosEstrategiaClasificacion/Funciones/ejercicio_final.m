function ejercicio_final(imagenes, datosEsfera)
    radio1 = datosEsfera(4);
    radio2 = datosEsfera(5);
    radio12 = datosEsfera(6);
    
    figure
    for i=1:size(imagenes,4)
        imagen = imagenes(:,:,:,i);
        Rc = datosEsfera(1);
        Gc = datosEsfera(2);
        Bc = datosEsfera(3);

        R = double(imagen(:,:,1));
        G = double(imagen(:,:,2));
        B = double(imagen(:,:,3));

        MD = sqrt( (R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2 );

        % Matriz lógica
        Ib1 = MD < radio1;
        Ib2 = MD < radio2;
        Ib12 = MD < radio12;

%         C1 = funcion_visualiza(imagen, Ib1, [255 0 0]);
%         C2 = funcion_visualiza(imagen, Ib2, [255 0 0]);
%         C12 = funcion_visualiza(imagen, Ib12, [255 0 0]);
        
        subplot(2,2,1), imshow(imagen), title('Imagen original');
        subplot(2,2,2), funcion_visualiza(imagen, Ib1, [255 0 0]), title(['Imagen con ruido, Radio: ' num2str(radio1)]);
        subplot(2,2,3), funcion_visualiza(imagen, Ib2, [255 0 0]), title(['Imagen sin ruido, Radio: ' num2str(radio2)]);
        subplot(2,2,4), funcion_visualiza(imagen, Ib12, [255 0 0]), title(['Imagen compromiso, Radio: ' num2str(radio12)]);
        pause
    end
end
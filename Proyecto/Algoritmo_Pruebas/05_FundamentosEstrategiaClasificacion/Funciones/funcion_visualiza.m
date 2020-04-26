function funcion_visualiza(l, lB, Color)
    % Sacamos los datos de nuestra matriz inicial
    [nF,nC,nM] = size(l);
    
    % Comparamos nuestras matrices
    if ( [nF,nC] ~= size(lB) )
       disp('Las matrices tienen tamaños distintos.');
    else
        if( nM == 3 )
        % Si tenemos 3 Matrices en nuestra matriz inicial
        % Significa que tenemos una imagen a color { R,G,B }
            R = l(:,:,1);
            R(lB) = Color(1);
            G = l(:,:,2);
            G(lB) = Color(2);
            B = l(:,:,3);
            B(lB) = Color(3);
            
            C = uint8(cat(3,R,G,B));
            imshow(C)
        else
        % Tenemos una imagen en escala de grises
            R = l(:,:);
            R(lB) = Color(1);
            G = l(:,:);
            G(lB) = Color(2);
            B = l(:,:);
            B(lB) = Color(3);
            
            C = uint8(cat(3,R,G,B));
            imshow(C)
        end
    end
end
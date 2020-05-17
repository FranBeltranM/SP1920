function C = funcion_visualiza(I, Ib, color)
    % Sacamos los datos de nuestra matriz inicial
    [nF,nC,nM] = size(I);
    C = [];
    
    % Comparamos nuestras matrices
    if ( size(I) ~= size(Ib) )
       disp('Las matrices tienen tamaños distintos.');
    else
        if( nM == 3 )
        % Si tenemos 3 Matrices en nuestra matriz inicial
        % Significa que tenemos una imagen a color { R,G,B }
            R = I(:,:,1);
            R(Ib(:,:,1)) = color(1);
            G = I(:,:,2);
            G(Ib(:,:,2)) = color(2);
            B = I(:,:,3);
            B(Ib(:,:,3)) = color(3);
            
            C = uint8(cat(3,R,G,B));
        else
        % Tenemos una imagen en escala de grises
            R = I(:,:);
            R(Ib) = color(1);
            G = I(:,:);
            G(Ib) = color(2);
            B = I(:,:);
            B(Ib) = color(3);
            
            C = uint8(cat(3,R,G,B));
        end
    end
end
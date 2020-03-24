function C = funcion_imhist_v2(I)
    C = double(zeros(256,1));
    
    for gris = 0:255
        C(gris+1) = sum(sum(I==gris));
    end
end
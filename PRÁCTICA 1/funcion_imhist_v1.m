function C = funcion_imhist_v1(A)
    C = zeros(256,1);
    double(C);
    
    [nf nc] = size(A);
    
    for i = 1:nf
        for j = 1:nc
            index = double(A(i,j))+1;
            C(index) = C(index)+1;
        end
    end
end
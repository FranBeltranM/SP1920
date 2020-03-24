I = imread("P1_1.jpg");
Imagen3 = I(:,:,2);

Imagen4 = imadjust(Imagen3, [], [], 0.5);
Imagen5 = imadjust(Imagen3, [], [], 1.5);

Imagen6M = imabsdiff(Imagen5, Imagen5);
Imagen6N = funcion_imabsdiff(Imagen5, Imagen5);

funcion_compara_matrices(Imagen6N, Imagen6M)
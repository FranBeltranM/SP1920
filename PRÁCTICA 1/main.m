imagen = imread('ImagenBinaria.tif');

ROI = imagen<120;

filas = Funcion_etiquetar_V2(ROI, 8, "filas");
columnas = Funcion_etiquetar_V2(imagen>100, 4, "columnas");

imtool(columnas)
imtool(filas)


Ib = imread('ImagenBinaria.tif');

Ietiq = Funcion_etiquetar_V2(Ib>100,8,"columnas");

imtool(Ietiq==1)
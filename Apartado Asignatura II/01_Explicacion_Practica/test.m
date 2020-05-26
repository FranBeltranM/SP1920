load datos_MDE_2dimensiones.mat

load datos_MDM_3dimensiones.mat
[mCov, coef_corr1, coef_corr2, numDatosClase1, numDatosClase2, numDatos, d1, d2, d12, coeficientes_d12, Acc1, Acc2] = Calculo_Clasificador(X,Y, "MDE")
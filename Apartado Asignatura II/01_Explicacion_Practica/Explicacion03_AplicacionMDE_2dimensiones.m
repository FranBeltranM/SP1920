clear
close all
addpath('Datos')
addpath('Funciones')

%% MÍNIMA DISTANCIA EUCLIDEA 2 DIMENSIONES
load datos_MDE_2dimensiones.mat

valoresClases = unique(Y);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(X);

%% REPRESENTACIÓN DE LOS DATOS
funcion_representa_muestras_clasificacion_binaria(X,Y)

hold on

% CALCULO DE LAS MATRICES DE COVARIANZAS DE CADA CLASE
% OBJETIVO MEDIR CORRELACIÓN ENTRE LOS DATOS Y ANALIZAR LAS SUPOSICIONES
% QUE SE TIENEN QUE CUMPLIR PARA APLICAR EL CLASIFICADOR MDE

% Aprovechamos para calcular el vector de medias de cada clase

M = zeros(numClases, numAtributos);
mCov = zeros(numAtributos, numAtributos, numClases);

for i=1:numClases
    
   FoI = Y == valoresClases(i);
   XClase = X(FoI, :);
   M(i,:) = mean(XClase);
   mCov(:,:,i) = cov(XClase, 1);

end

hold on, plot(M(:,1),M(:,2), 'ko--')

mCov

% Varianzas de los atributos aproximadamente iguales

% Variables no correladas, covarianza de las variables aproximadamente 0
mCov_clase1 = mCov(:,:,1);
coef_corr = funcion_calcula_coeficiente_correlacion_lineal_2_variales(mCov_clase1)

mCov_clase2 = mCov(:,:,2);
coef_corr = funcion_calcula_coeficiente_correlacion_lineal_2_variales(mCov_clase2)

% probabilidad a priori de clases
numDatosClase1 = sum(Y==valoresClases(1))
numDatosClase2 = sum(Y==valoresClases(2))
numDatos

% SE CUMPLEN TODAS LAS CONDICIONES DE APLICACIÓN PAR LA APLICACIÓN DE MDE

%% DISEÑO DEL CLASIFICADOR MDE

[d1, d2, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(X,Y);


%% REPRESENTACIÓN DE LA FRONTERA DE SEPARACIÓN ENTRE LAS DOS CLASES: LÍNEA RECTA D12 = 0
x1min = min(X(:,1)); x1max = max(X(:,1));
x2min = min(X(:,2)); x2max = max(X(:,2));
axis([ x1min x1max x2min x2max ])

A = coeficientes_d12(1); B = coeficientes_d12(2); C = coeficientes_d12(3);
x1Recta = x1min:0.01:x1max;
x2Recta = -(A*x1Recta+C)/(B+eps);

plot(x1Recta, x2Recta, 'g')


%% APLICACIÓN DEL CLASIFICADOR: OPCIÓN CUADRÁTICA - TANTAS FUNCIONES DE DECISIÓN COMO CLASES

Y_clasificador1 = zeros(size(Y));

for i=1:numDatos
    XoI = X(i,:);
    x1 = XoI(1);
    x2 = XoI(2);
    
    valor_d1 = eval(d1);
    valor_d2 = eval(d2);
    
    if valor_d1 > valor_d2
        Y_clasificador1(i) = valoresClases(1);
    else
        Y_clasificador1(i) = valoresClases(2);
    end
    
end

%% APLICACIÓN DEL CLASIFICADOR: OPCIÓN LINEAL - 1 FUNCIÓN PARA SEPARAR DOS CLASES

Y_clasificador2 = zeros(size(Y));

for i=1:numDatos
    XoI = X(i,:);
    x1 = XoI(1);
    x2 = XoI(2);
    
    d12_manual = A*x1 + B*x2 + C;
    eval(d12);
    
    if d12_manual > 0
        Y_clasificador2(i) = valoresClases(1);
    else
        Y_clasificador2(i) = valoresClases(2);
    end
    
end

%% EVALUAMOS LA PRECISIÓN

Y_modelo = Y_clasificador1;

error = Y_modelo-Y;

num_aciertos = sum(error==0);

Acc = num_aciertos / numDatos




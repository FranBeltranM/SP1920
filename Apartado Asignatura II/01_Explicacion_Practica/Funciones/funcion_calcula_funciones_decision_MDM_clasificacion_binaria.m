function [d1_mCov_de_cada_clase, d2_mCov_de_cada_clase, d12, coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y)

    datos = X; % vamos a dejar la X para la notación del vector de atributos genérico
    
    valoresClases = unique(Y);
    numClases = length(valoresClases);
    [numDatos, numAtributos] = size(datos);
    
    x1 = sym('x1', 'real');
    x2 = sym('x2', 'real');
    
    X = [x1 ; x2];
    
    if numAtributos == 3
        
        x3 = sym('x3', 'real');
        X = [X; x3];
        
    end
    
    % Calculo vector prototipos y matrices de covarianzas de cada clase
    M = zeros(numClases, numAtributos);
    mCov = zeros(numAtributos, numAtributos, numClases);
    
    for i=1:numClases
       FoI = Y == valoresClases(i);
       XClase = datos(FoI, :);
       M(i,:) = mean(XClase);
       mCov(:,:,i) = cov(XClase, 1);
    end
    
    % Matrices de covarianzas de cada clase
    mCov1 = mCov(:,:,1);
    mCov2 = mCov(:,:,2);
    
    % Matriz de covarianza que se utiliza para el cálculo de función lineal
    % SE DEBE CONSIDERAR UN ÚNICA MATRIZ DE COVARIANZAS PARA LAS DOS CLASES
    
    numDatosClase1 = sum(Y==valoresClases(1));
    numDatosClase2 = sum(Y==valoresClases(2));
    mCov = (numDatosClase1*mCov1 + numDatosClase2*mCov2) / (numDatosClase1 + numDatosClase2)
    
    % Calculo de las funciones de decision de cada clase: menos Distancia
    % Euclidea al cuadrado entre X y el Vector prototipo de la clase
    
    M1 = M(1,:)'; % vector columna - observar que hacemos la traspuesta
    d1_mCov_de_cada_clase = expand(-(X-M1)'*pinv(mCov1)*(X-M1));
    d1_mCov_comun = expand(-(X-M1)'*pinv(mCov)*(X-M1));
    
    M2 = M(2,:)'; % vector columna - observar que hacemos la traspuesta
    d2_mCov_de_cada_clase = expand(-(X-M2)'*pinv(mCov2)*(X-M2));
    d2_mCov_comun = expand(-(X-M2)'*pinv(mCov)*(X-M2));
    
    % Función de decisión que separa las muestras de la clase d12 = d1-d2
    % Frontera de decisión: d12 = d1 - d2 = 0;
    
    d12 = d1_mCov_comun-d2_mCov_comun; % forma lineal
    
    % Calculo de coeficientes
    
    if numAtributos == 2
        % Si dimension 2; d12 = A^x1 + B^x2 + C - forma lineal
        x1 = 0; x2 = 0; C = eval(d12);
        x1 = 1; x2 = 0; A = eval(d12)-C;
        x1 = 0; x2 = 1; B = eval(d12)-C;
        
        coeficientes_d12 = [A B C];
        
    else
        % Si dimension 3; d12 = A^x1 + B^x2 + C^x3 + D
        x1 = 0; x2 = 0; x3 = 0; D = eval(d12);
        x1 = 1; x2 = 0; x3 = 0; A = eval(d12)-D;
        x1 = 0; x2 = 1; x3 = 0; B = eval(d12)-D;
        x1 = 0; x2 = 0; x3 = 1; C = eval(d12)-D;
        
        coeficientes_d12 = [A B C D];

    end
    
end
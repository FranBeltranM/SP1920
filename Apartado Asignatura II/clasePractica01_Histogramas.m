%% EJEMPLO CONCEPTOS BÁSICOS - HISTOGRAMAS

I = uint8([0 1 5 0; 2 2 2 5])
imhist(I)
h = imhist(I);
stem(0:5,h(1:6),'.r'), grid on


%% VALOR MEDIO:

% 1.- RECORRIENDO PÍXELES DE LA IMAGEN

Id = double(I);

[numFilas, numColumnas] = size(Id);
numPix = numFilas * numColumnas;
vm = 0;

for i=1:numFilas
   for j=1:numColumnas
       
      vm = vm + Id(i,j);
      
   end
end

vm = vm / numPix
vm = mean(Id(:))

% 2.- A PARTIR DEL HISTOGRAMA

h = imhist(I);
numPix = sum(h);
vm = 0;
for g=0:255
    
    ind = g+1;
	vm = vm + g*h(ind);
    
end

vm = vm/numPix


%% VARIANZA: DESVIACIÓN TÍPICA AL CUADRADO

% 1.- RECORRIENDO PÍXELES DE LA IMAGEN

Id = double(I);

[numFilas, numColumnas] = size(Id);
numPix = numFilas*numColumnas;
varianza = 0;

for i=1:numFilas
   for j=1:numColumnas
       
       varianza = varianza + (Id(i,j)-vm)^2;
       
   end
end

varianza = varianza/numPix
varianza = var(Id(:),1) % IMPORTANTE PONER EL 1, PARA TODOS LOS PÍXELES

% 2.- A PARTIR DEL HISTOGRAMA

h = imhist(I);
numPix = sum(h);
varianza = 0;

for g=0:255
   
    ind = g + 1;
    varianza = varianza + h(ind)*(g-vm)^2;
    
end

varianza = varianza/numPix


% 3.- EN TODAS LAS EXPRESIONES ANTERIORES, SE PUEDE UTILIZAR
% p = h/numPix --> histogramas normalizados entre 0-1, y no haría falta
% dividir por numPix

h = imhist(I);
numPix = sum(h);
p = h/numPix;

vm = 0;

for g=0:255 % g es una unidad menor que ind
   ind = g + 1;
   vm = vm + p(ind)*g;
end

varianza = 0;
for g=0:255 % g es una unidad menor que ind
    ind = g + 1;
    varianza = varianza + p(ind)*(g-vm)^2;
end

[vm mean(Id(:))]
[varianza var(Id(:),1)]














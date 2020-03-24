% Ejercicios Vecindad

% 1)
A = uint8(255*rand(5));

% 2)
nF = 3;
nC = 4;
B = A(nF-1:nF+1, nC-1:nC+1)

% 3)
C = [A(nF,nC-1:nC+1) A(nF-1:nF+1,nC)']
ind = find(C==A(3,4))
C(ind) = []

% 4)
D = A(nF-1, nC-1:nC+1)

% 5)
D = [D A(nF,nC-1:2:nC+1)]

% 6)
E = A;
index = find(E<(0.5*255));
E(index) = 0

% OTRA OPCIÓN
    E(A<128) = 0

% 7)
index = find(A<=(0.7*255) & A>=(0.2*255));
media = sum(A(index)) / length(index)

% OTRA OPCIÓN
    media = mean( A(A>0.2*255 & A<0.7*255) )

% 8)
A = uint8(10*rand(5))
B = uint8(10*rand(5))
index = find(B>=(0.5))
media = sum(A(index)) / length(index)

% OTRA OPCIÓN
    media = mean ( A(B>=5) )

% 9)
clear;
I = imread("P1_1.jpg");

R = double(I(:,:,1));
G = double(I(:,:,2));
B = double(I(:,:,3));

Ic = (R+G+B)/3;
Ic = cat(3,I,I,I);

size(Ic)

vector_color = [255 0 0];
%ROI = I >100 & I<150;

ROI = I(:,:,1) < 100;

%figure, imshow(uint8(I))

ejercicio9(I, ROI, vector_color)
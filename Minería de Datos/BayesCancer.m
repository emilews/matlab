b = zeros(1, 11);
m = zeros(1, 11);
repB = zeros(9, 10);
repM = zeros(9, 10);
contb = 1;
contm = 1;
%Paso 1: diferenciación de clases
for i = 1 : size(Train, 1)
    if(Train(i, 11) == 2)
        b(contb, :) = Train(i, :);
        contb = contb + 1;
    end
    if(Train(i, 11) == 4)
        m(contm, :) = Train(i, :);
        contm = contm + 1;
    end
end
%Paso 2: reptición de valores en atributos
%repetición de valores para benignos
for i = 2 : 10
    for j = 1 : 10
        repB(i-1, j) = sum(b(:, i)==j);
    end
end
%reptición de valores para malignos
for i = 2 : 10
    for j = 1 : 10
        repM(i-1, j) = sum(m(:, i)==j);
    end
end
%Paso 3: Sumar 1 a para que no haya 0
repM = repM + 1;
repB = repB + 1;

%Paso 4: Normalizar
%Norm the beningnos
for i = 1 : 9
    sumaFila = sum(repB(i, :));
    for j = 1 : 10
        repB(i, j) = repB(i, j)./sumaFila;
    end
end
%Norm de malignos
for i = 1 : 9
    sumaFila = sum(repM(i, :));
    for j = 1 : 10
        repM(i, j) = repM(i, j)./sumaFila;
    end
end
%Testing
copiaTest = Test;
resultados = zeros(239, 1);
maxP = 0.5;

for i = 1 : size(copiaTest, 1)-1;
    multB = 1;
    multM = 1;
    for j = 2 : 10;
        multB = multB * repB(j-1, copiaTest(i, j)) * copiaTest(i, j);
        multM = multM * repM(j-1, copiaTest(i, j)) * copiaTest(i, j);
    end
    resB = maxP*multB;
    resM = maxP*multM;
    if gt(resB, resM)
        resultados(i) = 2;
    end
    if gt(resM, resB)
        resultados(i) = 4;
    end
end
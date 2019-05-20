addpath('C:\Users\emili\Documents\MATLAB\matlab\Inteligencia Artificial\Trabajo Cancer\libsvm-3.23\matlab');
%Empezamos todo con Leave One Out
%Primer for para saber cual dejar fuera
%Creamos variables para conocer el accuracy del algoritmo
ClassOnePositive = 0;
ClassOneNegative = 0;
ClassTwoPositive = 0;
ClassTwoNegative = 0;
for i = 1 : size(SAMPLES, 1);
    %Variable para conocer si ya dejamos un sample fuera
    leftOne = false;
    %Inicializamos arrays en cero para llenarlos con los datos para
    %entrenar restando 1 al tama�o, es decir, sin tomar en cuenta el que
    %dejamos fuera
    TrainLabels = zeros(size(LABELS, 1) - 1, 1);
    TrainSamples = zeros(size(SAMPLES, 1) - 1, size(SAMPLES, 2));
    %Inicializamos arrays en cero para llenarlos con el que se deja fuera
    TestLabel = zeros(1,1);
    TestSample = zeros(1, size(SAMPLES, 2)); %<- Del tama�o en X de SAMPLES
    %Segundo for para saber los que NO deben quedar fuera
    for j = i : size(SAMPLES, 1);
        if (j == i);
            TestLabel(1,1) = LABELS(i, 1);
            TestSample(1, :) = SAMPLES(i, :);
            leftOne = true;
        end;
        %Si ya dejamos uno fuera, entonces tenemos que restar 1 al contador
        %puesto que en el array tenemos 1 menos de tama�o que el original,
        %tenemos que compensar
        if(leftOne == false);
            TrainLabels(j, 1) = LABELS(j, 1);
            TrainSamples(j, :) = SAMPLES(j, :);
        end;
        if(leftOne == true);
            if(i == 1);
                TrainLabels(j, 1) = LABELS(j, 1);
                TrainSamples(j, :) = SAMPLES(j, :);
            end;
            if(i ~= 1);
                if(i ~= 683); 
                    TrainLabels(j - 1, 1) = LABELS(j, 1);
                    TrainSamples(j - 1, :) = SAMPLES(j, :);
                end;
            end;
        end;
    end;
    %Mapeamos los casos en los labels
    Map2 = TrainLabels==2;
    Map4 = TrainLabels==4;
    %Usamos los mapas para separar los casos
    Samples2 = (TrainSamples(Map2,:));
    Samples4 = (TrainSamples(Map4,:));
    %Juntamos los samples
    AllSamples = [Samples2; Samples4];
    %Matriz de labels con 2 y 4
    Label2=ones(size(Samples2, 1), 1);
    %Cambiamos de 1 a 2 puesto que as� est�n los labels
    Label2(:,:) = 2;
    Label4=zeros(size(Samples4, 1), 1);
    %Cambiamos de 0 a 4 puesto que as� est�n los labels
    Label4(:,:) = 4;
    LabelsMatrix= [Label2; Label4];
    %Entrenamos con lo que tenemos (si no es la �ltima iteraci�n)
    if(i ~= 683);
        svmstruct = svmtrain(LabelsMatrix, AllSamples, '-s 0 -q');
    end;
    %Por alguna raz�n se rompe cuando estamos en la �ltima
    %iteraci�n (i = 683), mejor reiniciamos todo y no hacemos preguntas
    if(i == 683);
        svmstruct = Exception(SAMPLES, LABELS);
    end;
    %Predecimos con el que dejamos fuera
    [pred_labels,ac,p] = svmpredict(TestLabel,TestSample,svmstruct,'-q');
    %Empezamos con los positivos y negativos
    %Si se acert�, entonces vemos si fue de clase 2 o clase 4 y sumamos uno
    %al contador
    if (ac(1) == 100);
        if(TestLabel(1) == 2);
            ClassOnePositive = ClassOnePositive + 1;
        end;
        if(TestLabel(1) == 4);
            ClassTwoPositive = ClassTwoPositive + 1;
        end;
    end;
    if(ac(1) == 0);
        if(TestLabel(1) == 2);
            ClassOneNegative = ClassOneNegative + 1;
        end;
        if(TestLabel(1) == 4);
            ClassTwoNegative = ClassTwoNegative + 1;
        end;
    end;
end;
%Sacamos el accuracy general
Nom = (ClassOnePositive+ClassTwoPositive);
Den = (ClassOnePositive+ClassTwoPositive+ClassOneNegative+ClassTwoNegative);
ACC = Nom / Den;
Accuracy = ACC * 100;
%Sacamos accuracy de benigno
den = (ClassOnePositive+ClassTwoPositive+ClassOneNegative+ClassTwoNegative);
bAccuracy = (ClassOnePositive / den)*100;
%Sacamos accuracy de maligno
den = (ClassOnePositive+ClassTwoPositive+ClassOneNegative+ClassTwoNegative);
mAccuracy = (ClassTwoPositive / den)*100;
%Sacamos accuracy de maligno
%Sacamos la precisi�n para benignos
bPrecision = ClassOnePositive / (ClassOnePositive + ClassTwoPositive);
%Sacamos la precisi�n para malignos
mPrecision = ClassTwoPositive / (ClassOnePositive + ClassTwoPositive);
%Sacamos el recall benigno
bRecall = ClassOnePositive / (ClassOnePositive + ClassTwoNegative);
%Sacamos el recall maligno
mRecall = ClassTwoPositive / (ClassTwoPositive + ClassOneNegative);
%Sacamos F1-Score para benignos
bF = 2*(bRecall*bPrecision) / (bRecall+bPrecision);
%Sacamos F1-Score para malignos
mF = 2*(mRecall*mPrecision) / (mRecall+mPrecision);
disp('Accuracy general');
disp(Accuracy);
disp('Accuracy benigno');
disp(bAccuracy);
disp('Accuracy maligno');
disp(mAccuracy);
disp('Precision benigno');
disp(bPrecision);
disp('Precision maligno');
disp(mPrecision);
disp('Recall benigno');
disp(bRecall);
disp('Recall maligno');
disp(mRecall);
disp('F1-Score benigno');
disp(bF);
disp('F1-Score maligno');
disp(mF);
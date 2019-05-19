addpath('C:\Users\emili\Documents\MATLAB\matlab\Inteligencia Artificial\Trabajo Cancer\libsvm-3.23\matlab');
%Empezamos todo con Leave One Out
%Primer for para saber cual dejar fuera
%Creamos variables para conocer el accuracy del algoritmo
Success = 0;
for i = 1 : size(SAMPLES, 1)-1;
    %Variable para conocer si ya dejamos un sample fuera
    leftOne = false;
    %Inicializamos arrays en cero para llenarlos con los datos para
    %entrenar restando 1 al tamaño, es decir, sin tomar en cuenta el que
    %dejamos fuera
    TrainLabels = zeros(size(LABELS, 1) - 1, 1);
    TrainSamples = zeros(size(SAMPLES, 1) - 1, size(SAMPLES, 2));
    %Inicializamos arrays en cero para llenarlos con el que se deja fuera
    TestLabel = zeros(1,1);
    TestSample = zeros(1, size(SAMPLES, 2)); %<- Del tamaño en X de SAMPLES
    %Segundo for para saber los que NO deben quedar fuera
    for j = i : size(SAMPLES, 1);
        if (j == i);
            TestLabel(1,1) = LABELS(i, 1);
            TestSample(1, :) = SAMPLES(i, :);
            leftOne = true;
        end;
        %Si ya dejamos uno fuera, entonces tenemos que restar 1 al contador
        %puesto que en el array tenemos 1 menos de tamaño que el original,
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
                TrainLabels(j - 1, 1) = LABELS(j, 1);
                TrainSamples(j - 1, :) = SAMPLES(j, :);
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
    Label4=zeros(size(Samples4, 1), 1);
    Label4(:,:) = 4;
    LabelsMatrix= [Label2; Label4];
    %Entrenamos con lo que tenemos
    svmstruct = svmtrain(LabelsMatrix, AllSamples, '-b 1 -q');
    %Predecimos con el que dejamos fuera
    [pred_labels,ac,p] = svmpredict(TestLabel,TestSample,svmstruct,'-b 1 -q');
    disp(pred_labels);
    if(ac(1) == 100);
       Success = Success + 1;
    end;
end;
disp(Success);
Accuracy = (Success*100)/size(SAMPLES, 1);
disp(Accuracy);


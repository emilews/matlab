function data = Exception(SAMPLES, LABELS)
    i = 683;
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
    for j = 1 : size(SAMPLES, 1);
        if (j == i);
                TestLabel(1,1) = LABELS(i, 1);
                TestSample(1, :) = SAMPLES(i, :);
                leftOne = true;
        end;
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
    Map2 = TrainLabels==2;
    Map4 = TrainLabels==4;
    Samples2 = (TrainSamples(Map2,:));
    Samples4 = (TrainSamples(Map4,:));
    AllSamples = [Samples2; Samples4];
    Label2=ones(size(Samples2, 1), 1);
    Label4=zeros(size(Samples4, 1), 1);
    Label4(:,:) = 4;
    LabelsMatrix= [Label2; Label4];
    data = svmtrain(LabelsMatrix, AllSamples, '-b 1 -q');

end
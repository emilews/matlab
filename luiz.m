num_samples = size(SAMPLES2,1);
K = size(Centroids,1);
Asignacion=zeros(num_samples,1);
DistanciasMinimas=zeros(num_samples,1);
Distancias=zeros(num_samples,K);
CentroidsNew=zeros(K,num_attributes);
%Sacamos Asignacion y Distancias
for i=1 : num_samples
    distanciaMinima=9999999999;
    for j=1 : K
        distanciaActual = distancia(SAMPLES2, Centroids, i, j);
        Distancias(i,j) = distanciaActual;
       if(distanciaMinima > distanciaActual )
         distanciaMinima = distanciaActual;
         Asignacion(i,1) = j;
         DistanciasMinimas(i,1) = distanciaMinima;        
       end  
    end
end

%Sacamos CentroidsNew:
CentroidsNew=zeros(K,num_attributes);
for i=1 : K
    %Conseguimos los indices donde se encuentran asignados los 8 centroides
    indx = find(Asignacion==i);
    %Recorremos todos los indices que encontramos con el K en cuestion
    for j=1 : length(indx)
        %Sumamos en CentroidsNew los samples que le corresponden al
        %centroide (suma de vectores)
        CentroidsNew(i,:)= CentroidsNew(i,:) + SAMPLES2 (indx(j,:),:);
    end
    %Dividir CentroidsNew entre el numero de Samples que se encontraron
    %para ese centroide
    CentroidsNew = CentroidsNew/length(indx);
end
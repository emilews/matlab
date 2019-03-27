function [rec] = Recalculate(SAMPLES2, AssignedCent, Centroids, dists, num_samples, num_gest)
%Queremos sacar las distancias entre las muestras y los centroides

for i = 1 : num_samples; %Para el número de muestras
    for j = 1 : num_gest; %Para el número de gestos
        %Llamamos a distancia para conocer la distancia hacia cada
        %centroide
        dists(i, j) = distancia(SAMPLES2(i, :), Centroids(j, :));
    end
    %Cuando finaliza una iteración de los gestos, sacamos el indice de la
    %distancia más corta y la guardamos en AssignedCent
    [mini, ind] = min(dists(i, :));
    AssignedCent(i) = ind;
end
lastCentroids = Centroids;

for k = 1 : 18
    for i = 1 : 8 %Para el centroide
        tmp = 0;
        for j = 1 : size(AssignedCent, 1)
            if AssignedCent(j) == i
                tmp = tmp + SAMPLES2(j, k);
            end
        end
        divD = length(find(AssignedCent==i))
        Centroids(i, k) = tmp/divD;
    end
end
if lastCentroids ~= Centroids
    Recalculate(SAMPLES2, AssignedCent, Centroids, dists, num_samples, num_gest)
end
function NI=k_meansIA(k, image, w)

%k es el num de clusters
%image es la imagen a analizar. El nombre deberá recibirse entre apóstrofes 'NombreDeArchivo.tiff '
% Este ser? el peso de la posici?n en x, y.

%k_means(k, 'Tiger1.tiff', 0)
k=5;
I1= im2uint16(imread('Tiger1.jpg'));
I1 = I1/256;
s=size(I1);
I=zeros(s(1), s(2), 3);
% Convertir la imagen a modo matriz 3D
I(:,:,1)= I1(:,:,1);
I(:,:,2)= I1(:,:,2);
I(:,:,3)= I1(:,:,3);

s=size(I);
new_image=zeros(s);
num_rows= s(1); 
num_cols=s(2);
num_elems = num_rows * num_cols;

% Crear la matriz de Features
Features = Create_Features(I, num_rows, num_cols);

% normalizar Features
Feature_Norm = normalize_matrix(Features);

%Inicializar centroides. Elijan k centroides al azar
centroids = init_centroids(Feature, k);


% Aquí va su código para ejecutar KMeans. Por lo pronto se requiere hacer
% lo necesario para tener un vector con la predicción (Assign) que
% contenga el número de cluster para cada uno de los pixeles.
num_attributes = 5;
num_samples = size(Feature_Norm, 1);
samples = Feature_Norm;
dists = zeros(num_cols*num_rows, k);
Centroids = centroids;
AssignedCent = zeros(num_cols*num_rows, 1);
isDifferent = true;
while(isDifferent)
    for i = 1 : num_samples; %Para el número de muestras
        for j = 1 : num_attributes; %Para el número de gestos
            %Llamamos a distancia para conocer la distancia hacia cada
            %centroide
            dists(i, j) = distancia(samples(i, :), Centroids(j, :));
        end
        %Cuando finaliza una iteración de los gestos, sacamos el indice de la
        %distancia más corta y la guardamos en AssignedCent
        [mini, ind] = min(dists(i, :));
        AssignedCent(i) = ind;
    end

    Centroids2 = zeros(k, num_attributes);
        for i = 1 : k %Para el centroide
            indx = find(AssignedCent == i);
            for j = 1 : length(indx)
                Centroids2(i, :) = Centroids2(i, :) + samples(indx(j, :), :);
            end
            Centroids2(i, :) = Centroids2(i, :)./length(indx);
        end
        if(Centroids2 == Centroids)
            isDifferent = false;
        end
        Centroids = Centroids2;
end
% compute new colors and create new image
% Antes de ejecutar esto deberán calcular los colores originales de
% los centroides, esto es el promedio de los valores originales
% para cada canal de color (r, g, b) para cada cluster. los valores
% calculados serán guardados en centers(k, 3)

% I is the original image
s=size(I);
% crear una matriz del mismo tamaño que I
new_image=zeros(s);

% Para cada cluster generaremos un mapa (o máscara) para que nos
% regrese una matriz con 1 en los pixeles que correspondan a ese
% cluster
% después supliremos los valores de r g b por los valores del cluster
% al que pertenece cada pixel.
clusters = Create_Cluster(AssignedCent, Features, I);
centers = Create_Centers(AssignedCent, Features, k);
for i=1:k
mask = (clusters ==i);
new_image(:,:,1) = new_image(:,:,1) + (mask.* centers(i, 3));
new_image(:,:,2) = new_image(:,:,2) + (mask.* centers(i, 4));
new_image(:,:,3) = new_image(:,:,3) + (mask.* centers(i, 5));
end

NI=uint8(new_image);


end
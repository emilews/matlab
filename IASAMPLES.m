% Para asignar los centroides con muestras random representativas de cada gesto.
%Normalmente no lo hacemos de esta manera porque en el %aprendizaje no supervisado no tenemos las etiquetas, %pero hoy vamos a sacar ventaja de que sí las tenemos.
SAMPLES2 = SAMPLES_FIXED_Kmeans_Deltas;
num_attributes = size(SAMPLES2, 2);
num_samples = size(SAMPLES2, 1);

dists = zeros(633, 8);
CentroidsBU = Centroids;
AssignedCent = zeros(633, 1);

Recalculate(SAMPLES2, AssignedCent, Centroids, dists, num_samples, num_gest)
disp('Recalculación terminada')
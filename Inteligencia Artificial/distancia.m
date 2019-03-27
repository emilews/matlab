function [dist]= distancia(SAMPLES, CENTROIDS)
    dist = 0;
    for i = 1 : 5;
        dist = dist + power(SAMPLES(1, i) - CENTROIDS(1, i), 2);
    end
    dist = sqrt(dist);
end
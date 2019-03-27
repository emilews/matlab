function f=init_centroids(features_norm, k)
    f = zeros(k, size(features_norm, 2));
    for i = 1 : k
        r1 = rand()* size(features_norm,1);
        r2 = cast(r1, 'uint32');
        f(i, :) = features_norm(r2, :);
    end
end

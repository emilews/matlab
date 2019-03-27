function f=normalize_matrix(features)
    f = features;
    maxR = max(f(:, 3));
    maxG = max(f(:, 4));
    maxB = max(f(:, 5));
    maxX = 364;
    maxY = 236;
    for i = 1 : size(f,1)
       f(i, 1) = (f(i, 1) - 1)/(maxX - 1);
       f(i, 2) = (f(i, 2) - 1)/(maxY - 1);
       f(i, 3) = (f(i, 3) - 1)/(maxR - 1);
       f(i, 4) = (f(i, 4) - 1)/(maxG - 1);
       f(i, 5) = (f(i, 5) - 1)/(maxB - 1);
    end
end

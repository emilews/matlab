function centers = Create_Centers(AssignedCents, Features, K)
    num_rows = k;
    num_cols = 3;
    r = 0;
    g = 0;
    b = 0;
    centers = zeros(num_rows, num_cols);
    for j = 1 : size(Features, 1)
        for i = 1 : size(AssignedCents,1)
            if (AssignedCents(j) == Features(j))
                r = r + Features(i, 3) * Features(i, 3);
                g = g + Features(i, 4) * Features(i, 4);
                b = b + Features(i, 5) * Features(i, 5);
            end
        end
        T=sum(AssignedCents(:, 1) == j);
        r = sqrt(r/T);
        g = sqrt(g/T);
        b = sqrt(b/T);
        centers(j,1:3) = [r,g,b];
    end
    
end

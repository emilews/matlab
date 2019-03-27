function clusters = Create_Cluster(AssignedCents, Features, I)
    num_rows = size(I,1);
    num_cols = size(I,2);
    clusters = zeros(num_rows, num_cols);
        for i = 1 : size(AssignedCents,1)
            x = Features(i, 1);
            y = Features(i, 2);
            clusters(x, y) = AssignedCents(i);
        end
end

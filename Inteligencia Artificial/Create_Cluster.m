function clusters = Create_Cluster(AssignedCents, Features, I)
    s = size(I);
    num_rows = s(1);
    num_cols = s(2);
    clusters = zeros(num_rows, num_cols);
        for i = 1 : size(AssignedCents,1)
            x = Features(i, 1);
            y = Features(i, 2);
            clusters(y, x) = AssignedCents(i);
        end
end

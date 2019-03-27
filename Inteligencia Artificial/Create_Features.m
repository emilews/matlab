function f=Create_Features(i, row, col)
    f = zeros(row*col, 5);
    cont = 1;
    for y = 1 : row
        for x = 1 : col
            f(cont, :) = [x, y, i(y,x,1), i(y,x,2), i(y,x,3)];
            cont = cont + 1;
        end
    end
end

szUnique = size(UniqueStockCode);
tamUnique = szUnique(1);
szF = size(f);
tamF = szF(1);
fBack = f;
UniqueBU = zeros(tamUnique, 1);
for c = 1 : tamUnique
    disp(c)
    for i = 1 : tamF
        if isequal(f(i, 2), UniqueStockCode(c, 1))
            ant = UniqueBU(c, 1);
            new = f(i,4);
            UniqueBU(c, 1) = ant + new{1,1};
            f(i, :) = [];
        end
    end
end
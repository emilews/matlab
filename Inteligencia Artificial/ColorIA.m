function y=ColorIA(assigneds,Features,k)
for j=1:k
    r=0;
    g=0;
    b=0;
    for i=1:size(assigneds,1)
        if (assigneds(i)==j)
        r= r+ Features(i,3)*Features(i,3);
        g= g+ Features(i,4)*Features(i,4);
        b= b+ Features(i,5)*Features(i,5);
        end
    end
    T=sum(assigneds(:,1)==j);
    r=sqrt(r/T);
    g=sqrt(g/T);
    b=sqrt(b/T);
    centers(j,1:3)=[r,g,b];
end
y=centers;
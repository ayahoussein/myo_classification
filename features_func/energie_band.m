function EN_band = energie_band( signal, fband ,fs )

fa=fband(1,1);
fb=fband(1,2);
fc=fband(1,3);
fd=fband(1,4);

for i=1:8
    [px(:,i),f]=pwelch(signal(:,i),[],[],[],fs);
end
% premier bande
ind = find(f>=fa & f<=fb);
a=ind(1);
b=ind(length(ind));
B1=px(a:b,:); 
% deuxième bande
ind1=find(f>=fb & f<=fc);
c=ind1(1);
d=ind1(length(ind1));
B2=px(c:d,:);
% troisième bande
ind2=find(f>=fc & f<=fd);
e=ind2(1);
g=ind2(length(ind2));
B3=px(e:g,:);

E_total=sum(px.^2,1);
Pb1=sum(B1.^2,1);% puissance total du premier bande
Pb2=sum(B2.^2,1);% puissance total du deuxième bande
Pb3=sum(B3.^2,1);% puissance total du troisième bande

for i=1:8
    EN_band(i,1)=Pb1(1,i)/E_total(1,i);
    EN_band(i,2)=Pb2(1,i)/E_total(1,i);
    EN_band(i,3)=Pb3(1,i)/E_total(1,i);
    
end



end


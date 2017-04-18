function disp = dispersion_band(signal, fband ,fs  )

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
for i=1:8
    Mfreq(i,1)=sum(f(a:b,1).*B1(:,i))/sum(B1(:,i));
    Mfreq(i,2)=sum(f(c:d,1).*B2(:,i))/sum(B2(:,i));
    Mfreq(i,3)=sum(f(e:g,1).*B3(:,i))/sum(B3(:,i));
    disp(i,1)=sqrt((sum(((f(a:b,1)).^2).*B1(:,i))/sum(B1(:,i)))-(Mfreq(i,1))^2);
    disp(i,2)=sqrt((sum(((f(c:d,1)).^2).*B2(:,i))/sum(B2(:,i)))-(Mfreq(i,2))^2);
    disp(i,3)=sqrt((sum(((f(e:g,1)).^2).*B3(:,i))/sum(B3(:,i)))-(Mfreq(i,3))^2);
    
end


end

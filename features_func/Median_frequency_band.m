function fmed=Median_frequency_band(signal,fband,fs)

fmed=zeros(8,3);

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

P1=cumsum(B1);
P2=cumsum(B2);
P3=cumsum(B3);

for i=1:8
    fmed(i,1)=interp1(P1(:,i),f(a:b,1),max(P1(:,i))/2);
    fmed(i,2)=interp1(P2(:,i),f(c:d,1),max(P2(:,i))/2);
    fmed(i,3)=interp1(P3(:,i),f(e:g,1),max(P3(:,i))/2);
end
    
    
    

    

        
        

end


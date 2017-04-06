function F2 = time_power_spectrum_2_band( signal, nb_segment,long_segment,nb_overlap,gamma)

F2=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap, : );
    end
    [~,C]=size(signal_wind);
    
    for ic=1:C
         m0_bar=sqrt(sum(signal_wind(:,ic).^2,1));
         m0=m0_bar/gamma;
         m2_bar=sqrt(sum((diff(signal_wind(:,ic))/5).^2,1));
         m2=m2_bar/gamma;
         f2=log(m0-m2);
         F2(ic,i)=(-2.*f2.*log(f2.^2))/(f2.^2 + log(f2.^2).^2);
    end
end
         





end


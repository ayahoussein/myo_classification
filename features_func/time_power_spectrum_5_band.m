function F5= time_power_spectrum_5_band( signal, nb_segment,long_segment,nb_overlap,gamma)

F5=zeros(8,nb_segment);

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
         m4_bar=sqrt(sum((diff(diff(signal_wind(:,ic)))/25).^2,1));
         m4=m4_bar/gamma;
         f5=m2/sqrt(m0*m4);
         F5(ic,i)=(-2.*f5.*log(f5.^2))/(f5.^2 + log(f5.^2).^2);
    end
end




end


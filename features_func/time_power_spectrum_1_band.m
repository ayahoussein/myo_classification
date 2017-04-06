function  F1 = time_power_spectrum_1_band( signal, nb_segment,long_segment,nb_overlap,gamma)

F1=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap, : );
    end
    [R,C]=size(signal_wind);
    
    for ic=1:C
            m0_bar=sqrt(sum(signal_wind(:,ic).^2,1));
            m0=m0_bar/gamma;
            f1=log(m0);
            F1(ic,i)=(-2.*f1.*log(f1.^2))/(f1.^2 + log(f1.^2).^2);
    end
end
    


end


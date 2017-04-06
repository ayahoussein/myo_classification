function F6= time_power_spectrum_6_band( signal, nb_segment,long_segment,nb_overlap)

F6=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap, : );
    end
    [~,C]=size(signal_wind);
    
    for ic=1:C
        f6=log(sum(abs(diff(signal_wind(:,ic))/5),1)/sum(abs(diff(diff(signal_wind(:,ic)))/25)));
        F6(ic,i)=(-2.*f6.*log(f6.^2))/(f6.^2 + log(f6.^2).^2);
    end
end


end


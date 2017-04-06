function IEMG = integrated_emg_wind( signal,nb_segment,long_segment,nb_overlap )

IEMG=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap, : );
    end
    [~,C]=size(signal_wind);
    for ic=1:C
        IEMG(ic,i)=sum(abs(signal_wind(:,ic)),1);
    end
end
    
    



   
    
end


function WL = waveform_length_wind( signal,nb_segment,long_segment,nb_overlap )

WL=zeros(8,nb_segment);
for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment+nb_overlap,:);
    end
    [R,C]=size(signal_wind);
    
    for ic=1:C
        len=0;
        for jr=1:R-1
            len=len+abs(signal_wind(jr+1,ic)-signal_wind(jr,ic));
        end
        WL(ic,i)=len;
    end
end
    
    
        
       
        
end


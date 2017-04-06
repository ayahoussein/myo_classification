function WA = Wilson_Amplitude_wind(signal,thresh,nb_segment,long_segment,nb_overlap )

WA=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap,:);
    end
    
    [R,C]=size(signal_wind);
    for ic=1:C
        len=0;
        for jr=1:R-1
            
        if (abs(signal_wind(jr,ic)-signal_wind(jr+1,ic))>thresh)
            len=len+abs(signal_wind(jr,ic)-signal_wind(jr+1,ic));
        end
        end
        WA(ic,i)=len;
    end
end
   
    









end


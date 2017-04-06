function ZC = zero_crossing_wind( signal, thresh,nb_segment,long_segment,nb_overlap )


ZC=zeros(8,nb_segment);
    for i=1:nb_segment
        if i==1
            signal_wind=signal(1:long_segment,:);
        else
        signal_wind=signal((i-1)*long_segment - nb_overlap:(i-1)*long_segment+nb_overlap,:);
        end
        [R,C]=size(signal_wind);
        
        for ic=1:C
            count=0;
            for jr=1:R-1
                if (((signal_wind(jr,ic)>0 && signal_wind(jr+1,ic)<0) || (signal_wind(jr,ic)<0 && signal_wind(jr+1,ic)>0))&& abs(signal_wind(jr,ic)-signal_wind(jr+1,ic))> thresh)
            count=count+1;
                end
            end
            ZC(ic,i)=count;
        end 
        clear signal_wind;
    end
            
        
     
     
        



end


function SSC = slope_sign_change_wind( signal,nb_segment,long_segment,nb_overlap )

SSC=zeros(8,nb_segment);
for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else 
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap,:);
        
    end
   
    [R,C]=size(signal_wind);
    slopes=diff(signal_wind);
    for ic=1:C
        count=0;
        for jr=1:R-2
            if ((slopes(jr,ic)>0 && slopes(jr+1,ic)<0)|| ( slopes(jr,ic)<0 && slopes(jr+1,ic)>0))
                count=count+1;
            end
        end
        SSC(ic,i)=count;
    end
end
            
                
                
                
                
                
               
        











end


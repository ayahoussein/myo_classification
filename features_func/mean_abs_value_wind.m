function MAV = mean_abs_value_wind(signal,nb_segment,long_segment,nb_overlap)

MAV=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else 
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap,:);
    end
    
    [~,C]=size(signal);
    for ic=1:C
        MAV(ic,i)=meanabs(signal_wind(:,ic));
    end
end
        
    






   



end


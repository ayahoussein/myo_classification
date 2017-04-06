function VAR = variance_wind( signal ,nb_segment,long_segment,nb_overlap)

VAR=zeros(8,nb_segment);

for i=1:nb_segment
    if i==1
        signal_wind=signal(1:long_segment,:);
    else
        signal_wind=signal((i-1)*long_segment - nb_overlap : (i-1)*long_segment + nb_overlap,:);
    end
    
    [~,C]=size(signal_wind);
    
    for ic=1:C
        VAR(ic,i)=(1/(long_segment-1))*sum(signal_wind(:,ic).^2,1);
    end
end
    
    
    
   

end


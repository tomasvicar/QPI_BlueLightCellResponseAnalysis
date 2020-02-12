

function [out]=addslope(nazevy_treat,s_CC)


for k=1:length(nazevy_treat)
    tmp=s_CC{k};
    out{k}=[nazevy_treat{k} ' k' num2str(tmp(1)) ' q' num2str(tmp(1))];
    
end


end
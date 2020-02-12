function se = nanse(data)

se=nanstd(data,[],2)./nansum(~isnan(data),2);

end


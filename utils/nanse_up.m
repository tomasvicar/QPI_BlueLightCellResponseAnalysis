function se = nanse_up(data)

se=nanmean(data,2)+nanstd(data,[],2)./sqrt(nansum(~isnan(data),2));

end


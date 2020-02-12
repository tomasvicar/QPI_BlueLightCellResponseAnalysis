function se = nanse_bot(data)

se=nanmean(data,2)-nanstd(data,[],2)./sqrt(nansum(~isnan(data),2));

end


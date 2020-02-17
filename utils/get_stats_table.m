function [stat1,stat2,stat3] = get_stats_table(data_cell,names)


dataa=[];
names_vec={};

for k=1:length(data_cell)
    
    
    tmp=data_cell{k};

    
    tmp=tmp(:);
    dataa=[dataa;tmp];
    names_vec=[names_vec ; repmat({names{k}}, length(tmp), 1)];
    
    
    names2{k}=['x' names{k}];
    
    names2{k}=strrep(names2{k},'-','_');
    
    names2{k}=strrep(names2{k},' ','_');
    names2{k}=strrep(names2{k},',','_');
    
    means(k)=mean(tmp);
    stds(k)=std(tmp);
    q1(k)=quantile(tmp,0.25);
    q3(k)=quantile(tmp,0.75);
    med(k)=median(tmp);
    count(k)=numel(tmp);
    
    
    try
        [h,p] = lillietest(tmp);%small -> not normal
    catch
        disp('lili not working')
        p=NaN;
    end
    
    
    lili_norm(k)=p;
    
    

end



[p,t,stats] = anova1(dataa,names_vec,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c1=squareform(c(:,6));


[p,t,stats] =kruskalwallis(dataa,names_vec,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c2=squareform(c(:,6));



names_vec_3class=names_vec;
for k=1:length(names_vec_3class)
    if contains(names_vec_3class{k},names{2})
        names_vec_3class{k}=[names{2} '__' names{3}];
    elseif contains(names_vec_3class{k},names{3})
        names_vec_3class{k}=[names{2} '__' names{3}];
    elseif contains(names_vec_3class{k},names{4})
        names_vec_3class{k}=[names{4} '__' names{5}];
    elseif contains(names_vec_3class{k},names{5})
        names_vec_3class{k}=[names{4} '__' names{5}]; 
    end
end

names22={names2{1},[names2{2} '__' names2{3}],[names2{4} '+' names2{5}]};




[p,t,stats] = anova1(dataa,names_vec_3class,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c3=squareform(c(:,6));


[p,t,stats] =kruskalwallis(dataa,names_vec_3class,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c4=squareform(c(:,6));



cc1=[c1 c2];
cc2=[c3 c4];

blabla1={};
for k=1:size(c1,1)
    blabla1=[blabla1,['anova_' names2{k}]];
end
for k=1:size(c1,1)
    blabla1=[blabla1,['kruskal_' names2{k}]];
end

blabla2={};
for k=1:size(c3,1)
    blabla2=[blabla2,['anovaMj3class' num2str(k)]];
end
for k=1:size(c3,1)
    blabla2=[blabla2,['kruskalMj3class'  num2str(k)]];
end


stat1=array2table(cc1,'RowNames',names2,'VariableNames',blabla1);
stat2=array2table(cc2,'RowNames',names22,'VariableNames',blabla2);


stat3=array2table(med,'RowNames',{'med'},'VariableNames',names2);
stat3=[stat3;array2table(means,'RowNames',{'mean'},'VariableNames',names2)];
stat3=[stat3;array2table(stds,'RowNames',{'std'},'VariableNames',names2)];
stat3=[stat3;array2table(q1,'RowNames',{'q1'},'VariableNames',names2)];
stat3=[stat3;array2table(q3,'RowNames',{'q3'},'VariableNames',names2)];
stat3=[stat3;array2table(count,'RowNames',{'count'},'VariableNames',names2)];
stat3=[stat3;array2table(lili_norm,'RowNames',{'liliNormalitaVelkeJeOk'},'VariableNames',names2)];

drawnow;




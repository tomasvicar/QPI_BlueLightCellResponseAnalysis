function stat=boxplot_cell(data,nazvy,skupiny)

dataa=[];
a1=[];
a2=[];
a3=[];

n1={};
n2={};
n3={};


names={};
for k=1:length(data)
    
    pom=data{k};
    pom=pom(:);
    dataa=[dataa;pom];
    
    names=[names ; repmat({nazvy{k}}, length(pom), 1)];
    
    
    names2{k}=['x' nazvy{k}];
    
    names2{k}=strrep(names2{k},'-','_');
    
    if contains(names2{k},'Rv')
        a1=[a1;pom];
        n1=[n1;repmat({nazvy{k}}, length(pom), 1)];
    end
    if contains(names2{k},'PN')
        a2=[a2;pom];
        n2=[n2;repmat({nazvy{k}}, length(pom), 1)];
    end
    if contains(names2{k},'PC')
        a3=[a3;pom];
        n3=[n3;repmat({nazvy{k}}, length(pom), 1)];
    end
%     
    
    prumer(k)=mean(pom);
    odchylka(k)=std(pom);
    kvartil1(k)=quantile(pom,0.25);
    kvartil3(k)=quantile(pom,0.75);
    medianek(k)=median(pom);
    pocet(k)=numel(pom);
    
    try
        [h,p] = lillietest(pom);%nesmí jit pod 0
    catch
        disp('nejde lili')
        p=NaN;
    end
    
    
    lili_norm(k)=p;
end

% [p,t,stats] = anova1(dataa,names,'off');

% [p,t,stats] =kruskalwallis(dataa,names,'off');
% [c,m,h,nms] = multcompare(stats,'Display','off');




[p,t,stats] = anova1(a1,n1,'off');
% [p,t,stats] =kruskalwallis(a1,n1,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c(:,3:5)=[];
c1=squareform(c(:,3));






[p,t,stats] = anova1(a2,n2,'off');
% [p,t,stats] =kruskalwallis(a2,n2,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c(:,3:5)=[];
c2=squareform(c(:,3));





[p,t,stats] = anova1(a3,n3,'off');
% [p,t,stats] =kruskalwallis(a3,n3,'off');

[c,m,h,nms] = multcompare(stats,'Display','off');
c(:,3:5)=[];
c3=squareform(c(:,3));


cc=[c1 c2 c3];








% [p,t,stats] = anova1(a1,n1,'off');
[p,t,stats] =kruskalwallis(a1,n1,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c(:,3:5)=[];
c1=squareform(c(:,3));






% [p,t,stats] = anova1(a2,n2,'off');
[p,t,stats] =kruskalwallis(a2,n2,'off');
[c,m,h,nms] = multcompare(stats,'Display','off');
c(:,3:5)=[];
c2=squareform(c(:,3));





% [p,t,stats] = anova1(a3,n3,'off');
[p,t,stats] =kruskalwallis(a3,n3,'off');

[c,m,h,nms] = multcompare(stats,'Display','off');
c(:,3:5)=[];
c3=squareform(c(:,3));


ccc=[c1 c2 c3];






if skupiny==4

    blabla1={'con_anova','Zn_anova','cispt_anova','doc_anova'};
    blabla2={'con_kruskal','Zn_kruskal','cispt_kruskal','doc_kruskal'};


    color = {'r','r','r','r','b','b','b','b','g','g','g','g'};
end

if skupiny==3
    blabla1={'con_anova','Zn_anova','treat_anova'};
    blabla2={'con_kruskal','Zn_kruskal','treat_kruskal'};
    

    color = {'r','r','r','g','g','g','b','b','b'};
end


% cc=[1:size(cc,2); cc ];
% cc=[(0:size(cc,1)-1)' cc];

stat=array2table(cc,'RowNames',blabla1,'VariableNames',names2);

stat=[stat;array2table(ccc,'RowNames',blabla2,'VariableNames',names2)];


stat=[stat;array2table(medianek,'RowNames',{'median'},'VariableNames',names2)];
stat=[stat;array2table(prumer,'RowNames',{'prumer'},'VariableNames',names2)];
stat=[stat;array2table(odchylka,'RowNames',{'std'},'VariableNames',names2)];
stat=[stat;array2table(kvartil1,'RowNames',{'kvartil1'},'VariableNames',names2)];
stat=[stat;array2table(kvartil3,'RowNames',{'kvartil3'},'VariableNames',names2)];
stat=[stat;array2table(pocet,'RowNames',{'pocet'},'VariableNames',names2)];
stat=[stat;array2table(lili_norm,'RowNames',{'normalitavelkeok'},'VariableNames',names2)];


% names={'Untreated','Zinc','Cisplatin','Docetaxel'};

h=boxplot(dataa,names,'colors','k');
set(h(7,:),'Visible','off')
hh=h;
% color = {[0.7 0.7 0.7],[0.7 0.7 0.7],[0.7 0.7 0.7],[0.7 0.7 0.7]};



h = findobj(gca,'Tag','Box');
for j=1:length(h)
   patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
end

c = get(gca, 'Children');
set(c(1:length(c)-1), 'FaceAlpha', 0.5);

% h=boxplot(dataa,names,'colors','k');

xtickangle(45)

% hh.XTickLabel=names;
set(gca,'fontsize',13)
% set(h,'linew',2)

% set(findobj(gcf,'Tag','Outliers'),'Symbol','')

% set(h(7,:),'Visible','off')













% 
% function boxplot_special(x,group,fi)
% 
% figure(fi)
% hold on
% % x=[tcon;ttre;lcon;ltre;kcon;ktre;bcon;btre];
% 
% 
% % group=[1*ones(length(tcon),1);2*ones(length(ttre),1);3*ones(length(lcon),1);4*ones(length(ltre),1);5*ones(length(kcon),1);6*ones(length(ktre),1);7*ones(length(bcon),1);8*ones(length(btre),1)];
% 
% % positions = [1:length(unique(group))];
% 
% 
% h=boxplot(x,group,'colors','k');
% set(findobj(gcf,'Tag','Outliers'),'MarkerEdgeColor','k')
% set(h,'linew',2)
% 
% color = {[0.7 0.7 0.7],[0.7 0.7 0.7],[0.7 0.7 0.7],[0.7 0.7 0.7]};
% % color = ['r','g','b','y','m'];
% % color=color(end:-1:1);
% h = findobj(gca,'Tag','Box');
% for j=1:length(h)
%    patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
% end
% 
% c = get(gca, 'Children');
% % set(c(1:length(c)-1), 'FaceAlpha', 0.5);
% 
% h=boxplot(x,group,'colors','k');
% set(h,'linew',2)
% set(findobj(gcf,'Tag','Outliers'),'MarkerEdgeColor','k')
% end






clc;clear all;close all;
addpath('utils')
addpath('plotSpread')



data_folder='../data';

folders=dir(data_folder);
folders={folders(3:end).name};


mkdir('../res/tables');
mkdir('../res/casove');

s_num=0;
for s=folders
    s_num=s_num+1;
    
%     if s_num<2
%        continue 
%     end
    
    listing=dir([data_folder filesep s{1}]);
    
    folders2={listing(3:end).name};
    
    CC={};
    VV={};
    MM={};
    PP={};
    cdss={};
    DD={};
    AA={};
    
    
    CC_box={};
    VV_box={};
    MM_box={};
    PP_box={};
    cdss_box={};
    DD_box={};
    AA_box={};
    
    
    
    
    CC_up={};
    VV_up={};
    MM_up={};
    PP_up={};
    cdss_up={};
    DD_up={};
    AA_up={};
    
    
    CC_bot={};
    VV_bot={};
    MM_bot={};
    PP_bot={};
    cdss_bot={};
    DD_bot={};
    AA_bot={};
    
    s_CC={};
    s_VV={};
    s_MM={};
    s_PP={};
    s_cdss={};
    s_DD={}; 
    s_AA={};
    
    names_treat={};
    
    
    for ss=folders2
        
        listing=subdir([data_folder filesep  s{1} '/' ss{1} '/*features*.mat']);
        
        listing={listing(:).name};
        
        C=[];
        X=[];
        Y=[];
        M=[];
        D=[];
        cds=[];
        P=[];
        A=[];
        poprve=1;
        for sss=listing
            nazev=sss{1};
            load(nazev)
            %             cirkularity(cirkularity==Inf)=nan;
            cirkularity(cirkularity>1)=nan;
            if poprve==0
                size_min=min([size(C,1) size(cirkularity,1)]);
                C=C(1:size_min,:);
                cirkularity=cirkularity(1:size_min,:);
                X=X(1:size_min,:);
                Y=Y(1:size_min,:);
                x=x(1:size_min,:);
                y=y(1:size_min,:);
                M=M(1:size_min,:);
                P=P(1:size_min,:);
                D=D(1:size_min,:);
                A=A(1:size_min,:);
                area=area(1:size_min,:);
                cds=cds(1:size_min,:);
                mass=mass(1:size_min,:);
                density=density(1:size_min,:);
                CDS=CDS(1:size_min,:);
            end
            poprve=0;
            
            area(area==0)=nan;
            
            C=[C cirkularity];
            %             V=[V sqrt(diff(x,[],1).^2+diff(y,[],1).^2)];
            X=[X x];
            Y=[Y y];
            M=[M mass];
            P=[P ~isnan(mass)];
            D=[D density];
            A=[A area];
            cds=[cds CDS];
            
        end
        

        
        
        V=sqrt(diff(X,[],1).^2+diff(Y,[],1).^2)/3/1.6;
        names_treat=[names_treat  [ss{1}]];
        
        
        remove=A<50;
        V(remove(1:end-1,:))=NaN;
        M(remove)=NaN;
        P(remove)=NaN;
        D(remove)=NaN;
        A(remove)=NaN;
        cds(remove)=NaN;
        
        
        
        
        
%         CC=[CC nanmedian(C,2)];
%         VV=[VV nanmedian(V,2)];
%         MM=[MM nanmedian(M,2)];
%         PP=[PP nansum(P,2)];
%         DD=[DD nanmedian(D,2)];
%         AA=[AA nanmedian(A,2)];
%         cdss=[cdss nanmedian(cds,2)];
%         
%         CC_up=[CC_up quantile(C,0.75,2)];
%         VV_up=[VV_up quantile(V,0.75,2)];
%         MM_up=[MM_up quantile(M,0.75,2)];
% %         PP_up=[PP_up nansum(P,2)];
%         DD_up=[DD_up quantile(D,0.75,2)];
%         AA_up=[AA_up quantile(A,0.75,2)];
%         cdss_up=[cdss_up quantile(cds,0.75,2)];
%         
%         CC_bot=[CC_bot quantile(C,0.25,2)];
%         VV_bot=[VV_bot quantile(V,0.25,2)];
%         MM_bot=[MM_bot quantile(M,0.25,2)];
% %         PP_bot=[PP_bot nansum(P,2)];
%         DD_bot=[DD_bot quantile(D,0.25,2)];
%         AA_bot=[AA_bot quantile(A,0.25,2)];
%         cdss_bot=[cdss_bot quantile(cds,0.25,2)];
        
        
        
        
        CC=[CC nanmean(C,2)];
        VV=[VV nanmean(V,2)];
        MM=[MM nanmean(M,2)];
        PP=[PP nansum(P,2)];
        DD=[DD nanmean(D,2)];
        AA=[AA nanmean(A,2)];
        cdss=[cdss nanmean(cds,2)];
        
        CC_up=[CC_up nanse_up(C)];
        VV_up=[VV_up nanse_up(V)];
        MM_up=[MM_up nanse_up(M)];
%         PP_up=[PP_up nansum(P,2)];
        DD_up=[DD_up nanse_up(D)];
        AA_up=[AA_up nanse_up(A)];
        cdss_up=[cdss_up nanse_up(cds)];
        
        CC_bot=[CC_bot nanse_bot(C)];
        VV_bot=[VV_bot nanse_bot(V)];
        MM_bot=[MM_bot nanse_bot(M)];
%         PP_bot=[PP_bot nansum(P,2)];
        DD_bot=[DD_bot nanse_bot(D)];
        AA_bot=[AA_bot nanse_bot(A)];
        cdss_bot=[cdss_bot nanse_bot(cds)];       
        
        
        y=C(end-5,:);
        y=y(~isnan(y));
        CC_box=[CC_box y];
        y=V(end-5,:);
        y=y(~isnan(y));
        VV_box=[VV_box y];
        y=M(end-5,:);
        y=y(~isnan(y));
        MM_box=[MM_box y];
%         PP_bot=[PP_bot nansum(P,2)];
        y=D(end-5,:);
        y=y(~isnan(y));
        DD_box=[DD_box y];
        y=A(end-5,:);
        y=y(~isnan(y));
        AA_box=[AA_box y];
        y=cds(end-5,:);
        y=y(~isnan(y));
        cdss_box=[cdss_box y];    
        
        
        
        
        
        

    end
    
    
    if s_num==1
    
    C_max=max(cat(1,CC_up{:}));
%     C_max=1.05;
    V_max=0.4;%max(cat(1,VV_up{:}));
%     V_max=0.6;
    M_max=max(cat(1,MM_up{:}));
%     M_max=700;
    P_max=2;%max(cat(1,PP{:}));
%     P_max=1000;
    D_max=max(cat(1,DD_up{:}));
%     D_max=1.5;
    A_max=max(cat(1,AA_up{:}));
%     A_max=900;
    cds_max=max(cat(1,cdss_up{:}));
%     cds_max=0.04;
    
    
    
%     C_max2=max(cat(1,CC_up{:}));
    C_max2=1.05;
%     V_max2=max(cat(1,VV_up{:}));
    V_max2=1;
%     M_max2=max(cat(1,MM_up{:}));
    M_max2=1000;
    P_max2=max(cat(1,PP{:}));
%     P_max2=1000;
%     D_max2=max(cat(1,DD_up{:}));
    D_max2=1.6;
%     A_max2=max(cat(1,AA_up{:}));
    A_max2=1200;
%     cds_max=max(cat(1,cdss_up{:}));
    cds_max2=0.06;
    
    end
    
    
    
    if s_num==2
    
    C_max=max(cat(1,CC_up{:}));
%     C_max=1.05;
    V_max=max(cat(1,VV_up{:}));
%     V_max=0.6;
    M_max=max(cat(1,MM_up{:}));
%     M_max=700;
    P_max=2;%max(cat(1,PP{:}));
%     P_max=1000;
    D_max=max(cat(1,DD_up{:}));
%     D_max=1.5;
    A_max=max(cat(1,AA_up{:}));
%     A_max=900;
    cds_max=max(cat(1,cdss_up{:}));
%     cds_max=0.04;
    
    
    
%     C_max2=max(cat(1,CC_up{:}));
    C_max2=1.05;
%     V_max2=max(cat(1,VV_up{:}));
    V_max2=1.2;
%     M_max2=max(cat(1,MM_up{:}));
    M_max2=1800;
    P_max2=max(cat(1,PP{:}));
%     P_max2=1000;
%     D_max2=max(cat(1,DD_up{:}));
    D_max2=1.8;
%     A_max2=max(cat(1,AA_up{:}));
    A_max2=2200;
%     cds_max=max(cat(1,cdss_up{:}));
    cds_max2=0.06;
    
    end
    
    
    
        if s_num==3
    
    C_max=max(cat(1,CC_up{:}));
%     C_max=1.05;
    V_max=0.9;
%     V_max=0.6;
    M_max=max(cat(1,MM_up{:}));
%     M_max=700;
    P_max=2;%max(cat(1,PP{:}));
%     P_max=1000;
    D_max=max(cat(1,DD_up{:}));
%     D_max=1.5;
    A_max=max(cat(1,AA_up{:}));
%     A_max=900;
    cds_max=0.025;
%     cds_max=0.04;
    
    
    
%     C_max2=max(cat(1,CC_up{:}));
    C_max2=1.05;
%     V_max2=max(cat(1,VV_up{:}));
    V_max2=1.8;
%     M_max2=max(cat(1,MM_up{:}));
    M_max2=2000;
    P_max2=max(cat(1,PP{:}));
%     P_max2=1000;
%     D_max2=max(cat(1,DD_up{:}));
    D_max2=2;
%     A_max2=max(cat(1,AA_up{:}));
    A_max2=3000;
%     cds_max=max(cat(1,cdss_up{:}));
    cds_max2=0.06;
    
    end
    
        if s_num==4
    
    C_max=max(cat(1,CC_up{:}));
%     C_max=1.05;
    V_max=0.3;
%     V_max=0.6;
    M_max=max(cat(1,MM_up{:}));
%     M_max=700;
    P_max=2.5;%max(cat(1,PP{:}));
%     P_max=1000;
    D_max=max(cat(1,DD_up{:}));
%     D_max=1.5;
    A_max=max(cat(1,AA_up{:}));
%     A_max=900;
    cds_max=0.01;
%     cds_max=0.04;
    
    
    
%     C_max2=max(cat(1,CC_up{:}));
    C_max2=1.05;
%     V_max2=max(cat(1,VV_up{:}));
    V_max2=0.8;
%     M_max2=max(cat(1,MM_up{:}));
    M_max2=800;
    P_max2=max(cat(1,PP{:}));
%     P_max2=1000;
%     D_max2=max(cat(1,DD_up{:}));
    D_max2=1.2;
%     A_max2=max(cat(1,AA_up{:}));
    A_max2=1600;
%     cds_max=max(cat(1,cdss_up{:}));
    cds_max2=0.015;
    
    end
    
    
    
    
%     color_0mj=[0,0,0];
    color_0mj=[105,105,105];
%     color_0mj=[255,217,25];
    color_30mj_500ms=[74, 246, 0];
    color_30mj_1000ms=[158, 183, 108];
%     color_300mj_500ms=[95, 0, 54];
    color_300mj_500ms=[220,20,60];
%     color_300mj_1000ms=[157, 92, 129];
%     color_300mj_1000ms=[250,128,114];
    color_300mj_1000ms=[255,160,122];
    
    lw=1;
    
    
    close all
    figure(1);
    hold on
    figure(2);
    hold on
    figure(3);
    hold on
    figure(4);
    hold on
    figure(5);
    hold on
    figure(6);
    hold on
    figure(7);
    hold on
    colors={};
    for k=1:length(names_treat)
        namess_treat=names_treat;
        if contains(namess_treat{k},'30mj')&&contains(namess_treat{k},'500ms')
            color=color_30mj_500ms;
        elseif contains(namess_treat{k},'30mj')&&contains(namess_treat{k},'1000ms')
            color=color_30mj_1000ms;
        elseif contains(namess_treat{k},'300mj')&&contains(namess_treat{k},'500ms')
            color=color_300mj_500ms;
        elseif contains(namess_treat{k},'300mj')&&contains(namess_treat{k},'1000ms')
            color=color_300mj_1000ms;
        elseif strcmp(namess_treat{k},'0mj')
            color=color_0mj;
        else
            error('nocolor')
        end
        
        colors=[colors,color/255];
        
        mask_size=11;
        med_size=9;
        
        
        
        figure(1);
        x=(1:length(CC{k}))/20;
        y=CC{k};
        y_up=CC_up{k};
        y_bot=CC_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
        alpha(p,.2) 
        set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        coeffs = polyfit((1:length(CC{k}))/20,CC{k}', 1);
        s_CC{k}=coeffs;
        
        
        figure(2);
%         plot((1:length(VV{k}))/20,VV{k}/3/1.6)
        x=(1:length(VV{k}))/20;
        y=VV{k};
        y_up=VV_up{k};
        y_bot=VV_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
        alpha(p,.2) 
        set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        coeffs = polyfit((1:length(VV{k}))/20,VV{k}', 1);
        s_VV{k}=coeffs;
        
        
        figure(3);
%         plot((1:length(MM{k}))/20,MM{k})
        x=(1:length(MM{k}))/20;
        y=MM{k};
        y_up=MM_up{k};
        y_bot=MM_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
        alpha(p,.2) 
        set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        coeffs = polyfit((1:length(MM{k}))/20,MM{k}', 1);
        s_MM{k}=coeffs;
        
         
         figure(4);
%         plot((1:length(DD{k}))/20,PP{k})
        x=(1:length(PP{k}))/20;
        y=PP{k};
%         y_up=PP_up{k};
%         y_bot=PP_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y=y/y(1);
%         y_up=medfilt1(y_up,med_size);
%         y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
%         y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
%         y_bot=medfilt1(y_bot,med_size);
%         y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
%         y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');

        

        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
%         p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
%         alpha(p,.2) 
%         set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        coeffs = polyfit((1:length(PP{k}))/20,PP{k}', 1);
        s_PP{k}=coeffs;
        
        
        
        
        
        figure(5);
         x=(1:length(DD{k}))/20;
        y=DD{k};
        y_up=DD_up{k};
        y_bot=DD_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
        alpha(p,.2) 
        set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        s_DD{k}=coeffs;
        
        
        
       
        
        
        figure(6);
%         plot((1:length(cdss{k}))/20,cdss{k})
        x=(1:length(cdss{k}))/20;
        y=cdss{k};
        y_up=cdss_up{k};
        y_bot=cdss_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
        alpha(p,.2) 
        set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        coeffs = polyfit((1:length(cdss{k}))/20,cdss{k}', 1);
        s_cdss{k}=coeffs;
        
        figure(7);
%         plot((1:length(AA{k}))/20,AA{k})
        x=(1:length(AA{k}))/20;
        y=AA{k};
        y_up=AA_up{k};
        y_bot=AA_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'symmetric','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'symmetric','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'symmetric','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'Color',color/255,'LineWidth' ,lw)
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]',color/255,'EdgeColor','none');
        alpha(p,.2) 
        set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        coeffs = polyfit((1:length(AA{k}))/20,AA{k}', 1);
        s_AA{k}=coeffs;
        
        

        
    end
    
    
        
    ss=split(s{1},'/');
    ss=ss{end};
    
    
    order=[];
    namess_treat=names_treat;
    for k=1:length(namess_treat)
        if contains(namess_treat{k},'30mj')&&contains(namess_treat{k},'500ms')
            order=[order,2];
        elseif contains(namess_treat{k},'30mj')&&contains(namess_treat{k},'1000ms')
            order=[order,3];
        elseif contains(namess_treat{k},'300mj')&&contains(namess_treat{k},'500ms')
            order=[order,4];
        elseif contains(namess_treat{k},'300mj')&&contains(namess_treat{k},'1000ms')
            order=[order,5];
        elseif strcmp(namess_treat{k},'0mj')
            order=[order,1];
        else
            error('noname')
        end
    end
    
    order(order)=1:5;
    colors_order=colors(order);
    namess_treat_order=namess_treat(order);
    
    
    
    figure(11)
    hold on
    yy=CC_box(order);
    y=[yy{:}];
    g=[];
    for k=1:length(yy)
        g=[g,repmat(k,[1,length(yy{k})])];
    end
    pozice=1:5;
    names=namess_treat_order; 
    plotSpread(yy,'xNames', names,'distributionColors',colors_order);
    color=colors_order(end:-1:1);
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
       patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
    end 
    c = get(gca, 'Children');
    for i=1:length(c)
        try
            set(c(i), 'FaceAlpha', 0.5);
        end
    end
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    xtickangle(-30)
    ylim([0 C_max2])
    ylabel('Circurarity')
    print_png_eps_svg(['../res/casove/' ss '_c_box'])
    
    [stat1,stat2,stat3] = get_stats_table(yy,names);
    writetable(stat1,['../res/tables/' ss '_c_p_5class.xlsx'],'WriteRowNames',true)
%     writetable(stat2,['../res/tables/' ss '_c_p_3class.xlsx'])
    writetable(stat3,['../res/tables/' ss '_c_descriptive.xlsx'],'WriteRowNames',true)
    
    
    figure(12)
    hold on
    yy=VV_box(order);
    y=[yy{:}];
    g=[];
    for k=1:length(yy)
        g=[g,repmat(k,[1,length(yy{k})])];
    end
    pozice=1:5;
    names=namess_treat_order; 
    plotSpread(yy,'xNames', names,'distributionColors',colors_order);
    color=colors_order(end:-1:1);
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
       patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
    end 
    c = get(gca, 'Children');
    for i=1:length(c)
        try
            set(c(i), 'FaceAlpha', 0.5);
        end
    end
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    xtickangle(-30)
    ylim([0 V_max2])
    ylabel('Cell speed (\mum/min)')
    print_png_eps_svg(['../res/casove/' ss '_v_box'])
    
    [stat1,stat2,stat3] = get_stats_table(yy,names);
    writetable(stat1,['../res/tables/' ss '_v_p_5class.xlsx'],'WriteRowNames',true)
%     writetable(stat2,['../res/tables/' ss '_v_p_3class.xlsx'])
    writetable(stat3,['../res/tables/' ss '_v_descriptive.xlsx'],'WriteRowNames',true)
    
    
    
    figure(13)
    hold on
    yy=MM_box(order);
    y=[yy{:}];
    g=[];
    for k=1:length(yy)
        g=[g,repmat(k,[1,length(yy{k})])];
    end
    pozice=1:5;
    names=namess_treat_order; 
    plotSpread(yy,'xNames', names,'distributionColors',colors_order);
    color=colors_order(end:-1:1);
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
       patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
    end 
    c = get(gca, 'Children');
    for i=1:length(c)
        try
            set(c(i), 'FaceAlpha', 0.5);
        end
    end
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    xtickangle(-30)
    ylim([0 M_max2])
    ylabel('Cell dry mass (pg)')
    print_png_eps_svg(['../res/casove/' ss '_m_box'])
    
    [stat1,stat2,stat3] = get_stats_table(yy,names);
    writetable(stat1,['../res/tables/' ss '_m_p_5class.xlsx'],'WriteRowNames',true)
%     writetable(stat2,['../res/tables/' ss '_m_p_3class.xlsx'])
    writetable(stat3,['../res/tables/' ss '_m_descriptive.xlsx'],'WriteRowNames',true)
    
    figure(15)
    hold on
    yy=DD_box(order);
    y=[yy{:}];
    g=[];
    for k=1:length(yy)
        g=[g,repmat(k,[1,length(yy{k})])];
    end
    pozice=1:5;
    names=namess_treat_order; 
    plotSpread(yy,'xNames', names,'distributionColors',colors_order);
    color=colors_order(end:-1:1);
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
       patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
    end 
    c = get(gca, 'Children');
    for i=1:length(c)
        try
            set(c(i), 'FaceAlpha', 0.5);
        end
    end
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    xtickangle(-30)
    ylim([0 D_max2])
    ylabel('Density (pg/\mum^2)')
    print_png_eps_svg(['../res/casove/' ss '_d_box'])
    
    [stat1,stat2,stat3] = get_stats_table(yy,names);
    writetable(stat1,['../res/tables/' ss '_d_p_5class.xlsx'],'WriteRowNames',true)
%     writetable(stat2,['../res/tables/' ss '_d_p_3class.xlsx'])
    writetable(stat3,['../res/tables/' ss '_d_descriptive.xlsx'],'WriteRowNames',true)
    
    
    figure(16)
    hold on
    yy=cdss_box(order);
    y=[yy{:}];
    g=[];
    for k=1:length(yy)
        g=[g,repmat(k,[1,length(yy{k})])];
    end
    pozice=1:5;
    names=namess_treat_order; 
    plotSpread(yy,'xNames', names,'distributionColors',colors_order);
    color=colors_order(end:-1:1);
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
       patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
    end 
    c = get(gca, 'Children');
    for i=1:length(c)
        try
            set(c(i), 'FaceAlpha', 0.5);
        end
    end
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    xtickangle(-30)
    ylim([0 cds_max2])
    ylabel('CDS')
    print_png_eps_svg(['../res/casove/' ss '_cds_box'])
    
    [stat1,stat2,stat3] = get_stats_table(yy,names);
    writetable(stat1,['../res/tables/' ss '_cds_p_5class.xlsx'],'WriteRowNames',true)
%     writetable(stat2,['../res/tables/' ss '_cds_p_3class.xlsx'])
    writetable(stat3,['../res/tables/' ss '_cds_descriptive.xlsx'],'WriteRowNames',true)
    
    
    figure(17)
    hold on
    yy=AA_box(order);
    y=[yy{:}];
    g=[];
    for k=1:length(yy)
        g=[g,repmat(k,[1,length(yy{k})])];
    end
    pozice=1:5;
    names=namess_treat_order; 
    plotSpread(yy,'xNames', names,'distributionColors',colors_order);
    color=colors_order(end:-1:1);
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
       patch(get(h(j),'XData'),get(h(j),'YData'),color{j});
    end 
    c = get(gca, 'Children');
    for i=1:length(c)
        try
            set(c(i), 'FaceAlpha', 0.5);
        end
    end
    h=boxplot(y,g,'positions', pozice, 'labels', names,'colors','k','symbol',''); 
    xtickangle(-30)
    ylim([0 A_max2])
    ylabel('Area (\mum^2)')
    print_png_eps_svg(['../res/casove/' ss '_A_box'])
   
    [stat1,stat2,stat3] = get_stats_table(yy,names);
    writetable(stat1,['../res/tables/' ss '_A_p_5class.xlsx'],'WriteRowNames',true)
%     writetable(stat2,['../res/t0ables/' ss '_A_p_3class.xlsx'])
    writetable(stat3,['../res/tables/' ss '_A_descriptive.xlsx'],'WriteRowNames',true)
    
    

    
    names_treat=cellfun(@(x) strrep(x,'_','-'),names_treat,'UniformOutput',false);
    
    
    figure(1);
%     title('cirkularity')
    names_treat_tmp=addslope(names_treat,s_CC);
    legend(names_treat_tmp,'Location','northoutside')
    ylim([0.3 C_max])
    ylabel('Circurarity')
    xlabel('t (h)')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    print_png_eps_svg(['../res/casove/' ss '_c'])
    figure(2);
%     title('rychlost')
    names_treat_tmp=addslope(names_treat,s_VV);
    legend(names_treat_tmp,'Location','northoutside')
    ylim([0 V_max])
    ylabel('Cell speed (\mum/min)')
    xlabel('t (h)')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    print_png_eps_svg(['../res/casove/' ss '_vv'])
    figure(3);
%     title('mass')
    names_treat_tmp=addslope(names_treat,s_MM);
    legend(names_treat_tmp,'Location','northoutside')
    ylim([0 M_max])
    ylabel('Cell dry mass (pg)')
    xlabel('t (h)')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    print_png_eps_svg(['../res/casove/' ss '_m'])
    
    
    figure(4);
% %     title('pocet')
    names_treat_tmp=addslope(names_treat,s_PP);
    legend(names_treat_tmp,'Location','northoutside')
    xlabel('t (h)')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    ylim([0 P_max])
    ylabel('Relative number of cells')
    print_png_eps_svg(['../res/casove/' ss '_p'])
    
    
    
    figure(5);
%     title('hustota')
    names_treat_tmp=addslope(names_treat,s_DD);
    legend(names_treat_tmp,'Location','northoutside')
    ylim([0 D_max])
    ylabel('Density (pg/\mum^2)')
    xlabel('t (h)')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    print_png_eps_svg(['../res/casove/' ss '_d'])
    figure(6);
%     title('cds')
    names_treat_tmp=addslope(names_treat,s_cdss);
    legend(names_treat_tmp,'Location','northoutside')
    ylim([0 cds_max])
    xlabel('t (h)')
    ylabel('CDS')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    print_png_eps_svg(['../res/casove/' ss '_cds'])
    figure(7);
%     title('area')
    names_treat_tmp=addslope(names_treat,s_AA);
    legend(names_treat_tmp,'Location','northoutside')
    ylim([0 A_max])
    xlabel('t (h)')
    ylabel('Area (\mum^2)')
    xticks([0,6,12,18,24]);
    xlim([0,24]);
    print_png_eps_svg(['../res/casove/' ss '_a'])
    
    
    close all
end





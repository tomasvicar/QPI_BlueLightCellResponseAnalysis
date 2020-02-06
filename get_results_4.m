clc;clear all;close all;

addpath('utils')

slozky={'../Data na bakalarku/A2780','../Data na bakalarku/G361','../Data na bakalarku/PC-3','../Data na bakalarku/PNT1A'};

% CCC={};
% VVV={};
% MMM={};
% PPP={};
% cdsss={};
% DDD={};
% nazevy_line={};


for s=slozky
    
    
    listing=dir(s{1});
    
    slozky2={listing(3:end).name};
    
    CC={};
    VV={};
    MM={};
    PP={};
    cdss={};
    DD={};
    AA={};
    
    
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
    
    nazevy_treat={};
    
    
    for ss=slozky2
        
        listing=subdir([s{1} '/' ss{1} '/*parametry08*.mat']);
        
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
            %             cirkularita(cirkularita==Inf)=nan;
            cirkularita(cirkularita>1)=nan;
            if poprve==0
                velikost_min=min([size(C,1) size(cirkularita,1)]);
                C=C(1:velikost_min,:);
                cirkularita=cirkularita(1:velikost_min,:);
                X=X(1:velikost_min,:);
                Y=Y(1:velikost_min,:);
                x=x(1:velikost_min,:);
                y=y(1:velikost_min,:);
                M=M(1:velikost_min,:);
                P=P(1:velikost_min,:);
                D=D(1:velikost_min,:);
                A=A(1:velikost_min,:);
                plocha=plocha(1:velikost_min,:);
                cds=cds(1:velikost_min,:);
                hmota=hmota(1:velikost_min,:);
                densita=densita(1:velikost_min,:);
                CDS=CDS(1:velikost_min,:);
            end
            poprve=0;
            
            plocha(plocha==0)=nan;
            
            C=[C cirkularita];
            %             V=[V sqrt(diff(x,[],1).^2+diff(y,[],1).^2)];
            X=[X x];
            Y=[Y y];
            M=[M hmota];
            P=[P ~isnan(hmota)];
            D=[D densita];
            A=[A plocha];
            cds=[cds CDS];
            
        end
        
        %         plot(nanmean(C,2));
        % %         hold on;
        %         plot(nanmean(V,2));
        %         plot(nanmean(M,2));
        
%         if strcmp(s{1},'Imunitni system')
%             pom=M(~isnan(M));
%             prah = prctile(pom(:),50);
%             znanovat=(M<prah)|(isnan(M));
%             C(znanovat)=nan;
%             X(znanovat)=nan;
%             Y(znanovat)=nan;
%             P(znanovat)=nan;
%             M(znanovat)=nan;
%         end
        
        
        V=sqrt(diff(X,[],1).^2+diff(Y,[],1).^2);
        nazevy_treat=[nazevy_treat  [ss{1}]];
        
        CC=[CC nanmedian(C,2)];
        VV=[VV nanmedian(V,2)];
        MM=[MM nanmedian(M,2)];
        PP=[PP nansum(P,2)];
        DD=[DD nanmedian(D,2)];
        AA=[AA nanmedian(A,2)];
        cdss=[cdss nanmedian(cds,2)];
        
        CC_up=[CC_up quantile(C,0.75,2)];
        VV_up=[VV_up quantile(V,0.75,2)];
        MM_up=[MM_up quantile(M,0.75,2)];
%         PP_up=[PP_up nansum(P,2)];
        DD_up=[DD_up quantile(D,0.75,2)];
        AA_up=[AA_up quantile(A,0.75,2)];
        cdss_up=[cdss_up quantile(cds,0.75,2)];
        
        CC_bot=[CC_bot quantile(C,0.25,2)];
        VV_bot=[VV_bot quantile(V,0.25,2)];
        MM_bot=[MM_bot quantile(M,0.25,2)];
%         PP_bot=[PP_bot nansum(P,2)];
        DD_bot=[DD_bot quantile(D,0.25,2)];
        AA_bot=[AA_bot quantile(A,0.25,2)];
        cdss_bot=[cdss_bot quantile(cds,0.25,2)];
        
        
        
%         pom=C(20:150,:);
%         CCC=[CCC nanmean(pom(:))];
%         pom=V(20:150,:);
%         VVV=[VVV nanmean(pom(:))];
%         pom=M(20:150,:);
%         MMM=[MMM nanmean(pom(:))];
%         nazevy_line=[nazevy_line  [ss{1}]];
        
        
        
        
        
    end
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
    for k=1:length(nazevy_treat)
        mask_size=9;
        med_size=7;
        
        figure(1);
        x=(1:length(CC{k}))/20;
        y=CC{k};
        y_up=CC_up{k};
        y_bot=CC_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'replicate','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'replicate','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'replicate','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'r')
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]','r','EdgeColor','none');
        alpha(p,.2) 
        coeffs = polyfit((1:length(CC{k}))/20,CC{k}', 1);
        s_CC{k}=coeffs;
        
        
        figure(2);
%         plot((1:length(VV{k}))/20,VV{k}/3/1.6)
        x=(1:length(VV{k}))/20;
        y=VV{k};
        y_up=VV_up{k};
        y_bot=VV_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'replicate','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'replicate','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'replicate','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'r')
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]','r','EdgeColor','none');
        alpha(p,.2) 
        coeffs = polyfit((1:length(VV{k}))/20,VV{k}', 1);
        s_VV{k}=coeffs;
        
        
        figure(3);
%         plot((1:length(MM{k}))/20,MM{k})
        x=(1:length(MM{k}))/20;
        y=MM{k};
        y_up=MM_up{k};
        y_bot=MM_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'replicate','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'replicate','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'replicate','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'r')
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]','r','EdgeColor','none');
        alpha(p,.2) 
        coeffs = polyfit((1:length(MM{k}))/20,MM{k}', 1);
        s_MM{k}=coeffs;
        
%         
%         figure(4);
%         plot((1:length(PP{k}))/20,PP{k})
%         coeffs = polyfit((1:length(PP{k}))/20,PP{k}', 1);
%         s_PP{k}=coeffs;
        
        
        
        figure(5);
%         plot((1:length(DD{k}))/20,DD{k})
        x=(1:length(DD{k}))/20;
        y=DD{k};
        y_up=DD_up{k};
        y_bot=DD_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'replicate','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'replicate','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'replicate','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'r')
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]','r','EdgeColor','none');
        alpha(p,.2) 
        coeffs = polyfit((1:length(DD{k}))/20,DD{k}', 1);
        s_DD{k}=coeffs;
        
        
        figure(6);
%         plot((1:length(cdss{k}))/20,cdss{k})
        x=(1:length(cdss{k}))/20;
        y=cdss{k};
        y_up=cdss_up{k};
        y_bot=cdss_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'replicate','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'replicate','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'replicate','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'r')
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]','r','EdgeColor','none');
        alpha(p,.2) 
        coeffs = polyfit((1:length(cdss{k}))/20,cdss{k}', 1);
        s_cdss{k}=coeffs;
        
        figure(7);
%         plot((1:length(AA{k}))/20,AA{k})
        x=(1:length(AA{k}))/20;
        y=AA{k};
        y_up=AA_up{k};
        y_bot=AA_bot{k};
        y=medfilt1(y,med_size);
        y=padarray(y,[floor(mask_size/2) 0],'replicate','both');
        y=conv(y,ones(mask_size,1)/mask_size,'valid');
        y_up=medfilt1(y_up,med_size);
        y_up=padarray(y_up,[floor(mask_size/2) 0],'replicate','both');
        y_up=conv(y_up,ones(mask_size,1)/mask_size,'valid');
        y_bot=medfilt1(y_bot,med_size);
        y_bot=padarray(y_bot,[floor(mask_size/2) 0],'replicate','both');
        y_bot=conv(y_bot,ones(mask_size,1)/mask_size,'valid');
        plot(x,y,'r')
        hold on
        p = fill([x x(end:-1:1)],[y_bot;y_up(end:-1:1)]','r','EdgeColor','none');
        alpha(p,.2) 
        coeffs = polyfit((1:length(AA{k}))/20,AA{k}', 1);
        s_AA{k}=coeffs;
        
        
    end
    
    ss=split(s{1},'/');
    ss=ss{end};
    
    nazevy_treat=cellfun(@(x) strrep(x,'_','-'),nazevy_treat,'UniformOutput',false);
    
    
    figure(1);
%     title('cirkularita')
    nazevy_treat_tmp=addslope(nazevy_treat,s_CC);
    legend(nazevy_treat_tmp,'Location','northoutside')
    ylabel('Circurarity')
    xlabel('t (h)')
    
%     ax=gca;
    
    print_png_eps_svg(['../vys/casove/' ss '_c'])
    figure(2);
%     title('rychlost')
    nazevy_treat_tmp=addslope(nazevy_treat,s_VV);
    legend(nazevy_treat_tmp,'Location','northoutside')
    ylabel('Velocity (\mum/min)')
    xlabel('t (h)')
    print_png_eps_svg(['../vys/casove/' ss '_v'])
    figure(3);
%     title('hmota')
    nazevy_treat_tmp=addslope(nazevy_treat,s_MM);
    legend(nazevy_treat_tmp,'Location','northoutside')
    ylabel('Mass (pg)')
    xlabel('t (h)')
    print_png_eps_svg(['../vys/casove/' ss '_m'])
    figure(4);
%     title('pocet')
    nazevy_treat_tmp=addslope(nazevy_treat,s_PP);
    legend(nazevy_treat_tmp,'Location','northoutside')
    xlabel('t (h)')
    ylabel('Number of cells')
    print_png_eps_svg(['../vys/casove/' ss '_p'])
    figure(5);
%     title('hustota')
    nazevy_treat_tmp=addslope(nazevy_treat,s_DD);
    legend(nazevy_treat_tmp,'Location','northoutside')
    ylabel('Density (pg/\mum^2)')
    xlabel('t (h)')
    print_png_eps_svg(['../vys/casove/' ss '_h'])
    figure(6);
%     title('cds')
    nazevy_treat_tmp=addslope(nazevy_treat,s_cdss);
    legend(nazevy_treat_tmp,'Location','northoutside')
    xlabel('t (h)')
    ylabel('CDS')
    print_png_eps_svg(['../vys/casove/' ss '_cds'])
    figure(7);
%     title('plocha')
    nazevy_treat_tmp=addslope(nazevy_treat,s_AA);
    legend(nazevy_treat_tmp,'Location','northoutside')
    xlabel('t (h)')
    ylabel('Area (\mumm^2)')
    print_png_eps_svg(['../vys/casove/' ss '_a'])
    
end




% m=mean(data_treat,1);
% s=std(data_treat,1);
% plot(x,m,'r')
% hold on
% p = fill([x x(end:-1:1)],[m-s,m(end:-1:1)+s(end:-1:1)]','r','EdgeColor','none');
% alpha(p,.2) 
% title(['control-blue   ' uu{1} ' - ' num2str(acc) '--real'  num2str(size(data_treat_num,1)) 'p/'  num2str(size(data_kontrol_num,1)) 'k  --estimated' num2str(sum(elabel)) '/' num2str(size(data_kontrol_num,1)+size(data_treat_num,1)-sum(elabel)) '--correct' num2str(sum((elabel==train_lbl)&train_lbl)) '/' num2str(sum((elabel==train_lbl)&(~train_lbl))) ])
% ylim([0 y_lim])



function [out]=addslope(nazevy_treat,s_CC)


for k=1:length(nazevy_treat)
    tmp=s_CC{k};
    out{k}=[nazevy_treat{k} ' k' num2str(tmp(1)) ' q' num2str(tmp(1))];
    
end


end


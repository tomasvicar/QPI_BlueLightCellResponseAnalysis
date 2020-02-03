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
        CC=[CC nanmean(C,2)];
        VV=[VV nanmean(V,2)];
        MM=[MM nanmean(M,2)];
        PP=[PP nansum(P,2)];
        DD=[DD nanmean(D,2)];
        AA=[AA nanmean(A,2)];
        cdss=[cdss nanmean(cds,2)];
        nazevy_treat=[nazevy_treat  [ss{1}]];
        
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
        figure(1);
        plot((1:length(CC{k}))/20,CC{k}) 
        coeffs = polyfit((1:length(CC{k}))/20,CC{k}', 1);
        s_CC{k}=coeffs;
        figure(2);
        plot((1:length(VV{k}))/20,VV{k}/3/1.6)
        coeffs = polyfit((1:length(VV{k}))/20,VV{k}', 1);
        s_VV{k}=coeffs;
        figure(3);
        plot((1:length(MM{k}))/20,MM{k})
         coeffs = polyfit((1:length(MM{k}))/20,MM{k}', 1);
        s_MM{k}=coeffs;
        figure(4);
        plot((1:length(PP{k}))/20,PP{k})
         coeffs = polyfit((1:length(PP{k}))/20,PP{k}', 1);
        s_PP{k}=coeffs;
        figure(5);
        plot((1:length(DD{k}))/20,DD{k})
         coeffs = polyfit((1:length(DD{k}))/20,DD{k}', 1);
        s_DD{k}=coeffs;
        figure(6);
        plot((1:length(cdss{k}))/20,cdss{k})
         coeffs = polyfit((1:length(cdss{k}))/20,cdss{k}', 1);
        s_cdss{k}=coeffs;
        
        figure(7);
        plot((1:length(AA{k}))/20,AA{k})
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

% close all
% figure(1);
% hold on
% figure(2);
% hold on
% figure(3);
% hold on
% figure(4);
% hold on
% for k=1:length(nazevy_line)
%     figure(1)
%     plot(CCC{k},VVV{k},'*')
%     text(CCC{k},VVV{k},nazevy_line{k})
%     figure(2)
%     plot(MMM{k},VVV{k},'*')
%     text(MMM{k},VVV{k},nazevy_line{k})
%     figure(3)
%     plot(MMM{k},CCC{k},'*')
%     text(MMM{k},CCC{k},nazevy_line{k})
%     
% end
% 
% 
% figure(1);
% xlabel('cirkularita')
% ylabel('rychlost')
% print(['../vys/vahovane_prumery/' 'frame_20az150_cv'],'-dpng')
% figure(2);
% xlabel('hmotnost')
% ylabel('rychlost')
% print(['../vys/vahovane_prumery/' 'frame_20az150_mv'],'-dpng')
% figure(3);
% xlabel('hmotnost')
% ylabel('cirkularita')
% print(['../vys/vahovane_prumery/' 'frame_20az150_mc'],'-dpng')
% 
% 
% slozky={'A2780_','IS_','PC3_','PNT1A_'};
% 
% for s=slozky
%     close all
%     figure(1);
%     hold on
%     figure(2);
%     hold on
%     figure(3);
%     hold on
%     figure(4);
%     hold on
%     vektor=find(cellfun(@(x) contains(x,s{1}),nazevy_line));
%     for k=vektor
%         figure(1)
%         plot(CCC{k},VVV{k},'*')
%         text(CCC{k},VVV{k},nazevy_line{k})
%         figure(2)
%         plot(MMM{k},VVV{k},'*')
%         text(MMM{k},VVV{k},nazevy_line{k})
%         figure(3)
%         plot(MMM{k},CCC{k},'*')
%         text(MMM{k},CCC{k},nazevy_line{k})
%         
%     end
%     ss=split(s{1},'/');
%     ss=ss{end};
%     
%     figure(1);
%     xlabel('cirkularita')
%     ylabel('rychlost')
%     print(['../vys/vahovane_prumery/' ss 'frame_20az150_cv'],'-dpng')
%     figure(2);
%     xlabel('hmotnost')
%     ylabel('rychlost')
%     print(['../vys/vahovane_prumery/' ss 'frame_20az150_mv'],'-dpng')
%     figure(3);
%     xlabel('hmotnost')
%     ylabel('cirkularita')
%     print(['../vys/vahovane_prumery/' ss 'frame_20az150_mc'],'-dpng')
%     
    
% end


function [out]=addslope(nazevy_treat,s_CC)


for k=1:length(nazevy_treat)
    tmp=s_CC{k};
    out{k}=[nazevy_treat{k} ' k' num2str(tmp(1)) ' q' num2str(tmp(1))];
    
end


end


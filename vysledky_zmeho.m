clc;clear all;close all;

slozky={'A2780','Imunitni system','PC-3','PNT1A'};

CCC={};
VVV={};
MMM={};
PPP={};
nazevy_line={};


for s=slozky
    
    
    listing=dir(s{1});
    
    slozky2={listing(3:end).name};
    
    CC={};
    VV={};
    MM={};
    PP={};
    nazevy_treat={};
    
    
    for ss=slozky2
        
        listing=subdir([s{1} '/' ss{1} '/*parametry*.mat']);
        
        listing={listing(:).name};
        
        C=[];
        X=[];
        Y=[];
        M=[];
        P=[];
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
                hmota=hmota(1:velikost_min,:);
            end
            poprve=0;
            
            C=[C cirkularita];
            %             V=[V sqrt(diff(x,[],1).^2+diff(y,[],1).^2)];
            X=[X x];
            Y=[Y y];
            M=[M hmota];
            P=[P ~isnan(hmota)];
            
        end
        
        %         plot(nanmean(C,2));
        % %         hold on;
        %         plot(nanmean(V,2));
        %         plot(nanmean(M,2));
        
        if strcmp(s{1},'Imunitni system')
            pom=M(~isnan(M));
            prah = prctile(pom(:),50);
            znanovat=(M<prah)|(isnan(M));
            C(znanovat)=nan;
            X(znanovat)=nan;
            Y(znanovat)=nan;
            P(znanovat)=nan;
            M(znanovat)=nan;
        end
        
        
        V=sqrt(diff(X,[],1).^2+diff(Y,[],1).^2);
        CC=[CC nanmean(C,2)];
        VV=[VV nanmean(V,2)];
        MM=[MM nanmean(M,2)];
        PP=[PP nansum(P,2)];
        nazevy_treat=[nazevy_treat  [ss{1}]];
        
        pom=C(20:150,:);
        CCC=[CCC nanmean(pom(:))];
        pom=V(20:150,:);
        VVV=[VVV nanmean(pom(:))];
        pom=M(20:150,:);
        MMM=[MMM nanmean(pom(:))];
        nazevy_line=[nazevy_line  [ss{1}]];
        
        
        
        
        
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
    for k=1:length(nazevy_treat)
        figure(1);
        plot(CC{k})
        figure(2);
        plot(VV{k})
        figure(3);
        plot(MM{k})
        figure(4);
        plot(PP{k})
    end
    figure(1);
    title('cirkularita')
    legend(nazevy_treat,'Location','northoutside')
    print(['vysledky_zmeho/casove/' s{1} '_c'],'-dpng')
    figure(2);
    title('rychlost')
    legend(nazevy_treat,'Location','northoutside')
    print(['vysledky_zmeho/casove/' s{1} '_v'],'-dpng')
    figure(3);
    title('hmota')
    legend(nazevy_treat,'Location','northoutside')
    print(['vysledky_zmeho/casove/' s{1} '_m'],'-dpng')
    figure(4);
    title('pocet')
    legend(nazevy_treat,'Location','northoutside')
    print(['vysledky_zmeho/casove/' s{1} '_p'],'-dpng')
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
for k=1:length(nazevy_line)
    figure(1)
    plot(CCC{k},VVV{k},'*')
    text(CCC{k},VVV{k},nazevy_line{k})
    figure(2)
    plot(MMM{k},VVV{k},'*')
    text(MMM{k},VVV{k},nazevy_line{k})
    figure(3)
    plot(MMM{k},CCC{k},'*')
    text(MMM{k},CCC{k},nazevy_line{k})
    
end


figure(1);
xlabel('cirkularita')
ylabel('rychlost')
print(['vysledky_zmeho/vahovane_prumery/' 'frame_20az150_cv'],'-dpng')
figure(2);
xlabel('hmotnost')
ylabel('rychlost')
print(['vysledky_zmeho/vahovane_prumery/' 'frame_20az150_mv'],'-dpng')
figure(3);
xlabel('hmotnost')
ylabel('cirkularita')
print(['vysledky_zmeho/vahovane_prumery/' 'frame_20az150_mc'],'-dpng')


slozky={'A2780_','IS_','PC3_','PNT1A_'};

for s=slozky
    close all
    figure(1);
    hold on
    figure(2);
    hold on
    figure(3);
    hold on
    figure(4);
    hold on
    vektor=find(cellfun(@(x) contains(x,s{1}),nazevy_line));
    for k=vektor
        figure(1)
        plot(CCC{k},VVV{k},'*')
        text(CCC{k},VVV{k},nazevy_line{k})
        figure(2)
        plot(MMM{k},VVV{k},'*')
        text(MMM{k},VVV{k},nazevy_line{k})
        figure(3)
        plot(MMM{k},CCC{k},'*')
        text(MMM{k},CCC{k},nazevy_line{k})
        
    end
    
    
    figure(1);
    xlabel('cirkularita')
    ylabel('rychlost')
    print(['vysledky_zmeho/vahovane_prumery/' s{1} 'frame_20az150_cv'],'-dpng')
    figure(2);
    xlabel('hmotnost')
    ylabel('rychlost')
    print(['vysledky_zmeho/vahovane_prumery/' s{1} 'frame_20az150_mv'],'-dpng')
    figure(3);
    xlabel('hmotnost')
    ylabel('cirkularita')
    print(['vysledky_zmeho/vahovane_prumery/' s{1} 'frame_20az150_mc'],'-dpng')
    
    
end





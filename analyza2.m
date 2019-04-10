clc;clear all;close all;

% ,'Circularity','Area','Perimeter','Density','Motility.Path'
slozky={'A2780','Imunitni system','PC-3','PNT1A'};
parametry={'Mass','pocet'};
for sl=slozky
    sl
    A={};
    M={};
    nanovaci=[];
    for par=parametry
        par
        close all;
        slozka=sl{1};
        parametr=par{1};
        
        listing=dir(slozka) ;
        listing=listing(3:end);
        listing=listing([listing.isdir] );
        
        figure(1)
        hold on
        citac=0;
        for experiment=1:length(listing)
            citac=citac+1;
            
            s=listing(experiment).name;
            ss=[slozka '/' s '/SATA/*' parametr '*'] ;
            file=dir(ss);
            
            
            %            if ~isempty(file)
            
            
            
            if strcmp(parametr, 'Density')
                data=M{citac}./A{citac};
                
            elseif strcmp(parametr, 'pocet')
                data=M{citac};
                
            else
                T=readtable([slozka '/' s '/SATA/' file(1).name]) ;
                data=T{:, 2:end-1};
            end
            
            
            
            
            
            
            if strcmp(parametr, 'Mass')
                M{citac}=data;
            elseif strcmp(parametr, 'Area')
                A{citac}=data;
                
            elseif strcmp(parametr, 'Motility.Path')
                
                
                
                x=data(:,1:4:end);
                y=data(:,2:4:end);
                v=sqrt(diff(x, 1,1).^2+diff(y, 1,1).^2) ;
                data=v;
                
                
                
            end
            
            if strcmp(parametr, 'pocet')
                data=nansum(~isnan(data),2);
            else
                
                data=nanmean(data, 2);
            end
            
            
            
            plot(data)
            %            end
            
            
        end
        legend({listing.name}, 'Location', 'northoutside')
        title([slozka '-' parametr])
        hold off
        
        pom=parametr;
        if strcmp(parametr, 'Motility.Path')
            pom='Motility_Path';
        end
        
        print(['vysledky/' slozka '-' pom],'-dpng')
        close all;
    end
end
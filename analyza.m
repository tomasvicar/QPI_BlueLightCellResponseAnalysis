clc;clear all;close all;


slozky={'A2780','Imunitni system','PC-3','PNT1A'};
parametry={'Mass','Circularity','Area','Perimeter','Density','Motility.Path'};
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
            else
                T=readtable([slozka '/' s '/SATA/' file(1).name]) ;
                data=T{:, 2:end-1};
            end
            
            
            
            
            
            
            if strcmp(parametr, 'Mass')
                M{citac}=data;
            elseif strcmp(parametr, 'Area')
                A{citac}=data;
                
            elseif strcmp(parametr, 'Motility.Path')
                data=data;
                
%                 data=data(1:3:end,1:4:end);
                if nanovaci(citac)
                    x=data(1:3:end,1:4:end);
                    y=data(1:3:end,2:4:end);
                    v=sqrt(diff(x, 1,1).^2+diff(y, 1,1).^2) ;
                    v=v/3;
                    v=kron(v,[1 1 1]');
                    data=v;
                    
                else
                    x=data(:,1:4:end);
                    y=data(:,2:4:end);
                    v=sqrt(diff(x, 1,1).^2+diff(y, 1,1).^2) ;
                    data=v;
                
                end
                
                
                
            end
            
            
            data=nansum(data, 2);
            
            
            if strcmp(parametr, 'Mass')   
            if sum(isnan(data))>0.3*numel(data)
                nanovaci=[nanovaci 1];
            else
                nanovaci=[nanovaci 0];
            end
            end
            
            if sum(isnan(data))>0.3*numel(data)
                data=data';
                data = replace_nans(data);
                data=data';
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
        
        print(['vysledky/x' slozka '-' pom],'-dpng')
        close all;
    end
end
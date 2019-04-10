clc;clear all;close all;
citacek=0;
% ,'Circularity','Motility.Path'
slozky={'A2780','Imunitni system','PC-3','PNT1A'};
parametry={'Mass','Motility.Path','Circularity'};
for sl=slozky
    %     sl
    figure(1)
    hold on
    slozka=sl{1};
    listing=dir(slozka) ;
    listing=listing(3:end);
    listing=listing([listing.isdir] );
    
    
    
    citac=0;
    for experiment=1:length(listing)
%         experiment
        citacek=citacek+1;
        
        for par=parametry
            par
            
            parametr=par{1};
            
            
            
            
            citac=citac+1;
            
            s=listing(experiment).name;
            s
            ss=[slozka '/' s '/SATA/*' parametr '*'] ;
            file=dir(ss);
            
            
            %            if ~isempty(file)
            
            
            
            
            T=readtable([slozka '/' s '/SATA/' file(1).name]) ;
            data=T{:, 2:end-1};
            clear T;
            
            if strcmp(parametr, 'Mass')
                Mpom=data;
            end
            
            
            
            if strcmp(parametr, 'Motility.Path')
                data=data;
                

                    x=data(:,1:4:end);
                    y=data(:,2:4:end);
                    v=sqrt(diff(x, 1,1).^2+diff(y, 1,1).^2) ;
                    data=v;
                    
 
                
                
                
            end
            
            velikostM=;
            velikostjina=;
            
%             prum=nanmean(data, 1);
%             sumik=sum(~isnan(data),1);
%             [ val ] = weightedAverage(sumik, prum);
%             val1=sum(prum.*sumik)/sum(sumik);
            data=data(20:150,:);


            data2=nanmean(data(:));
%             pom=nansum(~isnan(data),2);
%             kolik=mean(pom);
            
%             plot(pom)
%             pause(5)

            
            if strcmp(parametr, 'Motility.Path')
                V{citacek}=data2;
                
            elseif strcmp(parametr, 'Mass')
                M{citacek}=data2;
                
                
            elseif strcmp(parametr,'Circularity')
                C{citacek}=data2;
                
            else
                error('neni')
            end
            
            
        end
        
        nazvy{citacek}=s;
%         plot3(M,C,V,'*')
%         hold on
        
    end
end

for k=1:length(nazvy)
    pom=nazvy{k};
    pom=strrep(pom,'_','-');
    nazvy{k}=pom;
end

figure(1)
hold on
for k=1:length(nazvy)
    plot3(M{k},C{k},V{k},'*')
    text(M{k},C{k},V{k},nazvy{k})
    
end



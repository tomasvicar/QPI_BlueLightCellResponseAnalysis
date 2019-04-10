clc;clear all;close all;

listing=subdir(['*segmentace*.mat']);
listing={listing(:).name};
poc=0;
% listing(1:80)=[]
for s=listing
    poc=poc+1;
    if poc>70
    disp([num2str(poc) '/' num2str(length(listing))])
    nazev1=s{1}
    nazev2=nazev1;
    nazev2=strrep(nazev2,'.mat','.tiff');
    nazev2=strrep(nazev2,'segmentace','Compensated phase-pgpum2');
    nazev3=nazev1;
    nazev3=strrep(nazev3,'segmentace','sloucene07');
    nazev4=nazev1;
    nazev4=strrep(nazev4,'segmentace','parametry07');
    
    
    load(nazev1);
%     clear ll
    bb_old=b(:,:,1);
    bb_old = imclearborder(bb_old);
    l_old=bwlabel(bb_old);
    cislo_bunky=max(l_old(:));
    ll(:,:,1)=double(l_old);
    for k=2:size(b,3)
        bb_new=b(:,:,k);
        bb_new = imclearborder(bb_new);
        l_new=bwlabel(bb_new);
        vys=zeros(size(l_new));
        ml=max(l_new(:));
        for q=1:ml
            bunka_nova=l_new==q;
            bunka_nova = imfill(bunka_nova,'holes');
            obsah=l_old(bunka_nova);
            nej=mode(obsah);
            if nej>0
                bunka_stara=l_old==nej;
                bunka_stara = imfill(bunka_stara,'holes');
                if jaccard(bunka_stara,bunka_nova)>0.7
                    vys(bunka_nova)=nej;
                else
                    cislo_bunky=cislo_bunky+1;
                    vys(bunka_nova)=cislo_bunky;
                end
            else
                cislo_bunky=cislo_bunky+1;
                vys(bunka_nova)=cislo_bunky;
            end
        end
        
        bb_old=bb_new;
        ll(:,:,k)=vys;
        l_old=vys;
    end
    save(nazev3,'ll');
%     velikost=[size(ll,3) max(ll(:))];
%     hmota=nan(velikost);
%     cirkularita=nan(velikost);
%     x=nan(velikost);
%     y=nan(velikost);
%     plocha=nan(velikost);
%     for k=1:size(ll,3)
%         l=ll(:,:,k);
%         I=imread(nazev2,k);
%         stats = regionprops(l,I,'WeightedCentroid','Area','Perimeter','MeanIntensity');
%         cent=cat(1,stats.WeightedCentroid);
%         x(k,1:length(cent(:,1)))=cent(:,1);
%         y(k,1:length(cent(:,1)))=cent(:,2);
%         plocha(k,1:length(cent(:,1)))=cat(1,stats.Area);
%         hmota(k,1:length(cent(:,1)))=cat(1,stats.MeanIntensity).*cat(1,stats.Area);
%         cirkularita(k,1:length(cent(:,1)))=4*pi*cat(1,stats.Area)./(cat(1,stats.Perimeter).^2);
%         
%     end
%     
%     
%     save(nazev4,'hmota','cirkularita','plocha','x','y');
    end
    
end
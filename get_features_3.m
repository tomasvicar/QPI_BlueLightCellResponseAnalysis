clc;clear all;close all;
addpath('utils')

data_folder='../data';

listing=subdir([data_folder '/*segmentaion*.mat']);
listing={listing(:).name};
count=0;
for s=listing
    count=count+1;
    
    disp([num2str(count) '/' num2str(length(listing))])
    name_seg=s{1};
    name_qpi=name_seg;
    name_qpi=strrep(name_qpi,'.mat','.tiff');
    name_qpi=strrep(name_qpi,'segmentaion','QPI');
    name_tra=name_seg;
    name_tra=strrep(name_tra,'segmentaion','tracked');
    name_fea=name_seg;
    name_fea=strrep(name_fea,'segmentaion','features');
    

    load(name_tra);
    ll=ll(:,:,1:length(imfinfo(name_qpi)));
    size_req=[size(ll,3) max(ll(:))];
    mass=nan(size_req);
    cirkularity=nan(size_req);
    x=nan(size_req);
    y=nan(size_req);
    area=nan(size_req);
    density=nan(size_req);
    CDS=nan(size_req);
    for k=1:size(ll,3)
        l=ll(:,:,k);
        if k>1
            I_old=I;
        else
             I_old=imread(name_qpi,k);
        end
        I=imread(name_qpi,k);
        
        
        stats = regionprops(l,I,'WeightedCentroid','Area','Perimeter','MeanIntensity');
        cent=cat(1,stats.WeightedCentroid);
        x(k,1:length(cent(:,1)))=cent(:,1);
        y(k,1:length(cent(:,1)))=cent(:,2);
        area(k,1:length(cent(:,1)))=cat(1,stats.Area)/2.5464;
        density(k,1:length(cent(:,1)))=cat(1,stats.MeanIntensity);
        mass(k,1:length(cent(:,1)))=cat(1,stats.MeanIntensity).*cat(1,stats.Area)/2.5464;
        cirkularity(k,1:length(cent(:,1)))=4*pi*cat(1,stats.Area)./(cat(1,stats.Perimeter).^2);
        
        ml=unique(l(:))';
        ml(ml==0)=[];
        for kk=ml
            if sum(sum(l==kk))~=0
                CDS(k,kk)=sqrt(sum(sum((I_old(l==kk)-I(l==kk)).^2)));
            else
                CDS(k,kk)=nan;
            end
        end
        
        
    end
    CDS=CDS./area;
    
    
    save(name_fea,'mass','cirkularity','area','x','y','CDS','density');

    
end
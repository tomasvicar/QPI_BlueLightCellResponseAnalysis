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
    
    
    
    
    
    load(name_seg);
    
    
    clear ll
    bb_old=b(:,:,1);
    bb_old = imclearborder(bb_old);
    l_old=bwlabel(bb_old);
    cell_num=max(l_old(:));
    ll(:,:,1)=double(l_old);
    for k=2:size(b,3)
        bb_new=b(:,:,k);
        bb_new = imclearborder(bb_new);
        l_new=bwlabel(bb_new);
        res=zeros(size(l_new));
        ml=max(l_new(:));
        for q=1:ml
            cell_new=l_new==q;
            cell_new = imfill(cell_new,'holes');
            obsah=l_old(cell_new);
            nej=mode(obsah);
            if nej>0
                cell_old=l_old==nej;
                cell_old = imfill(cell_old,'holes');
                if jaccard(cell_old,cell_new)>0.7
                    res(cell_new)=nej;
                else
                    cell_num=cell_num+1;
                    res(cell_new)=cell_num;
                end
            else
                cell_num=cell_num+1;
                res(cell_new)=cell_num;
            end
        end
        
        bb_old=bb_new;
        ll(:,:,k)=res;
        l_old=res;
    end
    save(name_tra,'ll');
    
    
end
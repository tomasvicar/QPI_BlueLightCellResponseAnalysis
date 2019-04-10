clc;clear all;close all;
%podle automted cell segmentation for quntitative phase microscopy

a=imread('Compensated phase-pgpum2-001-001.tiff',1);

a=medfilt2(a,[3 3]);
a=imgaussfilt(a,0.2);

% a=mat2gray(a,)

volume_tresh=100;


b=a>0.03;

b=mass_filt(b,a,volume_tresh);

vys=b;
vys_old=true(size(b));
while sum(sum(vys_old==vys))~=numel(vys)
vys_old=vys;

b=vys;

vys=false(size(b));

l=bwlabel(b);

ml=max(l(:));
for k=1:ml
    region=k==l;
    
    grey_blob=a.*region;
    bb=regionprops(region,'BoundingBox');
    bb=bb(1).BoundingBox;
    bb=floor(bb);
    bb(bb==0)=1;
    grey_blob=imcrop(grey_blob,bb);
    
    bw=grey_blob>0;
    for tresh=0.05:0.05:0.9
        bw_blob=grey_blob>tresh;
        
%         bw_blob=imerode(bw_blob,strel('disk',3));
%         pom=bwdist(bw_blob);
%         pom=imhmin(pom,5);
%         bw_blob=bw_blob.*(watershed(pom)>0);
        
%         figure(1)
%         imshow(bw_blob);
%         drawnow;
        ll=bwlabel(bw_blob);
        mll=max(ll(:));
        for kk=1:mll
            cc=ll==kk;
            
            volume=sum(sum(grey_blob.*cc));
            if volume<volume_tresh
                bw_blob(cc)=0;
            
            end
        end
        pom=bwlabel(bw_blob);
        num_css=max(pom(:));
        if num_css>1
            break;
        end
    end
    
    pom=bwlabel(bw_blob);
    num_blobs=max(pom(:));
    if num_blobs>1
        dists=bwdist(bw_blob);
        basins=watershed(dists);
        cut_lines=basins==0;
        bw=bw&~cut_lines;
    end
    pom=false(size(vys));
    pom(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3))=bw;
    vys(pom)=1;
end


figure
imshow(a,[]);
hold on
visboundaries(vys)




end




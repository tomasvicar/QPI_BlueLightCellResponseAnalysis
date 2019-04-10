% clc;clear all;close all;
%podle automted cell segmentation for quntitative phase microscopy

function [segm]=qpi_it_egt_old(I,volume_tresh,prah,prah2,max_prah,dira_min)

% a=imread('Compensated phase-pgpum2-001-001.tiff',1);
a=I;
a=medfilt2(a,[3 3]);
a=imgaussfilt(a,0.2);




% a=mat2gray(a,)

% volume_tresh=100;
% max_prah=0.9;
% prah=0.03;

% b=a>prah;


% apom=uint8(mat2gray(a,[0 2.5])*255);
% [~,cc]=detectMSERFeatures(apom,'ThresholdDelta',mser_delta,'MaxAreaVariation',mser_variability,'RegionAreaRange',[100 150000]);
% pom=false(size(a));
% pom(cat(1,cc.PixelIdxList{:}))=1;


pom = EGT_Segmentation(a);


b=(pom.*(a>prah))|a>prah2;

b=~bwareafilt(~b,[dira_min,Inf]);

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
%     bb(bb>600)=600;
    if bb(2)+bb(4)>size(l,1)
        bb(4)=bb(4)-(bb(2)+bb(4)-size(l,1));
    end
    if bb(1)+bb(3)>size(l,2)
        bb(3)=bb(3)-(bb(1)+bb(3)-size(l,2));
    end
    
    grey_blob=grey_blob(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3));
    
    bw=grey_blob>0;
    for tresh=prah:0.05:max_prah
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
        smazat=[];
        for kk=1:mll
            cc=ll==kk;
            
            volume=sum(sum(grey_blob.*cc));
            if volume<volume_tresh
                bw_blob(cc)=0;
%                 ccc=sub2ind(size(ll), size(ll))
%                 smazat=[smazat ;find(cc)];
            end
        end
%         if ~isempty(smazat)
%             bw_blob(smazat)=0;
%         end
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


% figure
% imshow(a,[]);
% hold on
% visboundaries(vys)

segm=vys;


end




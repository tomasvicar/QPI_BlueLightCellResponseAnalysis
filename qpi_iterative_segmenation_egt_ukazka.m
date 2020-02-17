function [segm]=qpi_iterative_segmenation_egt_ukazka(I,volume_tresh,tresh,tresh2,max_tresh,hole_min,name)
%based on Loewke - automted cell segmentation for quntitative phase
%microscopy  and combined with EGT segmentation


% tresh - foreground treshhold (aditional to EGT)
% tresh2 -  foreground treshhold (aditional to EGT)
%BW = (egt and I>tresh)|I>tresh2
%max_tresh - dividing lines above this treshold will not be created
%hole_min - smaler holes will be removed



a=I;
a=medfilt2(a,[3 3]);
a=imgaussfilt(a,0.2);






tmp = EGT_Segmentation(a);



figure()
imshow(tmp,[]);
title('egt')
print('../tmp/egt','-dpng')



b=(tmp.*(a>tresh))|a>tresh2;



figure(1)
imshow(b,[]);
title('sprahy')
print('../tmp/sprahy','-dpng')


b=~bwareafilt(~b,[hole_min,Inf]);



figure(2)
imshow(b,[]);
title('holefilt')
print('../tmp/holefilt','-dpng')


b=mass_filt(b,a,volume_tresh);

figure(3)
imshow(b,[]);
title('volfilt')
print('../tmp/volfilt','-dpng')


% a=imerode(a,strel('sphere',1));
% a=imopen(a,strel('sphere',3));

res=b;
res_old=true(size(b));
while sum(sum(res_old==res))~=numel(res)
res_old=res;

b=res;

res=false(size(b));

l=bwlabel(b);

ml=max(l(:));
for k=1:ml
    region=k==l;
    
    grey_blob=a.*region;
    bb=regionprops(region,'BoundingBox');
    bb=bb(1).BoundingBox;
    bb=floor(bb);
    bb(bb==0)=1;

    if bb(2)+bb(4)>size(l,1)
        bb(4)=bb(4)-(bb(2)+bb(4)-size(l,1));
    end
    if bb(1)+bb(3)>size(l,2)
        bb(3)=bb(3)-(bb(1)+bb(3)-size(l,2));
    end
    
    grey_blob=grey_blob(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3));
    
    
    
    figure(4)
    imshow(grey_blob,[]);
    title('nula')
    print('../tmp/nula','-dpng')
    
    bw=grey_blob>0;
    for t=tresh:0.05:max_tresh
        bw_blob=grey_blob>t;
        
        

        ll=bwlabel(bw_blob);
        mll=max(ll(:));
        
        for kk=1:mll
            cc=ll==kk;
            

            
            volume=sum(sum(grey_blob.*cc));
            if volume<volume_tresh
                bw_blob(cc)=0;

            end
        end
        tmp=bwlabel(bw_blob);
        num_css=max(tmp(:));
        if num_css>1
            figure(5)
            imshow(grey_blob.*double(bw_blob),[]);
            title('div')
            print('../tmp/div','-dpng')
            
            break;
        end
    end
    
    tmp=bwlabel(bw_blob);
    num_blobs=max(tmp(:));
    if num_blobs>1
        dists=bwdist(bw_blob);
        
        figure(6)
        imshow(dists,[]);
        title('dist')
        print('../tmp/dist','-dpng')
            
        
        basins=watershed(dists);
        cut_lines=basins==0;
        bw=bw&~cut_lines;
    end
    
    figure(7)
    imshow(double(bw).*grey_blob,[]);
    title('final')
    print('../tmp/final','-dpng')
            

    if num_blobs==2
        drawnow;
    end
    
    
    tmp=false(size(res));
    tmp(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3))=bw;
    res(tmp)=1;
end




segm=res;


figure(8)
imshow(double(segm).*a,[]);
title('final_whole_gray')
print('../tmp/final_whole_gray','-dpng')


figure(9)
imshow(segm,[]);
title('final_whole_binar')
print('../tmp/final_whole_binar','-dpng')


end




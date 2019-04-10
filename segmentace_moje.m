clc;clear all;close all;

slozka='A2780';
volume_tresh=100;
prah=0.07;
max_prah=2;
mser_variability=0.25;
mser_delta=1;


listing={};

listing1=dir(slozka);
listing1={listing1(3:end).name};
for ss=listing1
    pom=subdir([slozka '/' ss{1} '/Video/Compensated phase-pgpum2*.tiff']);
    listing=[listing {pom(:).name}];
    
end


for s=listing
    
    nazev0=s{1};
    pom=strfind(nazev0,'\');
    nazev1=nazev0(1:pom(end));
    nazev2=nazev0(1:pom(end));
    nazev1=[nazev1 'seg_ukazka' nazev0(end-12:end)];
    nazev2=[nazev2 'segmentace' nazev0(end-12:end)];
    
    info=imfinfo(listing{1});
    clear b
    for k=1:length(info)
        
        
        I=imread(nazev0,k);
        b(:,:,k)=qpi_it(I,volume_tresh,prah,max_prah,mser_variability,mser_delta);
        imshow(I,[0 2.5])
        hold on;
        visboundaries(b(:,:,k),'Color','r','LineWidth',0.1)
        hold off
        title(num2str(k))
        drawnow;
        cdata = print('-RGBImage');
        
        tiff_stack_uint8_color_jpg(nazev1,cdata,k)
        
    end
    save(nazev2,'b');
    
end

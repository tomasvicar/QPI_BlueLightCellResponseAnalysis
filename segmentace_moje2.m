clc;clear all;close all;

slozka='PNT1A';
volume_tresh=100;
prah=0.07;
max_prah=2;
prah2=0.4;
dira_min=200;


listing={};

listing1=dir(slozka);
listing1={listing1(3:end).name};
for ss=listing1
    pom=subdir([slozka '/' ss{1} '/Video/Compensated phase-pgpum2*.tiff']);
    listing=[listing {pom(:).name}];
    
end

% listing(1:3)=[];


for s=listing
    
    nazev0=s{1};
    nazev0
    pom=strfind(nazev0,'\');
    nazev1=nazev0(1:pom(end));
    nazev2=nazev0(1:pom(end));
    nazev1=[nazev1 'seg_ukazka' nazev0(end-12:end)];
    nazev2=[nazev2 'segmentace' nazev0(end-12:end)];
    
    info=imfinfo(s{1});
    clear b
    fprintf(1,'%s\n\n',repmat('.',1,length(info)));
    parfor k=1:length(info)
        
%         try
        I=imread(nazev0,k);
        b(:,:,k)=qpi_it_egt(I,volume_tresh,prah,prah2,max_prah,dira_min);
%         catch
%             error(num2str(k))
%         end
%         imshow(I,[0 2.5])
%         hold on;
%         visboundaries(b(:,:,k),'Color','r','LineWidth',0.1)
%         hold off
%         title(num2str(k))
%         drawnow;
%         cdata = print('-RGBImage');
        
%         tiff_stack_uint8_color_jpg(nazev1,cdata,k)
        fprintf(1,'\b|\n');
    end
    save(nazev2,'b');
    
end
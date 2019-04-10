clc;clear all;close all;


folder='../Data na bakalarku/A2780';
volume_tresh=100;
tresh=0.07;
max_tresh=2;
tresh2=0.4;
hole_min=100;




% folder='../Data na bakalarku/G361';
% volume_tresh=150;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=100;


%
% folder='../Data na bakalarku/PC-3';
% volume_tresh=150;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=200;


% folder='../Data na bakalarku/PNT1A';
% volume_tresh=100;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=200;




% folder='../Data na bakalarku/Imunitni system';
% volume_tresh=100;
% tresh=0.07;
% max_tresh=1.2;
% tresh2=0.4;
% hole_min=200;

listing={};

listing1=dir(folder);
listing1={listing1(3:end).name};
for ss=listing1
    pom=subdir([folder '/' ss{1} '/Video/Compensated phase-pgpum2*.tiff']);
    listing=[listing {pom(:).name}];
    
end

% listing(1:3)=[];


for s=listing
    
    name0=s{1};
    name0
    pom=strfind(name0,'\');
    name1=name0(1:pom(end));
    name2=name0(1:pom(end));
    name1=[name1 'seg_ukazka' name0(end-12:end)];
    name2=[name2 'segmentace' name0(end-12:end-5) '.mat'];
    
    info=imfinfo(s{1});
    clear b
    fprintf(1,'%s\n\n',repmat('.',1,length(info)));
    parfor k=1:length(info)
        
%         try
        I=imread(name0,k);
        b(:,:,k)=qpi_it_egt(I,volume_tresh,tresh,tresh2,max_tresh,hole_min);
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
%         
%         tiff_stack_uint8_color_jpg(name1,cdata,k)
        fprintf(1,'\b|\n');
    end
    save(name2,'b');
    
end
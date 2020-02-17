clc;clear all;close all;
addpath('utils')

data_folder='../data_send';

% folder=[data_folder filesep 'A2780'];
% volume_tresh=100;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=100;



% folder=[data_folder filesep 'G361'];
% volume_tresh=150;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=100;



% folder=[data_folder filesep 'PC-3'];
% volume_tresh=150;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=200;


folder=[data_folder filesep 'PNT1A'];
volume_tresh=100;
tresh=0.07;
max_tresh=2;
tresh2=0.4;
hole_min=200;


listing={};
listing1=dir(folder);
listing1={listing1(3:end).name};
for ss=listing1
    tmp=subdir([folder filesep ss{1} filesep '*.tiff']);
    listing=[listing {tmp(:).name}];
    
end



% for s=listing

s=listing{1};
    
    name0=s;
    name0
    name1=name0;
    name2=name0;
    name1=strrep(name0,'.tiff','.mat');
    name1=strrep(name1,'QPI','segmentaion_example');
    name2=strrep(name2,'.tiff','.mat');
    name2=strrep(name2,'QPI','segmentaion');
    
    
    
    [filepath,name,ext] = fileparts(name0);
    filepath=strrep(filepath,'data_send','na_segmentacni_obrazek');
    
    mkdir(filepath)
    
    
    name=strrep(name0,'.tiff','.png');
    name=strrep(name0,'data_send','na_segmentacni_obrazek');


    
    info=imfinfo(s);
    clear b
    fprintf(1,'%s\n\n',repmat('.',1,length(info)));
%     parfor k=1:length(info)
    k=100;
        

        I=imread(name0,k);
        b=qpi_iterative_segmenation_egt_ukazka(I,volume_tresh,tresh,tresh2,max_tresh,hole_min,name);

%         imshow(I,[-0.1 2])
%         hold on;
%         visboundaries(b(:,:,k),'Color','r','LineWidth',0.1)
%         hold off
%         title(num2str(k))
%         drawnow;
%         cdata = print('-RGBImage');         
%         tiff_stack_uint8_color_jpg(name1,cdata,k)
        fprintf(1,'\b|\n');
%     end
    save(name2,'b');
    
% end
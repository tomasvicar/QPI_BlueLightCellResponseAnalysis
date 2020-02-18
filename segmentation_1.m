clc;clear all;close all;
addpath('utils')

data_folder='../data';

folder=[data_folder filesep 'A2780'];
mass_threshold=100;
foreground_threshold_2=0.07;
max_LIT_threshold=2;
foreground_threshold_1=0.4;
hole_area_threshold=100;



% folder=[data_folder filesep 'G361'];
% mass_threshold=150;
% foreground_threshold_2=0.07;
% max_LIT_threshold=2;
% foreground_threshold_1=0.4;
% hole_area_threshold=100;



% folder=[data_folder filesep 'PC-3'];
% mass_threshold=150;
% foreground_threshold_2=0.07;
% max_LIT_threshold=2;
% foreground_threshold_1=0.4;
% hole_area_threshold=200;


% folder=[data_folder filesep 'PNT1A'];
% mass_threshold=100;
% foreground_threshold_2=0.07;
% max_LIT_threshold=2;
% foreground_threshold_1=0.4;
% hole_area_threshold=200;


listing={};
listing1=dir(folder);
listing1={listing1(3:end).name};
for ss=listing1
    tmp=subdir([folder filesep ss{1} filesep '*.tiff']);
    listing=[listing {tmp(:).name}];
    
end



for s=listing
    
    name0=s{1};
    name0
    name1=name0;
    name2=name0;
    name1=strrep(name0,'.tiff','.mat');
    name1=strrep(name1,'QPI','segmentaion_example');
    name2=strrep(name2,'.tiff','.mat');
    name2=strrep(name2,'QPI','segmentaion');
    
    info=imfinfo(s{1});
    clear b
    fprintf(1,'%s\n\n',repmat('.',1,length(info)));
    parfor k=1:length(info)
        

        I=imread(name0,k);
        b(:,:,k)=qpi_iterative_segmenation_egt(I,mass_threshold,foreground_threshold_2,foreground_threshold_1,max_LIT_threshold,hole_area_threshold);

%         imshow(I,[-0.1 2])
%         hold on;
%         visboundaries(b(:,:,k),'Color','r','LineWidth',0.1)
%         hold off
%         title(num2str(k))
%         drawnow;
%         cdata = print('-RGBImage');         
%         tiff_stack_uint8_color_jpg(name1,cdata,k)
        fprintf(1,'\b|\n');
    end
    save(name2,'b');
    
end
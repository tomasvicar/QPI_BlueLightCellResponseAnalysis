clc;clear all;close all;


% v = VideoReader("Z:\CELL_MUNI\marek\new_09_04_19\Data na bakalarku\A2780\A2780_0mj\Video\A2780_bezfluo_Marek_02.avi");
frame_rate=7;



addpath('utils')
addpath('plotSpread')

slozky={'../Data na bakalarku/A2780','../Data na bakalarku/G361','../Data na bakalarku/PC-3','../Data na bakalarku/PNT1A'};

% slozky={'../Data na bakalarku/PC-3'};


save_dir=('../data');
s_num=0;
for s=slozky
    line=split(s{1},'/');
    line=line{end};
    
    
    mkdir([save_dir '/' line]);
    
    
    
    listing=dir(s{1});
    slozky2={listing(3:end).name};
    
    
    for ss=slozky2
        
        listing=subdir([s{1} '/' ss{1} '/Video/Compensated phase-pgpum2*.tiff']);

        
        if contains(ss{1},'30mj')&&contains(ss{1},'500ms')
            treat='30mj_500ms';
        elseif contains(ss{1},'30mj')&&contains(ss{1},'1000ms')
            treat='30mj_1000ms';
        elseif contains(ss{1},'300mj')&&contains(ss{1},'500ms')
            treat='300mj_500ms';
        elseif contains(ss{1},'300mj')&&contains(ss{1},'1000ms')
            treat='300mj_1000ms';
        elseif contains(ss{1},'0mj')
            treat='0mj';
        else
            error('nocolor')
        end

        mkdir([save_dir '/' line '/' treat])
        
        
        listing={listing(:).name};
        
        num=0;
        
        for file = listing
            
            num=num+1;
            
            file=file{1};
            
           
            copyfile(file,[save_dir '/' line '/' treat '/QPI_' line '_' treat '_' num2str(num,'%03.f') '.tiff'])
            
            v = VideoWriter([save_dir '/' line '/' treat '/video_' line '_' treat '_' num2str(num,'%03.f') '.avi'],'Grayscale AVI');
            
            v.FrameRate=7;
            
            info=imfinfo(file);
   
            
            open(v)
            for k = 1:length(info)
                
                I=imread(file,k);
                
                I=mat2gray(I,[-0.1 2]);
                
                I=uint8(round(I*255));
                
                writeVideo(v,I)

            end
            close(v)
            
            
            
            drawnow;

        end
        

    end
end
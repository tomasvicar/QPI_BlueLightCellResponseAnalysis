clc;clear all;close all;

% folder='../Data na bakalarku/A2780';
% volume_tresh=100;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=100;



% 
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

% 
folder='../Data na bakalarku/PNT1A';
volume_tresh=100;
tresh=0.07;
max_tresh=2;
tresh2=0.4;
hole_min=200;




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
    listing=[listing pom(:).name];
    
end

clear qpi
cit=0;
for s=listing
    cit=cit+1;
    qpi(:,:,cit)=imread(s{1},randi(200));
%     cit=cit+1;
%     qpi(:,:,1,cit)=padarray(imread(s{1},100),[5 5]);
end
qpi=double(qpi);

% figure(1);
% mont=montage(qpi);
% mont=mont.CData;
% imshow(mont,[])

for k=1:size(qpi,3)
    qq=listing{k};
    qq=split(qq,'\');
    qq=qq{3};
    
    q=qpi(:,:,k);
    b=qpi_it_egt(q,volume_tresh,tresh,tresh2,max_tresh,hole_min);
    % b=qpi_it_egt_old(mont,volume_tresh,tresh,tresh2,max_tresh,hole_min);

    figure();
    imshow(q,[-0.1 2.5]);
    hold on;
    visboundaries(b,'Color','r','LineWidth',0.1)
    title(listing{k})
    drawnow;
    print_png_eps_svg(['../vys/ukazky_segmentaci/' qq num2str(k)])
    
end

% imshow(imerode(mont,strel('sphere',2)),[]);
% imshow(imerode(mont,strel('disk',2)),[]);




clc;clear all;close all;
addpath('utils')

data_folder='../data';

% folder=[data_folder filesep 'A2780'];
% volume_tresh=100;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=100;



folder=[data_folder filesep 'G361'];
volume_tresh=150;
tresh=0.07;
max_tresh=2;
tresh2=0.4;
hole_min=100;



% folder=[data_folder filesep 'PC-3'];
% volume_tresh=150;
% tresh=0.07;
% max_tresh=2;
% tresh2=0.4;
% hole_min=200;


% folder=[data_folder filesep 'PNT1A'];
% volume_tresh=100;
% tresh=0.07;
% max_tresh=2;;;
% tresh2=0.4;
% hole_min=200;


listing={};
listing1=dir(folder);
listing1={listing1(3:end).name};
for ss=listing1
    tmp=subdir([folder filesep '*.tiff']);
    listing=[listing {tmp(:).name}];
    
end

clear qpi
couter=0;
for s=listing
    couter=couter+1;
    qpi(:,:,1,cit)=padarray(imread(s{1},100),[5 5]);
end
qpi=double(qpi);

figure(1);
mont=montage(qpi);
mont=mont.CData;
imshow(mont,[])
close all

for k=1:size(qpi,3)
    qq=listing{k};
    qq=split(qq,'\');
    qq=qq{3};
    
    q=qpi(:,:,k);
    b=qpi_iterative_segmenation_egt(q,volume_tresh,tresh,tresh2,max_tresh,hole_min);

    figure();
    imshow(q,[-0.1 2.5]);
    hold on;
    visboundaries(b,'Color','r','LineWidth',0.1)
    title(listing{k})
    drawnow;

    
end



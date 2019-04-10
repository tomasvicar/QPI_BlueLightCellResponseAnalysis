clc;clear all;close all;




% slozka='A2780';
% volume_tresh=100;
% prah=0.07;
% max_prah=2;
% prah2=0.4;
% dira_min=100;

% slozka='PC-3';
% volume_tresh=150;
% prah=0.07;
% max_prah=2;
% prah2=0.4;
% dira_min=200;

% slozka='PNT1A';
% volume_tresh=100;
% prah=0.07;
% max_prah=2;
% prah2=0.4;
% dira_min=200;

slozka='Imunitni system';
volume_tresh=100;
prah=0.07;
max_prah=1.2;
prah2=0.4;
dira_min=200;






listing={};

listing1=dir(slozka);
listing1={listing1(3:end).name};
for ss=listing1
    pom=subdir([slozka '/' ss{1} '/Video/Compensated phase-pgpum2*.tiff']);
    listing=[listing pom(1).name];
    
end

% listing=subdir([slozka '/*.tiff']);
% listing={listing(:).name};


cit=0;
for s=listing
    cit=cit+1;
    qpi(:,:,1,cit)=padarray(imread(s{1},1),[5 5]);
    cit=cit+1;
    qpi(:,:,1,cit)=padarray(imread(s{1},100),[5 5]);
end
qpi=double(qpi);

mont=montage(qpi);
mont=mont.CData;
imshow(mont,[])


b=qpi_it_egt(mont,volume_tresh,prah,prah2,max_prah,dira_min);

imshow(mont,[0 2.5]);

hold on;
visboundaries(b,'Color','r','LineWidth',0.1)



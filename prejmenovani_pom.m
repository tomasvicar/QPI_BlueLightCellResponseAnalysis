clc;clear all;close all;


listing=subdir(['*segmentace*.tiff']);
listing={listing(:).name};
for s=listing
    nazev1=s{1};
    pom=nazev1;
    pom=pom(1:end-5);
    nazev2=[pom '.mat'];
    movefile(nazev1,nazev2);
end
function imwrite_single_3D(name,data)

% data=single(data);
data=single(data);

%  Modify these variables to reuse this section: (enclosed by ----s)
%     - outputFileName  (filename in your question)
%     - data            (Id{k} in your question)
%


outputFileName = name;




% This is a direct interface to libtiff

t = Tiff(outputFileName,'w');
tagstruct.ImageLength     = size(data,1);
tagstruct.ImageWidth      = size(data,2);
tagstruct.Photometric     = Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample   = 32;
tagstruct.SamplesPerPixel = size(data,3);
tagstruct.SampleFormat = Tiff.SampleFormat.IEEEFP;
tagstruct.Compression=Tiff.Compression.LZW;
tagstruct.RowsPerStrip    = 16;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software        = 'MATLAB';
t.setTag(tagstruct)




t.write(data);


t.close();




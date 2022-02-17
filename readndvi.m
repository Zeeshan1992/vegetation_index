% This program opens the file ndvilistwa.txt
% After readin the number of files, which is saved in n
% we loop over the number of files, read the name of
% the NDVI file, we read the data of the file and save it in
% a matrix A which is displayed

clear all, clf

% Open file list and read number of files
fplist = fopen('ndvilistwa.txt','r')
n = fscanf(fplist,'%f',1)

% Initialize matrix that will hold a stack of 108 image matrices
C = zeros(200,200,n);
% Loop over image matrices and display image
for i = 1:n
   filename = fscanf(fplist,'%s',1);
   fp = fopen(filename,'r');
   A = fread(fp,[200,200],'uint8');  % data is in uint8 format, 0 - 255
   A = A';                           % transpose
   %imagesc(A,[120,220])              % narrow the range for better contrast
   colormap('jet'), colorbar
   %pause(0.1)                        % display with a delay
   % Stack image matrices
   C(:,:,i) = double(A);
   fclose(fp);
end
fclose(fplist)




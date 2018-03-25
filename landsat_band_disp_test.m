%Sample satellite image manipulation in Matlab

% Displaying  landsat 6 bands 
fid1=fopen('lsat7_etm_band1','rb');
fid2=fopen('lsat7_etm_band2','rb');
fid3=fopen('lsat7_etm_band3','rb');
fid4=fopen('lsat7_etm_band4','rb');
fid5=fopen('lsat7_etm_band5','rb');
fid6=fopen('lsat7_etm_band7','rb');

b1=fread(fid1,[1337,1908],'*uint8'); % copies 1337 columns by lines 1908
b2=fread(fid2,[1337,1908],'*uint8');
b3=fread(fid3,[1337,1908],'*uint8');
b4=fread(fid4,[1337,1908],'*uint8');
b5=fread(fid5,[1337,1908],'*uint8');
last7 = fread(fid6,[1337,1908],'*uint8');


% Transposing matrix (colums to row) since matlab follows column-order
% storage
figure(1),clf,colormap(gray)
subplot(2,3,1), imagesc(b1'), colorbar,title('blue')
subplot(2,3,2), imagesc(b2'), colorbar,title('green')
subplot(2,3,3), imagesc(b3'), colorbar,title('red')
subplot(2,3,4), imagesc(b4'), colorbar,title('nir')
subplot(2,3,5), imagesc(b5'), colorbar,title('midir1')
subplot(2,3,6), imagesc(last7'), colorbar,title('midir2')

%Extracting pixels around IIT area
b1win= b1(400:1000, 600:1000); 
b2win= b2(400:1000, 600:1000);
b3win= b3(400:1000, 600:1000);
b4win= b4(400:1000, 600:1000);
b5win= b5(400:1000, 600:1000);
b7win= last7(400:1000, 600:1000);


% Transposing the sub-window matrix for proper display
figure(2),clf, colormap(gray)
subplot(2,3,1); imagesc(b1win'),title('blue');
subplot(2,3,2); imagesc(b2win'),title('green');
subplot(2,3,3); imagesc(b3win'),title('red');
subplot(2,3,4); imagesc(b4win'),title('nir');
subplot(2,3,5); imagesc(b5win'),title('mid1');
subplot(2,3,6); imagesc(b7win'),title('mid2');


%Layer stacking of bands in Matlab using cat
fwrite(fopen('b1win.raw','wb'),b1win','uchar');
fwrite(fopen('b2win.raw','wb'),b2win','uchar');
fwrite(fopen('b3win.raw','wb'),b3win','uchar');
fwrite(fopen('b4win.raw','wb'),b4win','uchar');
fwrite(fopen('b5win.raw','wb'),b5win','uchar');
fwrite(fopen('b7win.raw','wb'),b7win','uchar');
RGB = cat(3,b4win,b3win,b2win); %Transpose has not been done
figure(3),imshow(RGB); title('RGB (band4, band3, band2)'); %FCC  




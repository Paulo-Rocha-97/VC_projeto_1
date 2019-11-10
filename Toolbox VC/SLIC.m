% Primeira utilização do algoritmo SLIC
% imread - constroi uma matriz de indices através de cada pixel
% ind2rgb - passar do imread para RGB
% If cmap empty => RGB values are store for pixel format (true color format)


function SLIC
A = imread('DSC07449_geotag.JPG');
[L,N] = superpixels(A,1024);
figure
BW = boundarymask(L);

outputImage = zeros(size(A),'like',A);
idx = label2idx(L);
numRows = size(A,1);
numCols = size(A,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage(redIdx) = mean(A(redIdx));
    outputImage(greenIdx) = mean(A(greenIdx));
    outputImage(blueIdx) = mean(A(blueIdx));
end    

subplot(2,1,1), imshow(outputImage,'InitialMagnification',67)
subplot(2,1,2), imshow(imoverlay(A,BW,'black'))

end
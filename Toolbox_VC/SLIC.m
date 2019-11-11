% Primeira utiliza��o do algoritmo SLIC
% imread - constroi uma matriz de indices atrav�s de cada pixel
% ind2rgb - passar do imread para RGB
% If cmap empty => RGB values are store for pixel format (true color format)


function [outputImage] = SLIC(number_spixel,A)

[L,N] = superpixels(A,number_spixel);

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

% subplot(2,1,2), imshow(imoverlay(A,BW,'black'))

end
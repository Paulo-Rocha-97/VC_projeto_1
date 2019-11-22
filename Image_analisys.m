% This scripts aims to simply plot and compare
%   -  images histograms 

close al

local = cd;
D=strcat(local,'\Images');
S = dir(fullfile(D)); % pattern to match filenames.

for k = 3:11
    F = fullfile(D,S(k).name);
    I = imread(F);
    Images(k-2).data = I; % optional, save data.
    
    % Extract color channels.
    just_red = I(:,:,1); % Red channel
    just_green = I(:,:,2); % Green channel
    just_blue = I(:,:,3); % Blue channel
    
    Red(k-2).data = just_red;
    Green(k-2).data = just_green;
    Blue(k-2).data = just_blue;

end

figure

for i=1:9
    
    A=strcat('Imagem- ',num2str(i));
    subplot(3,3,i)
    imshow(Images(i).data) 
    title(A)
    
end

suptitle('Imagens')

figure

for i=1:9
    
    A=strcat('Imagem- ',num2str(i));
    subplot(3,3,i)
    imhist(Images(i).data) 
    title(A)
    
end

suptitle('Histogramas Grayscale')

figure

for i=1:9
    
    A=strcat('Imagem- ',num2str(i));
    subplot(3,3,i)
    imhist(Red(i).data) 
    title(A)
    
end

suptitle('Histogramas Red')

figure

for i=1:9
    
    A=strcat('Imagem- ',num2str(i));
    subplot(3,3,i)
    imhist(Green(i).data) 
    title(A)
    
end

suptitle('Histogramas Green')

figure

for i=1:9
    
    A=strcat('Imagem- ',num2str(i));
    subplot(3,3,i)
    imhist(Blue(i).data) 
    title(A)
    
end

suptitle('Histogramas Blue')


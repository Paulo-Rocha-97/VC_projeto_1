
local = cd;
D=strcat(local,'\Images');
S = dir(fullfile(D)); % pattern to match filenames.
F = fullfile(D,S(10).name)

% hsvVal=2/3
% tol=0.14

RGB = imread(F);
RGB = imresize(RGB,0.15)

HSV = rgb2hsv(RGB);

% find the difference between required and real H value:
H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

delta_x = 0.14;
%%%
[comp_m,larg_m] = size(H_A);
Verde = zeros(comp_m,larg_m);
Amarelo = zeros(comp_m,larg_m);
for i = 1:comp_m
    for j = 1:larg_m        
        if H_A(i,j) <= 2/3 + delta_x & H_A(i,j) >= 2/3 - delta_x
            Azul(i,j) = 1;
        else
            Azul(i,j) = 0;
        end
        if H_A(i,j) <= 1/3 + delta_x & H_A(i,j) >= 1/3 - delta_x
            Verde(i,j) = 1;
        else
            Verde(i,j) = 0;
        end
        % Tentar que amarelo não apareça
        if H_A(i,j) <= 1/6 + delta_x & H_A(i,j) >= 1/6 - delta_x
            Amarelo(i,j) = 1;
        else
            Amarelo(i,j) = 0;
        end
    end
end
%%%

CC= Verde - bwareaopen(Verde,800);
CC = bwareaopen(Verde,50);
figure(2);
imshow(CC);

se = strel('disk',2);
closeCC= imclose(CC,se);
figure(3); imshow(closeCC);

smallCC= closeCC - bwareaopen(closeCC,1600);
figure(4); imshow(smallCC);

smallCC_props= bwconncomp(smallCC);
Number_Trees = smallCC_props.NumObjects;

afterOpening = imopen(smallCC,se); 
figure(5); imshow(afterOpening)









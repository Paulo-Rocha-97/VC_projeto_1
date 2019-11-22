function [Verde,H_A,S_A,V_A] = Colour_Segmentation (A)

A = histeq(A);

A = rgb2hsv(A);


H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

delta_h = 0.10;
%Separar por cores: Amarelo, Azul, Verde
% H azul = 2/3; amarelo = 1/6; verde = 1/3

[comp_m,larg_m] = size(H_A);
Azul = zeros(comp_m,larg_m);
Verde = zeros(comp_m,larg_m);
Amarelo = zeros(comp_m,larg_m);
for i = 1:comp_m
    for j = 1:larg_m        
        if H_A(i,j) <= 2/3 + delta_h & H_A(i,j) >= 2/3 - delta_h
            Azul(i,j) = 1;
        else
            Azul(i,j) = 0;
        end
        
        if H_A(i,j) <= 1/3 + delta_h && H_A(i,j) >= 1/3 - delta_h
            Verde(i,j) = 1;
        else
            Verde(i,j) = 0;
        end
        % Tentar que amarelo não apareça
        if H_A(i,j) <= 1/6 + delta_h && H_A(i,j) >= 1/6 - delta_h
            Amarelo(i,j) = 1;
        else
            Amarelo(i,j) = 0;
        end
    end
end


% figure(1)
% subplot(1,3,1)
% imshow(Azul)
% title('Azul')
% subplot(1,3,2)
% imshow(Verde)
% title('Verde')
% subplot(1,3,3)
% imshow(Amarelo)
% title('Amarelo')
           
end


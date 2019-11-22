A = imread('VC_P1_2.JPG');

A = imresize(A,0.15);
A = histeq(A);

A = SLIC(45000,A);

A = rgb2hsv(A);

A = imresize(A,0.15);

H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

[comp_m,larg_m] = size(H_A);

Agua = zeros(comp_m,larg_m);

for i = 1:comp_m
    for j = 1:larg_m
        if H_A(i,j) >= (1/2) - (1/6) && H_A(i,j) <= (1/2) + (1/6)
            Agua(i,j) = 1;
        else
            Agua(i,j) = 0;
        end
    end
end

for p = 1:comp_m
    for k = 1:larg_m
        if  V_A(p,k) <= 0.70 && Agua(p,k) == 1
            Agua(p,k) = 1;
        else
            Agua(p,k) = 0;
        end
    end
end

   
strwateropen = 600;
strwaterclose = strel('octagon',12);
% 
Agua_Open = bwareaopen(Agua,strwateropen);
Agua_Close = imclose(Agua_Open, strwaterclose);
% 
figure(1)
imshow(Agua)
% 
figure(2)
imshow(Agua_Close)
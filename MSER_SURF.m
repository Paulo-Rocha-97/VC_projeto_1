function features = MSER_SURF_
% Image Selection
local = cd;
D=strcat(local,'\Images');
S = dir(fullfile(D)); % pattern to match filenames.

for i = 3:size(S)
    
    F = fullfile(D,S(i).name);
    
    % Image processing
    I = imread(F);
    J= rgb2gray(I);
    J= imresize(J,0.2);
    J = histeq(J);
    J = adapthisteq(J);
    
    % Obtain MSER Regions with parameters optimized
    
    [points_mser,mser_cc] = detectMSERFeatures(J,'ThresholdDelta',2);

    stats=regionprops('table',mser_cc,'Eccentricity', 'Area');
    AreaIdx = stats.Area >200 & stats.Area<1500;
    EccentricityIdx = stats.Eccentricity >0.35 & stats.Eccentricity < 0.80;
    circularRegions = points_mser(EccentricityIdx & AreaIdx);
%     figure(8); imshow(J);
%     hold on
%     plot(circularRegions,'showEllipses',true)

    
    [features, validpts] = extractFeatures(J,circularRegions);
    figure(i)
    imshow(J); hold on
    plot(validpts,'showOrientation',true)
    title('mser')
    hold off
    
    G = imrotate(J,45);
    [points_mser1,mser_cc1] = detectMSERFeatures(G,'ThresholdDelta',2);
    [features1, validpts1] = extractFeatures(G,points_mser1);
    indexPairs = matchFeatures(features,features1);
    
    matchedPoints1 = validpts(indexPairs(:,1),:);
    matchedPoints2 = validpts1(indexPairs(:,2),:);
    figure(i+1);
    showMatchedFeatures(J,G,matchedPoints1,matchedPoints2);
    legend('matched points 1','matched points 2');
    
    
end




end

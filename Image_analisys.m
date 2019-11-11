% This scripts aims to simply plot and compare
%   -  images histograms 




for month=1:9
    
    subplot(3,3,month);
    str_title=strcat("VC_P1_",num2str(month),"JPG");

    title(str_title)
    
end

suptitle('Temperature Prediciton Model - Month shifting Validation')





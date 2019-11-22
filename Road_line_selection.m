function [Road_map,line,Connect] = Road_line_selection (A,lines)
% this function uses the information from the line to decide what is a road
% or not 

[~,linenumber]=size(lines);

%% convert lines struct into matrix

line=zeros(linenumber,8);

for i=1: linenumber
   
    %point 1 
    line(i,1)=lines(1,i).point1(1,1); % X_1
    line(i,2)=lines(1,i).point1(1,2); % Y_1
    % point 2
    line(i,3)=lines(1,i).point2(1,1); % X_2
    line(i,4)=lines(1,i).point2(1,2); % Y_2
    % parameters
    line(i,5)= (line(i,2) - line(i,4)) / (line(i,1) - line(i,3)); % m  
    line(i,7)= line(i,2) - line(i,5) * line(i,1);% b
    line(i,6)= atand( (line(i,2) - line(i,4)) / (line(i,1) - line(i,3))); % m - angle
    if line(i,6)<0
       line(i,6) = line(i,6)+180;  
    end

end

%% create straight road chains using the line in y = mx +b approach

m_tol = 5;
b_tol = 40;

cont=1;

for i = 1:linenumber
    
    ext=2;
    
    for j = 1:linenumber
     
        if ( line(i,8)==0 && line(j,8)==0 ) && ( i~=j ) && ( line(j,6) >= line(i,6) - m_tol  && line(j,6) <= line(i,6) + m_tol ) ...
                && ( line(j,7) >= line(i,7) - b_tol  && line(j,7) <= line(i,7) + b_tol)
            
            Connect(i,1)= i;
            Connect(i,ext)= j;
            line(j,8)=1;
            ext=ext+1;
            
        end
    end
end

Connect = Connect(~all(Connect == 0,2),:);

[number_straight , ~ ] = size(Connect);

point_1 = ones(number_straight,2)*100000000;

point_2 = zeros(number_straight,2);


for i = 1:number_straight

    comp = sum(Connect(i,:)~=0);
    
        for j = 1:comp
            
            if line(Connect(i,j),1)< point_1(i,1)
            
                point_1 (i,1) = line(Connect(i,j),1);
                point_1 (i,2) = line(Connect(i,j),2);
                
            end
            
            if line(Connect(i,j),3)< point_1(i,1)
            
                point_1 (i,1) = line(Connect(i,j),3);
                point_1 (i,2) = line(Connect(i,j),4);
                
            end
            
            if line(Connect(i,j),1) > point_2(i,1)
            
                point_2 (i,1) = line(Connect(i,j),1);
                point_2 (i,2) = line(Connect(i,j),2);
                
            end
            
            if line(Connect(i,j),3) > point_2(i,1)
            
                point_2 (i,1) = line(Connect(i,j),3);
                point_2 (i,2) = line(Connect(i,j),4);
                
            end
             
        end
    Road_map(i).point1 = point_1(i,:);
    Road_map(i).point2 = point_2(i,:);
end


%% Plot Results

figure
imshow(A)
hold on
axis on
max_len = 0;
for k = 1:length(Road_map)
   xy = [Road_map(k).point1; Road_map(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(Road_map(k).point1 - Road_map(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end



end
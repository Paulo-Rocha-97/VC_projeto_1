function varargout = VC_project_1(varargin)
% VC_PROJECT_1 MATLAB code for VC_project_1.fig
%      VC_PROJECT_1, by itself, creates a new VC_PROJECT_1 or raises the existing
%      singleton*.
%
%      H = VC_PROJECT_1 returns the handle to a new VC_PROJECT_1 or the handle to
%      the existing singleton*.
%
%      VC_PROJECT_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VC_PROJECT_1.M with the given input arguments.
%
%      VC_PROJECT_1('Property','Value',...) creates a new VC_PROJECT_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VC_project_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VC_project_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VC_project_1

% Last Modified by GUIDE v2.5 22-Nov-2019 00:45:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VC_project_1_OpeningFcn, ...
                   'gui_OutputFcn',  @VC_project_1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before VC_project_1 is made visible.
function VC_project_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VC_project_1 (see VARARGIN)

% Choose default command line output for VC_project_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VC_project_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VC_project_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Get_filenames.
function Get_filenames_Callback(hObject, eventdata, handles)
% hObject    handle to Get_filenames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

local = cd;
D=strcat(local,'\Images');
S = dir(fullfile(D));
 
mystring=S(3).name;

for i = 4:size(S)
    
    mystring=strcat(mystring,'\n',S(i).name);     

end  

mystring = sprintf(mystring);

set(handles.List_of_images, 'String', mystring);


% --- Executes on key press with focus on Get_filenames and none of its controls.
function Get_filenames_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Get_filenames (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case



function file_select_text_Callback(hObject, eventdata, handles)
% hObject    handle to file_select_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function file_select_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_select_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Preview.
function Preview_Callback(hObject, eventdata, handles)
% hObject    handle to Preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

local = cd;
D=strcat(local,'\Images');
S = dir(fullfile(D));


file = get(handles.file_select_text,'String');

cont=0;

for i = 3:size(S)
if strcmp(file, S(i).name)
    cont=1; 
    number=i;
end  
end

if cont==1
    
    local = cd;
    D=strcat(local,'\Images');
    name = fullfile(D,S(number).name);
        
    A = imread(name);
    
    set(handles.image_display,'Units','pixels');
    imshow(A,'Parent', handles.image_display);

elseif cont==0
    set(handles.file_select_text,'String','(Not a valid name)')
end

% --- Executes on button press in next_stage.
function next_stage_Callback(hObject, eventdata, handles)
% hObject    handle to next_stage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.Done,'Visible','off')
set(handles.Warning,'Visible','on')

local = cd;
D=strcat(local,'\Images');
S = dir(fullfile(D));
 
file = get(handles.file_select_text,'String');

cont=0;

for i = 3:size(S)
if strcmp(file, S(i).name)
    cont=1; 
    number=i;
end  
end

if cont==1
    % Image display
    
    local = cd;
    D=strcat(local,'\Images');
    name = fullfile(D,S(number).name);
        
    A = imread(name);
    set(handles.image_display,'Units','pixels');
    imshow(A,'Parent', handles.image_display);
    
    % Image Resize 
    
    ext=1;
    cont=0.05;
    
    while ext==1
        
        A_=imresize(A,cont);
        [Y_A,X_A,~] = size(A_);
        tamanho= Y_A * X_A;
        
        if ( tamanho > 400000  && tamanho < 500000 ) || cont==1
            
            resize_factor = cont;
            ext = 0;
            
        end
        
        cont = cont + 0.05;
        
    end
    
    OG = imresize(A,resize_factor);
    
    save('original_image.mat', 'OG' )
    
    % Hide and display buttons
    set(handles.Get_filenames,'Visible','off')
    set(handles.List_of_images,'Visible','off')
    set(handles.next_stage,'Visible','off')
    set(handles.Preview,'Visible','off')
    set(handles.file_select_text,'Visible','off')
    
    set(handles.Area_Segmentation,'Visible','on')
    set(handles.Sand_detection,'Visible','on')
    set(handles.Water_detection,'Visible','on')
    set(handles.Human_Limits,'Visible','on')
    set(handles.Object_Identification,'Visible','on')
    set(handles.Road_detection,'Visible','on')
    set(handles.Tree_identification,'Visible','on')
    set(handles.Back,'Visible','on')
    set(handles.n,'Visible','off')
    set(handles.Conter,'Visible','off')
    
elseif cont==0
    set(handles.file_select_text,'String','(Not a valid name)')
end


% --- Executes on key press with focus on Preview and none of its controls.
function Preview_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Preview (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was press
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Sand_detection.
function Sand_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Sand_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all
set(handles.Done,'Visible','off')
set(handles.More_water,'Visible','off')
set(handles.More_road,'Visible','off')
set(handles.More_tree,'Visible','off')
set(handles.n,'Visible','off')
    set(handles.Conter,'Visible','off')

load('original_image.mat')

A=OG;

[~,~,~,~,Final] = Sand_Segmentation (A);

set(handles.image_display,'Units','pixels');
imshow(Final,'Parent', handles.image_display);

set(handles.Done,'Visible','on')
set(handles.More_sand,'Visible','on')


% --- Executes on button press in Water_detection.
function Water_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Water_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
set(handles.Done,'Visible','off')
set(handles.More_sand,'Visible','off')
set(handles.More_road,'Visible','off')
set(handles.More_tree,'Visible','off')

load('original_image.mat')

A=OG;

[B,C,D,Final] = Water_Segmentation (A);

set(handles.image_display,'Units','pixels');
imshow(Final,'Parent', handles.image_display);

set(handles.Done,'Visible','on')
set(handles.More_water,'Visible','on')


% --- Executes on button press in Road_detection.
function Road_detection_Callback(hObject, eventdata, handles)
% hObject    handle to Road_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all
set(handles.Done,'Visible','off')
set(handles.More_sand,'Visible','off')
set(handles.More_water,'Visible','off')
set(handles.More_tree,'Visible','off')
set(handles.n,'Visible','off')
set(handles.Conter,'Visible','off')


load('original_image.mat')

A=OG;

[~,~,~,~,~,~,~,~,~,~,Final] =  Road_detection_v3 (A);

set(handles.image_display,'Units','pixels');
imshow(Final,'Parent', handles.image_display);


set(handles.More_road,'Visible','on')
set(handles.Done,'Visible','on')



% --- Executes on button press in Tree_identification.
function Tree_identification_Callback(hObject, eventdata, handles)
% hObject    handle to Tree_identification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
set(handles.Done,'Visible','off')
set(handles.More_sand,'Visible','off')
set(handles.More_water,'Visible','off')
set(handles.More_road,'Visible','off')
set(handles.n,'Visible','on')
set(handles.Conter,'Visible','on')


load('original_image.mat')

A=OG;

[~,~,~,~,~,Final,Contador] = Tree_Segmentation(A);

value=num2str(Contador);

set(handles.Conter,'String',value);

set(handles.image_display,'Units','pixels');
imshow(Final,'Parent', handles.image_display);

set(handles.More_tree,'Visible','on')
set(handles.Done,'Visible','on')

% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    close all
    
    set(handles.Get_filenames,'Visible','on')
    set(handles.List_of_images,'Visible','on')
    set(handles.next_stage,'Visible','on')
    set(handles.Preview,'Visible','on')
    set(handles.file_select_text,'Visible','on')
    set(handles.Warning,'Visible','off')

    
    set(handles.Area_Segmentation,'Visible','off')
    set(handles.Sand_detection,'Visible','off')
    set(handles.Water_detection,'Visible','off')
    set(handles.Human_Limits,'Visible','off')
    set(handles.Object_Identification,'Visible','off')
    set(handles.Road_detection,'Visible','off')
    set(handles.Tree_identification,'Visible','off')
    set(handles.Back,'Visible','off')
    
    set(handles.Done,'Visible','off')
    set(handles.More_sand,'Visible','off')
    set(handles.More_water,'Visible','off')
    set(handles.More_road,'Visible','off')
    set(handles.More_tree,'Visible','off')
    set(handles.n,'Visible','off')
    set(handles.Conter,'Visible','off')
    set(handles.Conter,'String','--')
    


% --- Executes on button press in More_sand.
function More_sand_Callback(hObject, eventdata, handles)
% hObject    handle to More_sand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Done,'Visible','off')

load('original_image.mat')

A=OG;

[B,C,D,E,~] = Sand_Segmentation (A);

figure(1)
subplot(2,2,1)
imshow(B)
title('HSV selection')
subplot(2,2,2)
imshow(C)
title('Opening')
subplot(2,2,3)
imshow(D)
title('Closing')
subplot(2,2,4)
imshow(E)
title('Small object removal')


% --- Executes on button press in More_water.
function More_water_Callback(hObject, eventdata, handles)
% hObject    handle to More_water (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Done,'Visible','off')
set(handles.Warning,'Visible','off')
set(handles.n,'Visible','off')
    set(handles.Conter,'Visible','off')

load('original_image.mat')

A=OG;

[B,C,D,~] = Water_Segmentation (A);

figure(1)
subplot(2,2,1)
imshow(B)
title('HSV selection')
subplot(2,2,2)
imshow(C)
title('Small object removal')
subplot(2,2,[3 4])
imshow(D)
title('Closing and dilation')




% --- Executes on button press in More_road.
function More_road_Callback(hObject, eventdata, handles)
% hObject    handle to More_road (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Done,'Visible','off')
set(handles.Warning,'Visible','off')
set(handles.n,'Visible','off')
    set(handles.Conter,'Visible','off')

load('original_image.mat')

A=OG;

[Gdir,B,~,~,C_,~,E,F,lines,line_bw,~] =  Road_detection_v3 (A);

figure(1)
subplot(2,4,1)
imshow(B)
title('RGB to Intensity')
subplot(2,4,2)
imshow(C_)
title('Histogram Threshold Selection')
subplot(2,4,5)
imshow(Gdir)
title('Gradiente Direction')
subplot(2,4,6)
imshow(E)
title('Gradiente Direction Selection')
subplot(2,4,[3 7 ])
imshow(F)
title('Combined approach')
subplot(2,4,4)
imshow(A)
title('Hough Transform Line Detection')
hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end  
subplot(2,4,8)
imshow(line_bw)
title('Binarization of Lines Detected')






% --- Executes on button press in More_tree.
function More_tree_Callback(hObject, eventdata, handles)
% hObject    handle to More_tree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

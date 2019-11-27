function varargout = gui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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

function gui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = gui_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)

global f
f=imread('coins.jpg');
axes(handles.axes1)
imshow(f);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global f
b=rgb2gray(f);
axes(handles.axes2)
imshow(b);


function pushbutton3_Callback(hObject, eventdata, handles)

global f
c=im2bw(f);
d = imfill(c,'holes');
axes(handles.axes3)
imshow(d);

function pushbutton4_Callback(hObject, eventdata, handles)
global f
c=im2bw(f);
d = imfill(c,'holes');
w=[1 1 1;
   1 1 1;
   1 1 1];
[row,column]=size(d);
%R=zeros(row,column);
J=zeros(row,column);
P=zeros(row,column);
%Q=zeros(row,column);
for i=2:row-1
    for j=2:column-1
        x1=d(i-1,j-1)*w(1,1);
        x2=d(i-1,j)*w(1,2);
        x3=d(i-1,j+1)*w(1,3);
        x4=d(i,j-1)*w(2,1);
        x5=d(i,j)*w(2,2);
        x6=d(i,j+1)*w(2,3);
        x7=d(i+1,j-1)*w(3,1);
        x8=d(i+1,j)*w(3,2);
        x9=d(i+1,j+1)*w(3,3);
        J(i,j)=min([x1,x2,x3,x4,x5,x6,x7,x8,x9]);
    end
end
% 
% for i=2:row-1
%     for j=2:column-1
%         x1=J(i-1,j-1)*w(1,1);
%         x2=J(i-1,j)*w(1,2);
%         x3=J(i-1,j+1)*w(1,3);
%         x4=J(i,j-1)*w(2,1);
%         x5=J(i,j)*w(2,2);
%         x6=J(i,j+1)*w(2,3);
%         x7=J(i+1,j-1)*w(3,1);
%         x8=J(i+1,j)*w(3,2);
%         x9=J(i+1,j+1)*w(3,3);
%         P(i,j)=min([x1,x2,x3,x4,x5,x6,x7,x8,x9]);
%     end
% end
axes(handles.axes4)
imshow(J)
[L, Ne]=bwlabel(double(J));
prop=regionprops(L,'Area','Centroid');
prop1 = struct2table(prop);
%disp(prop1.Area)
disp(median(prop1.Area(:)));
total=0;
countsmall=0;
countbig=0;
k=size(prop,1)
xcoords = zeros(1,k);

ycoords = zeros(1,k);
ind1=1;

for n=1:size(prop,1)%1 theke total no. of coins
    centroid=prop(n).Centroid;
    x=centroid(1);
    y=centroid(2);
    xcoords(1,ind1)=x;
    ycoords(1,ind1)=y;
    ind1=ind1+1;
    if prop(n).Area < median(prop1.Area(:))
        
        text(x-10,y,'1 tk')
        
        
        total=total+1;
        countsmall=countsmall+1;
    else
        total=total+5;
        text(x-10,y,'5 tk')
        countbig=countbig+1;
    end
    title(['Small coins  = ',num2str(countsmall), '    Big coins  = ', num2str(countbig),'  Total Taka =  ',num2str(total)]);
end
disp(xcoords);

disp(ycoords);

function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

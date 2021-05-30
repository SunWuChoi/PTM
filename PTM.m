% 제작자 201421190 최선우
% 사용자 편의를 위한 인터페이스 구현 부분
% MATLAB 에서 기본 제공하는 guide 기능으로 구현함
function varargout = PTM(varargin)
% PTM MATLAB code for PTM.fig
%      PTM, by itself, creates a new PTM or raises the existing
%      singleton*.
%
%      H = PTM returns the handle to a new PTM or the handle to
%      the existing singleton*.
%
%      PTM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PTM.M with the given input arguments.
%
%      PTM('Property','Value',...) creates a new PTM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PTM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PTM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PTM

% Last Modified by GUIDE v2.5 13-Dec-2016 03:11:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PTM_OpeningFcn, ...
                   'gui_OutputFcn',  @PTM_OutputFcn, ...
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


% --- Executes just before PTM is made visible.
function PTM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PTM (see VARARGIN)

% Choose default command line output for PTM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
A = {'' '' '' '' ''};
set(handles.historyTable,'Data',A);
set( gcf, 'toolbar', 'none' );
%set( gcf, 'toolbar', 'figure' );

% UIWAIT makes PTM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PTM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in updateButton.
function updateButton_Callback(hObject, eventdata, handles)
% hObject    handle to updateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
holdbutton_state = get(handles.holdButton,'Value');
animationbutton_state = get(handles.animationButton,'Value');
dimbutton_state = get(handles.dimButton,'Value');

g = str2double(get(handles.editGravity,'String'));
air = str2double(get(handles.editAir,'String'));
tmpdegree = str2double(get(handles.editDegree,'String'));
degree = 90-tmpdegree;
vinit = str2double(get(handles.editVelocity,'String'));
spinXY = str2double(get(handles.editSpinXY,'String'));
spinYZ = str2double(get(handles.editSpinYZ,'String'));
spinXZ = str2double(get(handles.editSpinXZ,'String'));
mass = str2double(get(handles.editMass,'String'));

if holdbutton_state == 1
    hold on
else
    hold off
end

%ifended = 0;
set(handles.updateButton, 'Enable','off');
set(handles.clearButton, 'Enable','off');

if dimbutton_state == 0
    [ifended height land time] = drawer(g,air,degree,vinit,spinXZ,mass,animationbutton_state);
    if ifended == 1
        curData = {g air tmpdegree vinit 0 spinXZ 0 mass height land time land/time};
        if holdbutton_state == 1
            oldData = get(handles.historyTable,'Data');
            if strcmp(oldData(1,:),'')
                oldData = curData;
            else
                oldData = [oldData; curData];
            end
            set(handles.historyTable,'Data',oldData);
        else
            set(handles.historyTable,'Data',curData);
        end
    end
else
    [ifended height land time] = drawer3d(g,air,degree,vinit,spinXY,spinXZ,spinYZ,mass,animationbutton_state);
    if ifended == 1
        curData = {g air tmpdegree vinit spinXY spinXZ spinYZ mass height land time land/time};
        if holdbutton_state == 1
            oldData = get(handles.historyTable,'Data');
            if strcmp(oldData(1,:),'')
                oldData = curData;
            else
                oldData = [oldData; curData];
            end
            set(handles.historyTable,'Data',oldData);
        else
            set(handles.historyTable,'Data',curData);
        end
    end
end

set(handles.updateButton, 'Enable','on');
set(handles.clearButton, 'Enable','on');





function editAir_Callback(hObject, eventdata, handles)
% hObject    handle to editAir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAir as text
%        str2double(get(hObject,'String')) returns contents of editAir as a double


% --- Executes during object creation, after setting all properties.
function editAir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editGravity_Callback(hObject, eventdata, handles)
% hObject    handle to editGravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editGravity as text
%        str2double(get(hObject,'String')) returns contents of editGravity as a double


% --- Executes during object creation, after setting all properties.
function editGravity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editGravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDegree_Callback(hObject, eventdata, handles)
% hObject    handle to editDegree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDegree as text
%        str2double(get(hObject,'String')) returns contents of editDegree as a double


% --- Executes during object creation, after setting all properties.
function editDegree_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDegree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVelocity_Callback(hObject, eventdata, handles)
% hObject    handle to editVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVelocity as text
%        str2double(get(hObject,'String')) returns contents of editVelocity as a double


% --- Executes during object creation, after setting all properties.
function editVelocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSpinXY_Callback(hObject, eventdata, handles)
% hObject    handle to editSpinXY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSpinXY as text
%        str2double(get(hObject,'String')) returns contents of editSpinXY as a double


% --- Executes during object creation, after setting all properties.
function editSpinXY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSpinXY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exampleButton.
function exampleButton_Callback(hObject, eventdata, handles)
% hObject    handle to exampleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in holdButton.
function holdButton_Callback(hObject, eventdata, handles)
% hObject    handle to holdButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of holdButton
holdbutton_state = get(hObject,'Value');

%set(handles.holdButton,'Value',1);
if holdbutton_state == get(hObject,'Max')
        % Toggle button is pressed, take appropriate action
  %fprintf('Hold on\n'); % for testing
else
        % Toggle button is not pressed, take appropriate action
  %fprintf('Hold off\n'); % for testing
end


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
A = {'' '' '' '' ''};
set(handles.historyTable,'Data',A);


% --- Executes on button press in animationButton.
function animationButton_Callback(hObject, eventdata, handles)
% hObject    handle to animationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of animationButton

%set(handles.holdButton,'Value',1);



function editMass_Callback(hObject, eventdata, handles)
% hObject    handle to editMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMass as text
%        str2double(get(hObject,'String')) returns contents of editMass as a double


% --- Executes during object creation, after setting all properties.
function editMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dimButton.
function dimButton_Callback(hObject, eventdata, handles)
% hObject    handle to dimButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dimButton



function editSpinYZ_Callback(hObject, eventdata, handles)
% hObject    handle to editSpinYZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSpinYZ as text
%        str2double(get(hObject,'String')) returns contents of editSpinYZ as a double


% --- Executes during object creation, after setting all properties.
function editSpinYZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSpinYZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSpinXZ_Callback(hObject, eventdata, handles)
% hObject    handle to editSpinXZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSpinXZ as text
%        str2double(get(hObject,'String')) returns contents of editSpinXZ as a double


% --- Executes during object creation, after setting all properties.
function editSpinXZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSpinXZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

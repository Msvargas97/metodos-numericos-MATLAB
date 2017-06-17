function varargout = guide_met_num(varargin)
% GUIDE_MET_NUM MATLAB code for guide_met_num.fig
%      GUIDE_MET_NUM, by itself, creates a new GUIDE_MET_NUM or raises the existing
%      singleton*.
%
%      H = GUIDE_MET_NUM returns the handle to a new GUIDE_MET_NUM or the handle to
%      the existing singleton*.
%
%      GUIDE_MET_NUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_MET_NUM.M with the given input arguments.
%
%      GUIDE_MET_NUM('Property','Value',...) creates a new GUIDE_MET_NUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_met_num_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_met_num_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_met_num

% Last Modified by GUIDE v2.5 16-Jun-2017 17:22:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_met_num_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_met_num_OutputFcn, ...
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

% --- Executes just before guide_met_num is made visible.
function guide_met_num_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_met_num (see VARARGIN)

% Choose default command line output for guide_met_num
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
        set(handles.textX1,'Visible','on');
        set(handles.editX1,'Visible','on');
        set(handles.textX1,'String','B:');
        set(handles.textX0,'String','A:');
% This sets up the initial plot - only do when we are invisible
% so window can get raised using guide_met_num.
if strcmp(get(hObject,'Visible'),'off')
    ezplot('x');
    title('');
    cla
end

% UIWAIT makes guide_met_num wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guide_met_num_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in btn1.
function btn1_Callback(hObject, ~, handles)
% hObject    handle to btn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f df An Bn Cn err Xn 
popup_sel_index = get(handles.popupmenu1, 'Value');
f = get(handles.editEcn,'String');
tol = get(handles.editTol,'String');
if isempty(tol)
    tol ='0.0001';
end
tol = str2double(tol);
x0 =  get(handles.editX0,'String');
x1 =  get(handles.editX1,'String');
if ~isempty(x0)
x0 = str2double(x0);
else
   x0 = 0.1; 
end
if ~isempty(x1)
x1 = str2double(x1);
else
   x1 = 0; 
end
if isempty(f)
f = '(600*x^4)-(550*x^3)+(200*x^2)-(20*x)-1';
set(handles.editEcn,'String',f);
end
raiz = 0;
err = [];
switch popup_sel_index
    case 1
       [raiz,err,time,f,An,Bn,Cn] = metodo_biseccion(f,x0,x1,tol);
    case 2
        [raiz,err,time,f,Xn] = metodo_secante(f,x0,x1,tol);
    case 3
        [raiz,err,time,f,df,Xn] = metodo_newton(f,x0,tol);

end

a = get(handles.editMinX,'String');
b =  get(handles.editMaxX,'String');
if ~strcmp(a,'default') && ~strcmp(b,'default')
a = str2double(a);
b = str2double(b);
else
    a = 0;
    b= 0;
end
%%Crea la grafica 
axes(handles.axes1);
cla;
plotCustom(f,raiz,a,b);
%%Muestra los resultados
format shortEng %%Formato de ingenieria
t = strtrim(evalc('disp(time)')); %%Obtiene el tiempo en formato ingenieria y elimina espacios en blanco
str = sprintf('Raiz: %.5f\nt: %s s',raiz,t);
format %%Vuelve al formato normal
set(handles.result,'String',str);

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
items = get(hObject,'String');
index_selected = get(hObject,'Value');
%display(index_selected);
switch index_selected
    case 1
        set(handles.textX1,'Visible','on');
        set(handles.editX1,'Visible','on');
        set(handles.textX1,'String','B:');
        set(handles.textX0,'String','A:');
    case 2
        set(handles.textX1,'Visible','on');
        set(handles.editX1,'Visible','on');
        set(handles.textX1,'String','X1:');
        set(handles.textX0,'String','X0:');
    case 3
        set(handles.textX1,'Visible','off');
        set(handles.editX1,'Visible','off');
        set(handles.textX0,'String','X0:');
        
end
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Metodo de Bisección', 'Metodo de la Secante', 'Metodo de Newton Rapshon'});



function editEcn_Callback(hObject, eventdata, handles)
% hObject    handle to editEcn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEcn as text
%        str2double(get(hObject,'String')) returns contents of editEcn as a double


% --- Executes during object creation, after setting all properties.
function editEcn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEcn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over editEcn.
function editEcn_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to editEcn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn2.
function btn2_Callback(hObject, eventdata, handles)
% hObject    handle to btn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
set(handles.editEcn,'String','');
set(handles.editTol,'String','');
set(handles.editX0,'String','');
set(handles.editX1,'String','');
set(handles.result,'String','');
legend(handles.axes1,'hide');
set(handles.editMinX,'String','default');
set(handles.editMaxX,'String','default');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f df An Bn Cn err Xn 
index_selected = get(handles.popupmenu1, 'Value');
h = figure;
u = uitable(h,'Position',[20 20 500 70]);
switch index_selected
    case 1
        h.Name = 'Metodo de Bisección';
        u.ColumnName = {'a','b','c','f(a)','f(b)','f(c)','error'};
        d = [An',Bn',Cn',f(An)',f(Bn)',f(Cn)',err'];
    case 2
        h.Name = 'Metodo de la Secante';
        u.ColumnName = {'Xn','f(Xn)','error'};
        d = [Xn',f(Xn)',err'];
        disp(err)
    case 3
        h.Name = 'Metodo de Newton Rapshon';
        u.ColumnName = {'Xn','f(Xn)','df(Xn)','error'};
        d = [Xn',f(Xn)',df(Xn)',err'];
end
u.Data = d; %%Asigna los datos a la tabla
%Ajusta el tamaño de la tabla y la figura
%info:https://www.mathworks.com/matlabcentral/answers/157249-how-to-change-size-of-uitable
table_extent = get(u,'Extent');
set(u,'Position',[1 1 table_extent(3) table_extent(4)])
figure_size = get(h,'outerposition');
desired_fig_size = [figure_size(1) figure_size(2) table_extent(3)+15 table_extent(4)+90];
set(h,'outerposition', desired_fig_size);

% --- Executes on key press with focus on editEcn and none of its controls.
function editEcn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to editEcn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




function editMinX_Callback(hObject, eventdata, handles)
% hObject    handle to editMinX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMinX as text
%        str2double(get(hObject,'String')) returns contents of editMinX as a double


% --- Executes during object creation, after setting all properties.
function editMinX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMinX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMaxX_Callback(hObject, eventdata, handles)
% hObject    handle to editMaxX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMaxX as text
%        str2double(get(hObject,'String')) returns contents of editMaxX as a double


% --- Executes during object creation, after setting all properties.
function editMaxX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMaxX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTol_Callback(hObject, eventdata, handles)
% hObject    handle to editTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTol as text
%        str2double(get(hObject,'String')) returns contents of editTol as a double


% --- Executes during object creation, after setting all properties.
function editTol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editX0_Callback(hObject, eventdata, handles)
% hObject    handle to editX0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX0 as text
%        str2double(get(hObject,'String')) returns contents of editX0 as a double


% --- Executes during object creation, after setting all properties.
function editX0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on popupmenu1 and none of its controls.
function popupmenu1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function editX1_Callback(hObject, eventdata, handles)
% hObject    handle to editX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX1 as text
%        str2double(get(hObject,'String')) returns contents of editX1 as a double


% --- Executes during object creation, after setting all properties.
function editX1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

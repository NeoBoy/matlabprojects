function varargout = testGui1(varargin)
% TESTGUI1 MATLAB code for testGui1.fig
%      TESTGUI1, by itself, creates a new TESTGUI1 or raises the existing
%      singleton*.
%
%      H = TESTGUI1 returns the handle to a new TESTGUI1 or the handle to
%      the existing singleton*.
%
%      TESTGUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTGUI1.M with the given input arguments.
%
%      TESTGUI1('Property','Value',...) creates a new TESTGUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testGui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testGui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testGui1

% Last Modified by GUIDE v2.5 26-Dec-2014 12:20:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testGui1_OpeningFcn, ...
                   'gui_OutputFcn',  @testGui1_OutputFcn, ...
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


% --- Executes just before testGui1 is made visible.
function testGui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testGui1 (see VARARGIN)

% Choose default command line output for testGui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testGui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testGui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%imageMat = zeros(400,400);
handles.imageObj = imageObj(400,400);
handles.figureHandle = drawImage(hObject,handles);
set(handles.figureHandle,'ButtonDownFcn',@ImageClickCallback);
guidata(hObject,handles);

function ImageClickCallback (objectHandle,eventData)
   axesHandle  = get(objectHandle,'Parent');
   coordinates = get(axesHandle,'CurrentPoint'); 
   coordinates = coordinates(1,1:2);
   disp(coordinates(1));
   disp(coordinates(2));
   %// then here you can use coordinates as you want ...
   % change the color of the pixel given by the coordinates
   handles = guidata(axesHandle);
   changeImagePixel(handles.imageObj,coordinates);
   handles.figureHandle = drawImage(objectHandle,handles);
   guidata(axesHandle,handles);
   % figure(axesHandle);
   
function figureHandle = drawImage(hObject,handles)
    imageMat = get(handles.imageObj,'imageMat');
    axes(handles.axes1);
    figureHandle = imshow(imageMat);
    set(figureHandle,'ButtonDownFcn',@ImageClickCallback);
    % guidata(hObject,handles);
   

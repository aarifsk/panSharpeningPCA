function varargout = PCA_IMAGES(varargin)
% PCA_IMAGES MATLAB code for PCA_IMAGES.fig
%      PCA_IMAGES, by itself, creates a new PCA_IMAGES or raises the existing
%      singleton*.
%
%      H = PCA_IMAGES returns the handle to a new PCA_IMAGES or the handle to
%      the existing singleton*.
%
%      PCA_IMAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCA_IMAGES.M with the given input arguments.
%
%      PCA_IMAGES('Property','Value',...) creates a new PCA_IMAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCA_IMAGES_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCA_IMAGES_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCA_IMAGES

% Last Modified by GUIDE v2.5 22-Nov-2017 15:08:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCA_IMAGES_OpeningFcn, ...
                   'gui_OutputFcn',  @PCA_IMAGES_OutputFcn, ...
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


% --- Executes just before PCA_IMAGES is made visible.
function PCA_IMAGES_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCA_IMAGES (see VARARGIN)

% Choose default command line output for PCA_IMAGES
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCA_IMAGES wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCA_IMAGES_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
pca1_img = getappdata(0,'pca1_img');
pca2_img = getappdata(0,'pca2_img');
pca3_img = getappdata(0,'pca3_img');

axes(handles.axes_pca1);
imshow(pca1_img,[]);    
axes(handles.axes_pca2);
imshow(pca2_img,[]);
axes(handles.axes_pca3);
imshow(pca3_img,[]);


varargout{1} = handles.output;

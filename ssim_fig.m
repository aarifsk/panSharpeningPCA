function varargout = ssim_fig(varargin)
% SSIM_FIG MATLAB code for ssim_fig.fig
%      SSIM_FIG, by itself, creates a new SSIM_FIG or raises the existing
%      singleton*.
%
%      H = SSIM_FIG returns the handle to a new SSIM_FIG or the handle to
%      the existing singleton*.
%
%      SSIM_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSIM_FIG.M with the given input arguments.
%
%      SSIM_FIG('Property','Value',...) creates a new SSIM_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ssim_fig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ssim_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ssim_fig

% Last Modified by GUIDE v2.5 22-Nov-2017 14:36:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ssim_fig_OpeningFcn, ...
                   'gui_OutputFcn',  @ssim_fig_OutputFcn, ...
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


% --- Executes just before ssim_fig is made visible.
function ssim_fig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ssim_fig (see VARARGIN)

% Choose default command line output for ssim_fig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ssim_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ssim_fig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
ssimval = getappdata(0,'ssim');
ssimmap = getappdata(0,'ssimmap');
diff_image = getappdata(0,'diff_image');
rmse = getappdata(0,'rmse');

axes(handles.axes_ssim);
imshow(ssimmap,[]);
title(sprintf('SSIM Index Map - Mean ssim Value is %0.2f',ssimval));

axes(handles.axes_diff);
imshow(diff_image,[]);

set(handles.txt_rmse,'string',num2str(rmse));

varargout{1} = handles.output;

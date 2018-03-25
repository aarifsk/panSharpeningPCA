function varargout = pan_sharpening_using_pca(varargin)
% PAN_SHARPENING_USING_PCA MATLAB code for pan_sharpening_using_pca.fig
%      PAN_SHARPENING_USING_PCA, by itself, creates a new PAN_SHARPENING_USING_PCA or raises the existing
%      singleton*.
%
%      H = PAN_SHARPENING_USING_PCA returns the handle to a new PAN_SHARPENING_USING_PCA or the handle to
%      the existing singleton*.
%
%      PAN_SHARPENING_USING_PCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAN_SHARPENING_USING_PCA.M with the given input arguments.
%
%      PAN_SHARPENING_USING_PCA('Property','Value',...) creates a new PAN_SHARPENING_USING_PCA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pan_sharpening_using_pca_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pan_sharpening_using_pca_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pan_sharpening_using_pca

% Last Modified by GUIDE v2.5 22-Nov-2017 18:42:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pan_sharpening_using_pca_OpeningFcn, ...
                   'gui_OutputFcn',  @pan_sharpening_using_pca_OutputFcn, ...
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


% --- Executes just before pan_sharpening_using_pca is made visible.
function pan_sharpening_using_pca_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pan_sharpening_using_pca (see VARARGIN)

% Choose default command line output for pan_sharpening_using_pca
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pan_sharpening_using_pca wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pan_sharpening_using_pca_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_getImage.
function btn_getImage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_getImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.txt_ms_img_name,'string','');
[FileName,PathName] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files'},'Select the Image file');
imagefilename = fullfile(PathName,FileName);
axes(handles.axes_image) ;


handles.ms_hs_image= double(imread(imagefilename));
handles.ms_image=  imresize(handles.ms_hs_image, 0.5, 'nearest') ;
imshow(uint8(handles.ms_image));

[r c d] =size(handles.ms_image);
str_size=strcat(num2str(r),'x',num2str(c),'x',num2str(d));
str_title=strcat({'Multispectral image of size'},{' '},{str_size});
set(handles.txt_ms_img_name,'string',str_title);

axes(handles.axes_interpolation);
[r c d] =size(handles.ms_hs_image);
str_size=strcat(num2str(r),'x',num2str(c),'x',num2str(d));
str_title=strcat({'Reference Image - High Spatial and Spectral  '},{' '},{str_size});
set(handles.txt_interpolated_image,'string',str_title);
imshow(uint8(handles.ms_hs_image));


guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function axes_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_image


% --- Executes on button press in btn_computePca.
function btn_computePca_Callback(hObject, eventdata, handles)
% hObject    handle to btn_computePca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global handles;

% [centred_matrix,mu,eigen_vector, eigen_value,Image_pca1,Image_pca2,Image_pca3,pca] = compute_pca(handles.three_band_image);
[centered_pan_image original_pca_image pca sharped ] = perform_pansharp(handles.ms_image, handles.pan_image);

handles.centered_pan_image=centered_pan_image;
handles.original_pca_image=original_pca_image;
handles.pca=pca;
handles.sharped=sharped*255;

% display eigen vector and eigen values
set(handles.txt_eigen_value,'string',num2str(pca.lambda,3));
set(handles.txt_title_eigen_value,'string','Eigen Values');
set(handles.txt_eigen_vector,'string',num2str(pca.M,3));
set(handles.txt_title_eigen_vector,'string','Eigen Vectors');


% Find correlation between pan sharped image and High resolution REference image
co_rel_red=corrcoef(handles.sharped(:,:,1),handles.ms_hs_image(:,:,1));
co_rel_green=corrcoef(handles.sharped(:,:,2),handles.ms_hs_image(:,:,2));
co_rel_blue=corrcoef(handles.sharped(:,:,3),handles.ms_hs_image(:,:,3));


% % display corelation
% set(handles.tit_corel,'string','Corelation between RGB bands of Pan sharped Image and Orginal High Resolution Image');
% 
% set(handles.txt_corel,'string',num2str(co_rel_red,2));
% set(handles.txt_cogreen,'string',num2str(co_rel_green,2));
% set(handles.txt_coblue,'string',num2str(co_rel_blue,2));

axes(handles.axes_pan_sharpened)

imshow(uint8(handles.sharped));
[r c d] =size(handles.sharped);
str_size=strcat(num2str(r),'x',num2str(c),'x',num2str(d));
str_title=strcat({'Pan sharped image of size'},{' '},{str_size});
set(handles.txt_sharpened_image,'string',str_title);

%compute SSIM
[ssimval, ssimmap] = get_ssim(handles.sharped,handles.ms_hs_image);

rmse = sqrt(immse(handles.ms_hs_image,handles.sharped));

set(handles.txt_ssim_val,'string',num2str(ssimval));
set(handles.txt_rmse,'string',num2str(rmse));

% figure;imshow(uint8(handles.ms_hs_image - handles.sharped));title('difference');
% figure;imshow(uint8(handles.ms_hs_image));title('original');
% figure;imshow(uint8(handles.sharped));title('sharped');
imwrite(sharped,'output.jpg')
guidata(hObject, handles);


% --- Executes on button p      ress in btn_show_pca.
function btn_show_pca_Callback(hObject, eventdata, handles)
% hObject    handle to btn_show_pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pca1_img=handles.original_pca_image(:,:,1)*255;
pca2_img=handles.original_pca_image(:,:,2)*255;
pca3_img=handles.original_pca_image(:,:,3)*255;
setappdata(0,'pca1_img',pca1_img);
setappdata(0,'pca2_img',pca2_img);
setappdata(0,'pca3_img',pca3_img);
PCA_IMAGES;



% --- Executes on button press in btn_getpanimage.
function btn_getpanimage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_getpanimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.txt_pan_img_name,'Visible','off');

[FileName,PathName] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files'},'Select the Image file');
imagefilename = fullfile(PathName,FileName);
axes(handles.axes_pan) ;

handles.hs_pan_image= double(imread(imagefilename));
handles.pan_image= imresize(handles.hs_pan_image,0.5,'nearest');

imshow(uint8(handles.pan_image));
% set(handles.txt_pan_img_name,'string',FileName);
[r c] =size(handles.pan_image);
str_size=strcat(num2str(r),'x',num2str(c));
str_title=strcat({'Panchromatic image of size'},{' '},{str_size});
set(handles.txt_pan_img_name,'Visible','on');
set(handles.txt_pan_img_name,'string',str_title);

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function axes_interpolation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_interpolation


% --- Executes on button press in btn_showssimmap.
function btn_showssimmap_Callback(hObject, eventdata, handles)
% hObject    handle to btn_showssimmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ssimval, ssimmap] = get_ssim(handles.sharped,handles.ms_hs_image);
% fprintf('The SSIM value is %0.4f.\n',ssimval);
% figure, imshow(ssimmap,[]);
diff_image=handles.ms_hs_image-handles.sharped;
rmse = sqrt(immse(handles.ms_hs_image,handles.sharped));

setappdata(0,'ssim',ssimval);
setappdata(0,'ssimmap',ssimmap);
setappdata(0,'diff_image',diff_image);
setappdata(0,'rmse',rmse);




ssim_fig;


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Consolidated Octave script for image processing tasks

% Function to import and display images from a directory
function import_and_display_images(directory)
    % Check if directory argument is provided
    if nargin < 1 || isempty(directory)
        disp('Error: Directory argument is missing or empty.');
        return;
    end

    % Check if the directory exists
    if ~isfolder(directory)
        disp(['Error: Directory ', directory, ' does not exist.']);
        return;
    end

    % Supported image file extensions
    extensions = {'*.png', '*.jpeg', '*.jpg', '*.bmp', '*.webp'};

    % Initialize an empty list for image files
    image_files = [];

    % Loop through each extension and gather image files
    for ext = extensions
        image_files = [image_files; dir(fullfile(directory, ext{1}))];
    end

    % Check if there are any image files
    if isempty(image_files)
        disp('No image files found in the specified directory.');
        return;
    else
        disp(['Found ', num2str(length(image_files)), ' image files.']);
    end

    % Loop through each image file
    for i = 1:length(image_files)
        filename = image_files(i).name;
        try
            % Read the image
            img = imread(fullfile(directory, filename));

            % Display the image with different colormaps
            figure;
            subplot(2,2,1); imshow(img); title('Original');
            subplot(2,2,2); imshow(rgb2gray(img)); title('Grayscale');
            subplot(2,2,3); imagesc(img); colormap('hot'); colorbar; title('Hot Colormap');
            subplot(2,2,4); imagesc(img); colormap('jet'); colorbar; title('Jet Colormap');
        catch err
            disp(['Error reading image: ' filename]);
            disp(err.message);
            continue;
        end
    end
end




% Function to resize an image while maintaining aspect ratio
function resize_image(img, new_width)
    [height, width, ~] = size(img);
    new_height = round(height * new_width / width);
    resized_img = imresize(img, [new_height new_width]);
    figure;
    subplot(1, 2, 1);
    imshow(img);
    title('Original Image');
    subplot(1, 2, 2);
    imshow(resized_img);
    title('Resized Image');
end

% Function to convert an image to different grayscale methods
function convert_to_grayscale(img)
    gray_avg = mean(img, 3);
    gray_lum = 0.299*img(:,:,1) + 0.587*img(:,:,2) + 0.114*img(:,:,3);
    gray_desat = (max(img, [], 3) + min(img, [], 3)) / 2;
    figure;
    subplot(2, 2, 1);
    imshow(img);
    title('Original Image');
    subplot(2, 2, 2);
    imshow(gray_avg);
    title('Average Grayscale');
    subplot(2, 2, 3);
    imshow(gray_lum);
    title('Luminosity Grayscale');
    subplot(2, 2, 4);
    imshow(gray_desat);
    title('Desaturation Grayscale');
end

% Function to crop an image to a specific region of interest
function cropped_img = crop_image(img, top_left, bottom_right)
    cropped_img = img(top_left(2):bottom_right(2), top_left(1):bottom_right(1), :);
    figure;
    subplot(1, 2, 1);
    imshow(img);
    title('Original Image');
    subplot(1, 2, 2);
    imshow(cropped_img);
    title('Cropped Image');
end

% Function to resize an image using different interpolation methods
function resized_image = resize_image_with_interpolation(image, new_width, new_height, method)
    switch method
        case "nearest"
            resized_image = imresize(image, [new_height, new_width], "nearest");
        case "bilinear"
            resized_image = imresize(image, [new_height, new_width], "bilinear");
        case "bicubic"
            resized_image = imresize(image, [new_height, new_width], "bicubic");
        otherwise
            error("Invalid interpolation method");
    end

    figure;
    subplot(1, 2, 1);
    imshow(image);
    title("Original Image");

    subplot(1, 2, 2);
    imshow(resized_image);
    title(strcat("Resized Image - ", method));
end

% Function to rotate an image by a specified angle
function rotated_img = rotate_image(img, angle)
    rotated_img = imrotate(img, angle, 'bilinear', 'crop');
    figure;
    subplot(1, 2, 1);
    imshow(img);
    title('Original Image');
    subplot(1, 2, 2);
    imshow(rotated_img);
    title('Rotated Image');
end

% Function to download and display images from URLs
function display_images_from_urls(urls)
    % Loop through the URLs and download the images
    for i = 1:length(urls)
        try
            % Download the image
            [image_data, status] = urlread(urls{i});
            if status == 0
                error('Failed to download image.');
            end

            % Determine the image format from the URL extension
            [~, name, ext] = fileparts(urls{i});
            ext = lower(ext);

            % Check if the format is supported
            if ~any(strcmp(ext, {'.jpg', '.jpeg', '.png', '.bmp'}))
                error('Unsupported image format.');
            end

            % Save the image locally
            image_path = strcat(name, ext);
            fid = fopen(image_path, 'w');
            fwrite(fid, image_data);
            fclose(fid);

            % Display the image
            img = imread(image_path);
            figure;
            imshow(img);
            title(['Image from URL: ', urls{i}]);
        catch err
            % Handle any errors that occur during the download process
            disp(['Error downloading image from URL: ', urls{i}, ' - ', err.message]);
            continue;
        end
    end
end


% Define the function
function captured_image = capture_image_with_adjustments(device_id)
    % Open the camera device
    cam = video_capture(device_id);

    % Set initial brightness and contrast values
    initial_brightness = 50;  % Example: initial brightness value (0-100)
    initial_contrast = 70;    % Example: initial contrast value (0-100)

    % Set initial brightness and contrast
    cam.brightness = initial_brightness;
    cam.contrast = initial_contrast;

    % Allow a short pause for adjustments to take effect
    pause(2);  % Adjust this pause duration as needed

    % Capture the image with current settings
    captured_image = snapshot(cam);

    % Release camera resources
    release(cam);
end



% Function to load images with different color spaces and display them
function load_and_display_images(image_files)
    for i = 1:length(image_files)
        try
            % Read the image
            img = imread(image_files{i});

            % Display the image with different color spaces
            figure;
            subplot(1, 3, 1);
            imshow(img);
            title('RGB Color Space');

            subplot(1, 3, 2);
            imshow(rgb2gray(img));
            title('Grayscale');

            subplot(1, 3, 3);
            imshow(hsv2rgb(rgb2hsv(img)));
            title('HSV Color Space');
        catch
            disp(['Error reading image: ' image_files{i}]);
            continue;
        end
    end
end

% Function to extract and display metadata from an image
function display_image_metadata(img)
    info = imfinfo(img);
    creation_date = info.DateTime;
    resolution = [info.Width, info.Height];
    color_space = info.ColorType;

    disp(['Creation Date: ' creation_date]);
    disp(['Resolution: ' num2str(resolution)]);
    disp(['Color Space: ' color_space]);
end

% Function to adjust pixel values of an image using scaling and offset
function adjusted_img = adjust_pixels(img, scale, offset)
    adjusted_img = img * scale + offset;
    figure;
    subplot(1, 2, 1);
    imshow(img);
    title('Original Image');
    subplot(1, 2, 2);
    imshow(adjusted_img);
    title('Adjusted Image');
end

% Main script begins here
% Load the image package
pkg load image;
pkg load video_capture_package  % Load the video_capture_package

% Define the image filename in the current directory
image_filename = 'Image.png';

% Question 1: Import and display images with different colormaps
%import_and_display_images(pwd);  % Use the current directory for image import
import_and_display_images('C:\Users\hp\Downloads\Picture');

% Question 2: Resize an image while maintaining aspect ratio
img = imread(image_filename);
resize_image(img, 300);

% Question 3: Convert an image to different grayscale methods
img = imread(image_filename);
convert_to_grayscale(img);

% Question 4: Crop an image to a specific region of interest
img = imread(image_filename);
crop_image(img, [50, 50], [300, 300]);

% Question 5: Resize an image using different interpolation methods
img = imread(image_filename);
resize_image_with_interpolation(img, 400, 300, "nearest");
resize_image_with_interpolation(img, 400, 300, "bilinear");
resize_image_with_interpolation(img, 400, 300, "bicubic");

% Question 6: Rotate an image by a specified angle
img = imread(image_filename);
rotate_image(img, 45);

% Question 7: Download and display images from URLs
% Example usage:
urls = {
    'https://images.pexels.com/photos/5641889/pexels-photo-5641889.jpeg',
    'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg'
};
display_images_from_urls(urls);

% Question 8: Capture images from a connected camera device

% Call the function with device ID 1 (replace with your actual device ID)
captured_image = capture_image_with_adjustments(1);

% Display the captured image
imshow(captured_image);
title('Captured Image');

% Question 9: Load images with different color spaces and display them
image_files = {'Image.png'};  % Replace with your image filenames
load_and_display_images(image_files);

% Question 10: Display metadata from an image
image_filename_metadata = 'Image.png';  % Replace with your image filename
display_image_metadata(image_filename_metadata);

% Question 11: Adjust pixel values of an image using scaling and offset
img = imread(image_filename);
adjust_pixels(img, 1.5, 20);  % Scale by 1.5 and offset by 20




function eng = computeEngGrad(im, F)
    % Input: Colour image im and filter F
    % Output: gray scale image eng
    % eng = gradient magnitude of the input image
    % Compute the horizontal gradient component based on filter F and the
    % vertical gradient component based on the transpose of F
    
    % Convert im to grayscale
    imG = (im(:, :, 1) + im(:, :, 2) + im(:, :, 3)) ./ 3;
    %imG = mean(im, 3);
    
    % Compute energy image
    eng = sqrt(abs(applyFilter(imG, F)).^2 + (abs(applyFilter(imG, F.'))).^2);
end
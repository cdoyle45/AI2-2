function [totalCost, imOut] = intelligentResize(im, v, h, W, mask, maskWeight)
    % Input: Colour image im, number of vertical seams to process v, number
    % of horizontal seams to process h, weight vector W for the colour
    % energy, and the mask image and its weight maskWeight
    % Output: Sum of all the seams carved and the output carved colour img
    % Filter for gradient energy
    F = [ -1 0 1];
    % If mask is 0, create a blank mask the size of the image
    if mask == 0
        mask = zeros(size(im));
    end
    % Create 4channel image by concatenating the colour image with its mask
    im4 = cat(3, im, mask);
    % Initialize total cost
    totalCost = 0;
    
    % Seam adding or removal?
    % Horizontal
    if h < 0
        h_rm = true;
        h_count = abs(h);
    else
        h_rm = false;
        h_count = h;
    end
    
    % Vertical
    if v < 0
        v_rm = true;
        v_count = abs(v);
    else
        v_rm = false;
        v_count = v;
    end
    im4Intermediate = im4;
    
    while (h_count ~= 0 || v_count ~= 0)
         % Energy
         E = computeEng(im4Intermediate, F, W, maskWeight);
         % Horizontal
         if h_count ~= 0
             if h_rm == true
                 [~, im4Out, c] = reduceHeight(im4Intermediate, E);
                 totalCost = totalCost + c;
                 im4Intermediate = im4Out;
             elseif h_rm == false
                 [~, im4Out, c] = increaseHeight(im4Intermediate, E);
                 totalCost = totalCost + c;
                 im4Intermediate = im4Out;
                 
             end
             h_count = h_count - 1;
         end
         % Energy
         E = computeEng(im4Intermediate, F, W, maskWeight);
         % Vertical
         if v_count ~= 0
             if v_rm == true
                 [~, im4Out, c] = reduceWidth(im4Intermediate, E);
                 totalCost = totalCost + c;
                 im4Intermediate = im4Out;
             elseif v_rm == false
                 [~, im4Out, c] = increaseWidth(im4Intermediate, E);
                 totalCost = totalCost + c;
                 im4Intermediate = im4Out;
             end
             v_count = v_count - 1;
         end
    end
    imOut = im4Intermediate(:, :, 1:3);
end
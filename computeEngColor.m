function eng = computeEngColor(im, W)
    % Input: Colour image im, vector W of size 3 for colour based energy
    % Output: Colour-based energy image eng
    % W gives the weights for the colour components
    
    eng = (W(1) .* im(:, :, 1)) + (W(2) .* im(:, :, 2)) + (W(3) .* im(:, :, 3));
end
function [seam, im4Out, c] = increaseHeight(im4, E)
    % Increases the width of the image by adding one row
    im4Transposed = permute(im4, [2 1 3]);
    [seam, im4OutTransposed, c] = increaseWidth(im4Transposed, E.');
    im4Out = permute(im4OutTransposed, [2 1 3]);
end
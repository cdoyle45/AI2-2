function [seam, im4Out, c] = reduceHeight(im4, E)
    % Reduces the height of the image by removing one row
    im4Transposed = permute(im4, [2 1 3]);
    [seam, im4OutTransposed, c] = reduceWidth(im4Transposed, E.');
    im4Out = permute(im4OutTransposed, [2 1 3]);
end
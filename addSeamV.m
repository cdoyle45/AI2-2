function imOut = addSeamV(im4, seam)
    % Input: 4channel image im4, vertical seam
    % Output: im4 with the seam added
    
    % Intialize separated 4 channels for imOut
    imOut_R = ones(size(im4(:, :, 1), 1), (size(im4(:, :, 1), 2) + 1));
    imOut_G = ones(size(im4(:, :, 2), 1), (size(im4(:, :, 2), 2) + 1));
    imOut_B = ones(size(im4(:, :, 3), 1), (size(im4(:, :, 3), 2) + 1));
    imOut_M = ones(size(im4(:, :, 4), 1), (size(im4(:, :, 4), 2) + 1));

    % Separate channels for im4
    im_R = im4(:, :, 1);
    im_G = im4(:, :, 2);
    im_B = im4(:, :, 3);
    im_M = im4(:, :, 4);
    % Looping through every row (because length of seam = # in im4)
    for i = 1:1:size(seam, 1)
        % Assign values in imOut to values from im4 except removed value
        imOut_R(i, :) = im_R(i, [1:seam(i), seam(i):end]);
        imOut_G(i, :) = im_G(i, [1:seam(i), seam(i):end]);
        imOut_B(i, :) = im_B(i, [1:seam(i), seam(i):end]);
        imOut_M(i, :) = im_M(i, [1:seam(i), seam(i):end]);
    end
    
    % Joining together imOut
    imOut = cat(3, imOut_R, imOut_G, imOut_B, imOut_M);
end
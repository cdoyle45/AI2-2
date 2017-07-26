%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Performs foreground/background segmentation based on a graph cut
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUT: image im and scribbleMask with scribbles
% scribbleMask(i,j) = 2 means pixel(i,j) is a foreground seed
% scribbleMask(i,j) = 1 means pixel(i,j) is a background seed
% scribbleMask(i,j) = 0 means pixel(i,j) is not a seed
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OUTPUT: segm is the segmentation mask of the  same size as input image im
% segm(i,j) = 1 means pixel (i,j) is the foreground
% segm(i,j) = 0 means pixel (i,j) is the background
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function segm  = segmentGC(im,scribbleMask)
    
    horz1 = im(2:end, :, :);
    horz2 = im(1:end-1, :, :);
    horzEdges = (horz1 - horz2).^2;
    horzEdges = sum(horzEdges, 3);
    
    vert1 = im(:, 2:end, :);
    vert2 = im(:, 1:end-1, :);
    vertEdges = (vert1 - vert2).^2;
    vertEdges = sum(vertEdges, 3);
    
    sigma = (mean(horzEdges(:))+ mean(vertEdges(:))) / 2;
    
    horzEdges = exp(-horzEdges / (2 * sigma));
    vertEdges = exp(-vertEdges / (2 * sigma));
    
    W = ones((numel(horzEdges) + numel(vertEdges)), 3);
    w_count = 1;
    for y = 1:1:size(horzEdges, 2)
        for x = 1:1:size(horzEdges, 1)
            p = x + (y - 1) * size(im, 1);
            q = p + 1;
            
            W(w_count, :) = [ p q horzEdges(x, y)];
            w_count = w_count + 1;
        end
    end
    
    for y = 1:1:size(vertEdges, 2)
        for x = 1:1:size(vertEdges, 1)
            p = x + ((y - 1) * size(im, 1));
            q = x + (y * size(im, 1));
            
            W(w_count, :) = [ p q vertEdges(x, y)];
            w_count = w_count + 1;
        end
    end
    
    W = [W; [W(:, 2) W(:, 1) W(:, 3)]];
    
    d_bg = dFactory(im, scribbleMask, 1, 4);
    d_fg = dFactory(im, scribbleMask, 2, 4);
    
    d_bg = d_bg/max(d_bg) * max(W(:, 3));
    d_fg = d_fg/max(d_fg) * max(W(:, 3));
    
    d_bg(scribbleMask == 1) = 0;
    d_bg(scribbleMask == 2) = 100;
    d_fg(scribbleMask == 2) = 0;
    d_fg(scribbleMask == 1) = 100;
    
    segm = reshape(solveMinCut(d_bg, d_fg, W), size(im, 1), size(im, 2));
end


function D = dFactory(im, scribbleMask, thing, ignoreBitz)
    im_cut = floor(im / 2^ignoreBitz) + 1;
    
    histogram = ones(2^(8-ignoreBitz), 2^(8-ignoreBitz), 2^(8-ignoreBitz));
    
    for x = 1:1:size(scribbleMask, 1)
        for y = 1:1:size(scribbleMask, 2)
            if scribbleMask(x, y) == thing
                pixel = im_cut(x, y, :);
                histogram(pixel(1), pixel(2), pixel(3)) = histogram(pixel(1), pixel(2), pixel(3)) + 1;
            end
        end
    end
    
    % Normalize
    histogram = histogram / sum(histogram(:));
    negLog = -log(histogram);
    
    % Calculating D
    D = ones(1, (size(im, 1) * size(im, 2)));
    i = 1;
    for y = 1:1:size(im_cut, 2)
        for x = 1:1:size(im_cut, 1)
            pixel = im_cut(x, y, :);
            value = negLog(pixel(1), pixel(2), pixel(3));
            D(i) = value;
            i = i + 1;
        end
    end
end
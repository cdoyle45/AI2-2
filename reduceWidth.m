function [seam, im4Out, c] = reduceWidth(im4, E)
    % Input: 4channel image im4, and its corresponding energy image E
    % Output: Removed seam, its cost, and im4 reduced in size by 1 column
    
    % Get M, P for E
    [M, P] = seamV_DP(E);
    % Find the best seam and its cost
    [seam, c] = bestSeamV(M, P);
    % Remove the seam from im4
    im4Out = removeSeamV(im4, seam);    
end
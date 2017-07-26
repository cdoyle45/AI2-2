function [seam, im4Out, c] = increaseWidth(im4, E)
    % Input: 4channel image im4, and its corresponding energy image E
    % Output: Added seam, its cost, and im4 increased in size by 1 column
    
    % Get M, P for E
    [M, P] = seamV_DP(E);
    % Find the best seam and its cost
    [seam, c] = bestSeamV(M, P);
    % Add the seam to im4
    im4Out = addSeamV(im4, seam);
    
end
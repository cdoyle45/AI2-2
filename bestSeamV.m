function [seam, c] = bestSeamV(M, P)
    % Input: Arrays M, P
    % Output: The best seam and its cost c
    
    % Seam is the same number of rows as M and P
    seam = zeros(size(M, 1), 1);
    
    % Starting at bottom row...
    smallest = inf;
    for i = 1:1:size(M, 2)
        current = M(size(M, 1), i);
        if current <= smallest
            smallest = current;
            seam(size(M, 1), 1) = i;
        end
    end
    
    c = M(size(M, 1), seam(size(seam, 1)));
    
%     for i = size(seam, 1):-1:2
%         seam(i-1, 1) = P(i-1, seam(i));
%     end
    for i = (size(seam, 1)-1):-1:1
        seam(i, 1) = P(i+1, seam(i+1));
    end
end
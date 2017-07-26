function [M, P] = seamV_DP(E)
    % Input: Gray scale energy image E
    % Output: Arrays M and P constructed during dynamic programming for
    % finding the optimal vertical seam
    % If during dynamic programming the smallest cost path is not unique,
    % choose the leftmost column for the path
    
    M = zeros(size(E));
    P = zeros(size(E));
    option1 = 0;
    option2 = 0;
    option3 = 0;
    
    % Initialization step
    for c = 1:1:size(E, 2)
        M(1, c) = E(1, c);
        P(1, c) = 0;
    end
    
    % Iteration step
    for r = 2:1:size(E, 1)
        for c = 1:1:size(E, 2)
            
            if c == 1
                option1 = inf;
                option2 = M(r-1, c);
                option3 = M(r-1, c+1);
            elseif c == size(E, 2)
                option1 = M(r-1, c-1);
                option2 = M(r-1, c);
                option3 = inf;
            else
                option1 = M(r-1, c-1);
                option2 = M(r-1, c);
                option3 = M(r-1, c+1);
            end
            if option1 <= option2 && option1 <= option3
                M(r, c) = E(r, c) + M(r-1, c-1);
                P(r, c) = c-1;
            elseif option2 <= option1 && option2 <= option3
                M(r, c) = E(r, c) + M(r-1, c);
                P(r, c) = c;
            else
                M(r, c) = E(r, c) + M(r-1, c+1);
                P(r, c) = c+1;
            end
        end
    end
end
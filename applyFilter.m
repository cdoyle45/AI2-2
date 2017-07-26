function outIm = applyFilter(im, F)
    %outIm = F correlate im
    
    kx = (size(F, 1) - 1)/2;
    ky = (size(F, 2) - 1)/2;
    
    loopingx = -kx:kx;
    loopingy = -ky:ky;
    
    avg = sum(im(:)) / (size(im, 1) * size(im, 2));
    
    % Initialize matrix of ones
    outIm = ones(size(im, 1));
    
    % Padded matrix
    im_padded = padarray(im, [kx ky], avg);
    
    % Looping through x values of padded matrix
    for x = (1+kx):1:(size(im_padded, 1) - kx)
        % Looping through y values of padded matrix
        for y = (1+ky):1:(size(im_padded, 2) - ky)
            % Initialize the value for the current matrix cell as 0
            value = 0;
            
                % Looping from -kx to kx
                for i = loopingx(1):1:loopingx(end)
                    % Looping from -ky to ky
                    for j = loopingy(1):1:loopingy(end)
                        % Value += F*im
                        value = value + (F(i+kx+1, j+ky+1) .* im_padded(x+i, y+j));
                    end
                end
                
            % Assigning the value in the resulting matrix
            outIm((x-kx), (y-ky)) = value;
        end
    end
end
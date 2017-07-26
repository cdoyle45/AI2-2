function eng = computeEng(im4, F, W, maskW)
    % Input: 4channel image im4, filter F to use for gradient energy,
    % weight vector W to use for colour energy, and weight of mask weightW
    % Output: energy for seam carving that is the sum of gradient, colour,
    % and mask energies
    
    eng = computeEngGrad(im4(:, :, 1 : 3), F) + computeEngColor(im4(:, :, 1 : 3), W) + maskW * im4(:, :, 4);
end


% Software: Eigenface classification
% Author: Hy Truong Son
% Position: PhD Student
% Institution: Department of Computer Science, The University of Chicago
% Email: sonpascal93@gmail.com, hytruongson@uchicago.edu
% Website: http://people.inf.elte.hu/hytruongson/
% Copyright 2016 (c) Hy Truong Son. All rights reserved.

function [] = example_eigenface_classification()
    % Constants
    nRows = 112;
    nCols = 92;

    % Load the pre-processed database
    load('data.mat', 'X', 'label');
    
    % PCA computation
    % Normal PCA computation with computing the covariance matrix
    [X, V, d, mean] = PCA(X, 'pca.mat'); 
    
    % Computation of PCA by Singular Value Decomposition
    % [X, V, d, mean] = PCA_SVD(X, 'pca_svd.mat');
    
    % Sort the eigenvalues in the increasing order
    n = size(d, 1);
    for i = 1 : n / 2
        if d(i) < d(n - i + 1)
            temp = V(:, i);
            V(:, i) = V(:, n - i + 1);
            V(:, n - i + 1) = temp(:);

            temp = d(i);
            d(i) = d(n - i + 1);
            d(n - i + 1) = temp;
        end
    end
    
    figure(1);
    imshow(matrix2image(vector2matrix(mean, nRows, nCols)));
    title('The mean face');
    
    figure(2);
    k = 40;
    title(['The first ', int2str(k), ' principal components (eigenfaces)']);
    for i = 1 : k
        subplot(4, 10, i);
        imshow(matrix2image(vector2matrix(V(:, i), nRows, nCols)));
        title(['i = ', int2str(i)]);
    end
    
    % PCA compression
    threshold = 0.90;
    [X, V, d] = PCA_compress(X, V, d, threshold);
    
    % Nearest neighbor
    nCorrects = 0;
    nSamples = size(X, 2);
    
    for sample = 1 : nSamples
        fprintf('Sample %d: ', sample);
        
        % Nearest-neighbor algorithm
        predict = 0;
        min_dist = 0.0;
        for i = 1 : nSamples
            if i ~= sample
                if predict == 0
                    predict = label(i);
                    min_dist = norm(X(:, i) - X(:, sample), 2);
                else
                    dist = norm(X(:, i) - X(:, sample), 2);
                    if dist < min_dist
                        min_dist = dist;
                        predict = label(i);
                    end
                end
            end
        end
        
        % Check the classification
        if predict == label(sample)
            nCorrects = nCorrects + 1;
            fprintf('YES\n');
        else
            fprintf('NO\n');
        end
    end
    
    fprintf('Classification result: %d/%d = %.2f percent\n', nCorrects, nSamples, double(nCorrects) / nSamples * 100.0);
end
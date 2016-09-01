% Software: Principal Component Analysis by Singular Value Decomposition
% Author: Hy Truong Son
% Position: PhD Student
% Institution: Department of Computer Science, The University of Chicago
% Email: sonpascal93@gmail.com, hytruongson@uchicago.edu
% Website: http://people.inf.elte.hu/hytruongson/
% Copyright 2016 (c) Hy Truong Son. All rights reserved.

function [A, eigenvectors, eigenvalues, mean] = PCA_SVD(X, output_fn)
    %% Constants
    % Dimension of each sample
    d = size(X, 1);
    
    % Number of samples
    n = size(X, 2);
    
    %% Normalize the data and subtract the whole database by the mean sample
    fprintf('Normalize the image database\n');
    range = max(max(double(X))) - min(min(double(X)));
    X = double(X) / range;
    
    fprintf('Subtract the whole database by the mean sample\n');
    [A, mean] = mean_subtract(double(X));
    
    %% Singular Value Decomposition - SVD
    fprintf('Singular Value Decomposition\n');
    [eigenvectors, S, V] = svd(A);
    eigenvectors = normalize(eigenvectors);
    eigenvalues = diag(S);
end
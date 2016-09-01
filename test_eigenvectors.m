% Software: Principal Component Analysis
% Author: Hy Truong Son
% Position: PhD Student
% Institution: Department of Computer Science, The University of Chicago
% Email: sonpascal93@gmail.com, hytruongson@uchicago.edu
% Website: http://people.inf.elte.hu/hytruongson/
% Copyright 2016 (c) Hy Truong Son. All rights reserved.

function [] = test_eigenvectors()
    % Matrix size
    n = 512;
    
    % Randomize the matrix
    A = rand(n, n);
    
    % Make the matrix become positive semi-definite
    A = A' * A;
    
    % Find the right eigenvectors, left eigenvectors, and eigenvalues of A
    [R, D, L] = eig(A);
    
    % D is the diagonal matrix that contains all the eigenvalues of A
    % R is the right eigenvectors of A such that: A * R = R * D
    % L is the left eigenvectors of A such that: L' * A = D * L'
    
    fprintf('||A * R - R * D|| = %.6f\n', sum(sum(abs(A * R - R * D))));
    fprintf('||L^T * A - D * L^T|| = %.6f\n', sum(sum(abs(L' * A - D * L'))));
    
    % Testing the PCA theorem:
    % A = \sum\limits_i \lambda_i u_i u_i^T, where \lambda_i is the i-th
    % eigenvalues and u_i is the i-th corresponding eigenvectors.
    
    fprintf('||A - R * D * R^T|| = %.6f\n', sum(sum(abs(A - R * D * R'))));
    fprintf('||A - L * D * L^T|| = %.6f\n', sum(sum(abs(A - L * D * L'))));
    
    B = zeros(n, n);
    for i = 1 : n
        lambda = D(i, i);
        u = R(:, i);
        B = B + lambda * (u * u');
    end
    
    fprintf('Testing the PCA theorem: Difference = %.6f\n', sum(sum(abs(A - B))));
end
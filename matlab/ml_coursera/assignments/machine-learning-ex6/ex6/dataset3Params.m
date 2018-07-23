function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% Let's try multiple guesses for C, sigma. Increasing C decreases bias; increasing sigma increases bias.

C_range = [.01 .03 .1 .3 1 3 10 30];
sigma_range = [.01 .03 .1 .3 1 3 10 30];

% Also let's make grid for us to put our errors in - rows are C, cols are sigma

err_grid = zeros(8,8);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

for i = [1:8]
  for j = [1:8]
    C = C_range(i);
    sigma = sigma_range(j);
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    predictions = svmPredict(model, Xval);
    err_grid(i,j) = mean(double(predictions ~= yval));
  end
end

%err_grid has all the err values. Now we find the indices of the smallest one
[M,I] = min(err_grid(:));
[I_row, I_col] = ind2sub(size(err_grid),I);

C = C_range(I_row);
sigma = sigma_range(I_col);

% =========================================================================

end

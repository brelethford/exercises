function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

%f,z for use in (j>1) cases
f=ones(size(theta));
f(1)=0;
z=eye(length(theta));
z(1,1)=0;

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

h =  X*theta;

J = (1/(2*m))*sum(((X*theta)-y).^2) + transpose(f)*(lambda/(2*m))*theta.^2;
    
grad=(1/m)*transpose(X)*(h-y)+z*(lambda/(m))*theta;











% =========================================================================

grad = grad(:);

end

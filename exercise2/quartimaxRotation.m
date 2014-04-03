function [B, J_rots] = quartimaxRotation (A)
%Perform quartimax rotation on matrix A so that it is as sparse as
%possible

mu = .01;% the learning rate

[rowN, colN] = size(A);

U = rand (colN, colN); %some random initialization
U = sqrtm(inv(U * U')) * U; %make it orthogonal

V = A * U;
J_rot_old = sum(sum(V .^ 4)); 
J_rots = [];

while 1

    D = 4 * A' * ((A * U ) .^ 3); % getting the derivatives, which
                                  % is a shorter and faster way to
                                  % say the following for loop
    
    
    %D = zeros (colN, colN); %the direvative matrix
    %for n = 1:colN
    %for m = 1: colN
    %D (n,m) = 4 * A (:, n)' * ((A * U (:, m)) .^ 3);
    %end
    %end

    U = U + mu * D;
    U = sqrtm(inv(U * U')) * U; %make it orthogonal using the
                                %symmetric orthogonalization method

    V = A * U;
    J_rot_new = sum(sum(V .^ 4));

    if max (abs((J_rot_old - J_rot_new) ./ J_rot_old)) < eps %converge
        break
    end
    J_rots  = [J_rots, J_rot_old];
    J_rot_old = J_rot_new;
end

B = A * U;

    
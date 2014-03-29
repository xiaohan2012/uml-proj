function [data] = gendata (mu, sigma, N)
%generate `N` 2D multivariate normal random numbers, where the
%multivariate normal parameters are defined by `mu`, the mean and
%`sigma`, the covariance matrix

%Returns:
%N by d (length(mu)) matrix

if length(mu) ~= 2
    disp (sprintf('mu leagth should be 2, but here is %d', length (mu)));
    return
end

if ~ all(size (sigma) == [2 2])
    disp (sprintf('signma leagth should be 2 by 2, but here is %d by %d', size ...
                  (sigma, 1), size (sigma, 2)));
    return
end
    
data = mvnrnd (mu, sigma, N);
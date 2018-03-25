function [ high_res ] = upsample_ms( low_res,high_res )
% First resize the multispectral image to same size as the Panchromatic image by replicating values(nearest neighbour)

[m, n, d] = size(low_res);
[hm, hn] = size(high_res);

high_res = zeros([hm, hm, d]);

for j = 1 : hm
    for k = 1 : hn
        high_res(j, k, :) = low_res( ceil(j/2), ceil(k/2), :);
    end
end

end
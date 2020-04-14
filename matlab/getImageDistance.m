function [dist] = getImageDistance(hist1, hist2, method)

if method == "chi2"
%     disp(size(hist1))
%     disp(size(hist2))
    s = hist2 + hist1;    d = hist2 - hist1;
    dist = sum( d.^2 ./ (s+eps), 2 );
    dist = dist/2;
else
    dist=pdist2(hist1,hist2,method);
end
end
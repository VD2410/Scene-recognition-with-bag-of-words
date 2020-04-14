function [points] = getRandomPoints(I, alpha)

points = zeros(alpha,2);
for i= 1:alpha
    
    points(i,1) = randi([1 size(I,1)]);
    points(i,2) = randi([1 size(I,2)]);
    
    
end

% 
% if show == 1
%     figure;
%     imshow(I);
%     hold on;
%     % Plot cross at row 100, column 50
%     plot(points, 'r+', 'MarkerSize', 1, 'LineWidth', 1);
% end

end

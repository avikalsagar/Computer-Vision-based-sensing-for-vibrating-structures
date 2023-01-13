v = [20.107 28.1644; 20.1436 28.2011; 20.1802 28.2644; 20.107 28.1644]
for i=1:2
    v(:, i) = v(:, i)/v(1, i);
end

Floor = [0;1;2;3];
for i =1:2
    subplot(1, 2, i)
    plot([v(:,i)], Floor);
    ylabel('Floor of the structure', 'FontSize', 12);
    xlabel(['Normalized natural freq of mode shape', num2str(i)], 'FontSize', 12);
    title(['Mode Shape', num2str(i)], 'FontSize',18);
end
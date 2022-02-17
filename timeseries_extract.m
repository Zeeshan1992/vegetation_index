% Given the stacked matrix C with dimension
% 200 x 200 x 108 the following commands extracts
% and plots time series of NDVI index for each of the
% pixels in row 163 to row 1 in column 100.

k0 = 5;
img_matrice(200,200) = 0;
v = zeros(1,n);
vm = zeros(1,n);
for j = 1:200
    for k = 1:175
        % Extract time-series
        noise = 0;
        for i = 1:n
            v(i) = C(j,k,i);
            n1 = max(1,i-k0); % left window point >= 1
            n2 = min(n,i+k0); % right window point <= n
            vm(i) = mean(v(n1:n2)); % take the mean in the window 
            noise = noise + abs(vm(i) - v(i));
        end
        avg = mean(v);
        %fprintf("Noise: %i\n", noise);
        for i = 30:70     % The time period where the middle of season starts
            if avg > 145  % Check whether the pixel is on land
                if noise < 1000 % check if too noisy
                    if v(i) >= avg % season starts when v >= avg
                        img_matrice(j,k) = i;
                    end
                else
                    img_matrice(j,k) = 30;
                end
            else
                img_matrice(j,k) = 0; 
            end
        end
%         t = 1:108;
%         plot(v), hold on
%         plot(vm,'r'), hold on
%         plot([t(1),t(end)],[avg,avg],'r')
%         grid on
%         ylim([120,240])
%         title(sprintf('Row %i and column %i',j,k))
%         pause(0.001)
%         clf
    end
end

imagesc(img_matrice)
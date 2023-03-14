function [dx, dy, gK, R, Rt, corners] = Harris_corners (picture)

% sobel derivatives:
Kx = [1 0 -1; 2 0 -2; 1 0 -1];
Ky = [1 2 1; 0 0 0; -1, -2 -1];
dx = conv2(picture, Kx, 'same');
dy = conv2(picture, Ky, 'same');

% evaluate "squares" derivatives:
dx2 = dx .* dx;
dy2 = dy .* dy;
dxdy = dx .* dy;

% evaluate matrix M coefficients:
Mx2 = imgaussfilt(dx2,1.2,"FilterSize",9);
My2 = imgaussfilt(dy2,1.2,"FilterSize",9);
Mxy = imgaussfilt(dxdy,1.2,"FilterSize",9);

% rappresenting the Gaussian filter:
stdev = 9/6;
[X,Y] = meshgrid(-9/2:+9/2,-9/2:+9/2);
gK = 1/(2*pi*stdev).*exp(-((X.^2)+(Y.^2))/(2*stdev^2));

% apply the corners response measure method:
a = 0.05;
for i = 1 : size(picture,1)
    for j = 1 : size(picture,2)
        M = [Mx2(i,j) Mxy(i,j); Mxy(i,j) My2(i,j)];
        R(i,j) = det(M) - a * (trace(M).^2);
    end
end

% thresholding the result to discriminate between corner, edge and flatregions:
threshold = 0.3 * (max(R,[],"all"));
for i = 1 : size(picture,1)
    for j = 1 : size(picture,2)
        if R(i,j) >= threshold
            Rt(i,j) = 1;
        else
            Rt(i,j) = 0;
        end
    end
end

% collect the corners positions:
Rt = boolean(Rt);
c = regionprops(Rt,'Centroid');
corners = cat(1, c.Centroid);
end
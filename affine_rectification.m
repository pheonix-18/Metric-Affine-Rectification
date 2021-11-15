function H = affine_rectification(in_img)

img = imread(in_img);
figure(1)
imshow(img)
title("Click 4 Points on the Image")
[x,y] = ginput(4);
close Figure 1

A = [x(1) y(1) 1];
B = [x(2) y(2) 1];
C = [x(3) y(3) 1];
D = [x(4) y(4) 1];
% A B
% C D
line1 = cross(A, B);

line2 = cross(C, D);

% l1 || l2

line3 = cross(A, C);

line4 = cross(B, D);
% l3 || l4



point_infy_1 = cross(line1, line2);
point_infy_1 = point_infy_1/(point_infy_1(1,3));
point_infy_2 = cross(line3, line4);
point_infy_2 = point_infy_2/(point_infy_2(1,3));
%line at infy

line_infy = cross(point_infy_1, point_infy_2);

line_infy_x = line_infy(1,1)/line_infy(1,3);
line_infy_y = line_infy(1,2)/line_infy(1,3);
% Computing Homography H


H = [1 0 0; 0 1 0; line_infy_x line_infy_y 1]
%H = [1 -2 3; 3 5 2; -1 3 4]
tform = projective2d(H')

Iout = imwarp(img,tform);


Ishow = imshow(Iout)

end




function metric_rectification(input_img)
    in_img = imread(input_img);
    figure(1)
    imshow(in_img)
    
    [x,y]= getpts;
    l1 = [x(1) y(1)]; l2 = [x(3) y(3)];
    m1 = [x(2) y(2)]; m2 = [x(4) y(4)];

    M = [l1(1) * m1(1) (l1(1) * m1(2) + l1(2) * m1(1)) ; l2(1) * m2(1) (l2(1) * m2(2) + l2(2) * m2(1))];
    b = [-l1(2) * m1(2); -l2(2) * m2(2)];
    sol = linsolve(M, b);
    
    mat = [sol(1) sol(2); sol(2) 1];
    [U, S, V] = svd(mat); 
    A = transpose(U) * sqrt(S) * U;
    
    H = eye(3);
    H(1:2, 1:2) = A;
    H(1,1) = abs(H(1,1)); H(2,2) = abs(H(2,2));
     projective_transform = projective2d(H);
    out_img = imwarp(in_img, projective_transform);
    figure(2);
    imshow(out_img)
end
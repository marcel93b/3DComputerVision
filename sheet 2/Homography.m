alpha_x = 5500;
alpha_y = 5500;
x_0 = 2376;
y_0 = 1632;
s  = 0;

H1 = [0.432 0 -6526.43; 0.296727 1 -2337.02; 0.000181818 0 -0.432];
H2 = [-0.0468504 0.990566 889.185; -1.00065 -0.0373135 4269.05; -4e-007 -2.58182e-006 1.05136];
H3 = [7.35483e+006  3.17728e+006 -7.45936e+008; -9.00706e-010  2.18238e+006 -3.73894e+008; -1.00277e-029 1337.24 -3121.12];

% K is an upper triangular matrix, see slide 5 of lecture 03
K = [ x_0 s alpha_x; 0 y_0 alpha_y; 0 0 1]; 

% use the relation given on slide 34 of lecture 03
R_rel_1 = inv(K)*H1*K;
R_rel_2 = inv(K)*H2*K;

% test if the orthogonal matrix property is fulfilled
if isequal(eye(3),R_rel_2'*R_rel_2)
    disp('Rotation matrix property fulfilled.')
else
    disp('Rotation matrix property not fulfilled. Correcting...')
    % compute the svd of the R matrix which has to be corrected
    [U,~,V] = svd(R_rel_2);
    % use the orthogonal matrices U,V and the property that multiplication of orthogonal matrices still yields an orthogonal matrix
    R_rel_2_corrected = U*V';
end

% follow slide 29 of lecture 03.
tmp = inv(K)*H3;
R_rel3 = zeros(3,3);
% first 2 columns of tmp contain the first 2 columns of R
R_rel3(:,1:2) = tmp(:,1:2);
% compute r3 using the cross product since R should contain orthogonal columns.
R_rel3(:,3) = cross(R_rel3(:,1),R_rel3(:,2));
% last entry is t
t = tmp(:,end);


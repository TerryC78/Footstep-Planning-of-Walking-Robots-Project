function R = q_to_R( quat )
% q_to_R: get a 3x3 rotation matrix
% scalar element last in quaternion

% make sure magnitude is 1.

mag = 0;
for i = 1:4
 mag = mag + quat(i)*quat(i);
end
mag = sqrt(mag);

x = quat( 1 )/mag;
y = quat( 2 )/mag;
z = quat( 3 )/mag;
w = quat( 4 )/mag;

Rxx = 1 - 2*(y^2 + z^2);
Rxy = 2*(x*y - z*w);
Rxz = 2*(x*z + y*w);

Ryx = 2*(x*y + z*w);
Ryy = 1 - 2*(x^2 + z^2);
Ryz = 2*(y*z - x*w );

Rzx = 2*(x*z - y*w );
Rzy = 2*(y*z + x*w );
Rzz = 1 - 2 *(x^2 + y^2);

R = [ Rxx,    Rxy,    Rxz;
Ryx,    Ryy,    Ryz;
Rzx,    Rzy,    Rzz ];

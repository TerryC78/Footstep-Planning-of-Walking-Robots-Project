function result = generate_axis_angle_rotation_matrix( axis, angle )
% generate_axis_angle_rotation_matrix( axis, angle ); returns rotation matrix
c = cos(angle);
s = sin(angle);
t = 1 - c;
axis_length_2 = 0;
for i = 1:3
 axis_length_2 = axis_length_2 + axis(i)*axis(i);
end
axis = axis/sqrt( axis_length_2 );
x = axis(1);
y = axis(2);
z = axis(3);
result = [ t*x*x + c           t*x*y - z*s        t*x*z + y*s
t*x*y + z*s         t*y*y + c          t*y*z - x*s
t*x*z - y*s         t*y*z + x*s        t*z*z + c ];
end



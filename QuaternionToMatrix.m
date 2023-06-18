function [ mat3x3_m ] = QuaternionToMatrix( quat_v )

% ==============================================================================
% Computes a 3x3 rotation matrix for this (unit) quaternion
% ==============================================================================

% normalize the quaternion if necessary
quat_v = NormalizeQuaternion( quat_v );

mat3x3_m = zeros( 3, 3 );

x = quat_v(1);
y = quat_v(2);
z = quat_v(3);
w = quat_v(4);

x2 = x * x;
y2 = y * y;
z2 = z * z;
xy = x * y;
xz = x * z;
yz = y * z;
xw = x * w;
yw = y * w;
zw = z * w;

mat3x3_m(1,1) = 1.0 - 2.0 * (y2 + z2); mat3x3_m(1,2) =       2.0 * (xy - zw); mat3x3_m(1,3) =       2.0 * (xz + yw);
mat3x3_m(2,1) =       2.0 * (xy + zw); mat3x3_m(2,2) = 1.0 - 2.0 * (x2 + z2); mat3x3_m(2,3) =       2.0 * (yz - xw);
mat3x3_m(3,1) =       2.0 * (xz - yw); mat3x3_m(3,2) =       2.0 * (yz + xw); mat3x3_m(3,3) = 1.0 - 2.0 * (x2 + y2);

end

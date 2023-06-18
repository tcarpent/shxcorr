function [ quat_v, mat3x3_m ] = RandomVersor()

% ==============================================================================
% Generate a random unit quaternion (a.k.a versor)
% See J. Arvo. Random Rotation Matrices.
% In J. Arvo, editor, Graphics Gems II, pages 355 – 356. Morgan Kaufmann, San Diego, 1991.
% ==============================================================================

x1 = rand(1);
x2 = rand(1);
x3 = rand(1);

% Use the random variables x1 and x2 to determine the axis of rotation in cylindrical coordinates.
z1 = x1;
theta = 2 * pi  * x2;
r = sqrt( 1.0 - z1 * z1 );

% Use the random variable x3 to determine the half-angle rotation, ω, about this axis.
omega = pi * x3;

sinw = sin( omega );

w = cos( omega );
x = sinw * cos( theta ) * r;
y = sinw * sin( theta ) * r;
z = sinw * z1;

% Construct an orthogonal matrix corresponding to this quaternion
% This matrix has positive determinant, so it is a rotation.
quat_v = [ x y z w ];

if( nargout > 1 )
    mat3x3_m = QuaternionToMatrix( quat_v );
end

end

function [ x, y, z, angleInRadians ] = QuaternionToAxisAngle( quat_v )

% ==============================================================================
% Computes the axis/angle representation for the input quaternion
% ==============================================================================

assert( length( quat_v ) == 4 );
assert( isreal( quat_v ) == true );

mat3x3_m = QuaternionToMatrix( quat_v );

% trace of the matrix : 
tr = mat3x3_m(1,1) + mat3x3_m(2,2) + mat3x3_m(3,3);

angleInRadians = ACosSafe( 0.5 * ( tr - 1.0 ) );

% the following is numerically unstable when angleInRadians is close to 0
% or pi : 
denom = 2.0 * sin( angleInRadians );

k = 1.0 / denom;
x = k * ( mat3x3_m( 3, 2 ) - mat3x3_m( 2, 3 ) );
y = k * ( mat3x3_m( 1, 3 ) - mat3x3_m( 3, 1 ) );
z = k * ( mat3x3_m( 2, 1 ) - mat3x3_m( 1, 2 ) );

end

%%
function y = ACosSafe( x )

% ==============================================================================
% 'safe' version of acos(x)
% ==============================================================================

if( x <= -1.0 )
    y = pi;
elseif( x >= 1.0 )
    y = 0.0;
else
    y = acos( x );
end

end

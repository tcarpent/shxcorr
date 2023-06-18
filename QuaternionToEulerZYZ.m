function [ z2, y, z1, mat3x3_m ] = QuaternionToEulerZYZ( quat_v )

% ==============================================================================
% Computes the ZYZ Euler angles, and 3x3 rotation matrix for the input quaternion
% ==============================================================================

mat3x3_m = QuaternionToMatrix( quat_v );

% The matrix mat3x3_m must be orthonormal

% matrix to Euler ZYZ
if( mat3x3_m( 3, 3 ) < 1.0 )
    if( mat3x3_m( 3, 3 ) > -1.0 )
        y = acos( mat3x3_m( 3, 3 ) );
        z2 = atan2( mat3x3_m( 2, 3 ), mat3x3_m( 1, 3 ) );
        z1 = atan2( mat3x3_m( 3, 2 ), -mat3x3_m( 3, 1 ) );
    else
        % Not a unique solution.
        y  = pi;
        z2 = -atan2( mat3x3_m( 2, 1 ), mat3x3_m( 2, 2 ) );
        z1 = 0.0;
    end
else
    % Not a unique solution.
    y  = 0.0;
    z2 = atan2( mat3x3_m( 2, 1 ), mat3x3_m( 2, 2 ) );
    z1 = 0.0;
end

end

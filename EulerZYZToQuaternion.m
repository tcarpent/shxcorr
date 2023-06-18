function [ quat_v, mat3x3_m ] = EulerZYZToQuaternion( z2, y, z1 )
    
    % ==============================================================================
    % Computes (unit) quaternions and 3x3 rotation matrix from the ZYZ Euler angles
    %
    % z2, y, z1 in radians
    % This is similar to :
    % eac.quaternions.QuaternionsFromEuler( rad2deg( z2) , rad2deg( y ), rad2deg( z1 ), 'mode', 'zyz' );
    % ==============================================================================

    sz2 = sin( z2 );
    cz2 = cos( z2 );
    sy  = sin( y );
    cy  = cos( y );
    sz1 = sin( z1 );
    cz1 = cos( z1 );
    
    cycz1  = cy * cz1;
    sz2sz1 = sz2 * sz1;

    % intrinsic rotation system
    mat3x3_m = zeros( 3, 3 );
    mat3x3_m( 1, 1 ) = cycz1*cz2 - sz2sz1;  mat3x3_m( 1, 2 ) = -cz1*sz2 - cy*cz2*sz1;   mat3x3_m( 1, 3 ) = sy*cz2;
    mat3x3_m( 2, 1 ) = cycz1*sz2 + cz2*sz1; mat3x3_m( 2, 2 ) = cz2*cz1 - cy*sz2sz1;     mat3x3_m( 2, 3 ) = sy*sz2;
    mat3x3_m( 3, 1 ) = -sy*cz1;             mat3x3_m( 3, 2 ) = sy*sz1;                  mat3x3_m( 3, 3 ) = cy;

    quat_v = QuaternionFromMatrix( mat3x3_m );

end

function quat_v = QuaternionFromMatrix( m )
    
    % ==============================================================================
    % Creates a (unit) quaternion from a 3x3 rotation matrix
    % ==============================================================================
    
    assert( size( m, 1 ) == 3 );
    assert( size( m, 2 ) == 3 );

    r = m( 1, 1 ) + m( 2, 2 ) + m( 3, 3 );
    
    if( r > 0.0 )
        q.w = sqrt( r + 1.0 ) * 0.5;
        inv4w = 1.0 / (4.0 * q.w);
        q.x = (m( 3, 2 ) - m( 2, 3 ) ) * inv4w;
        q.y = (m( 1, 3 ) - m( 3, 1 ) ) * inv4w;
        q.z = (m( 2, 1 ) - m( 1, 2 ) ) * inv4w;
    elseif( m( 1, 1 ) > m( 2, 2 ) && m( 1, 1 ) > m( 3, 3 ) )
        q.x = sqrt( 1.0 + m( 1, 1 ) - m( 2, 2 ) - m( 3, 3 ) ) * 0.5; 
        x4 = 1.0 / (4.0 * q.x);
        q.y = (m( 1, 2 ) + m( 2, 1 )) * x4;
        q.z = (m( 1, 3 ) + m( 3, 1 )) * x4;
        q.w = (m( 3, 2 ) - m( 2, 3 )) * x4;
    elseif( m( 2, 2 ) > m( 3, 3 ) )
        q.y = sqrt( 1.0 + m( 2, 2 ) - m( 1, 1 ) - m( 3, 3 ) ) * 0.5;
        y4 = 1.0 / (4.0 * q.y);
        q.x = ( m( 1, 2 ) + m( 2, 1 ) ) * y4;
        q.z = ( m( 2, 3 ) + m( 3, 2 ) ) * y4;
        q.w = ( m( 1, 3 ) - m( 3, 1 ) ) * y4;
    else
        q.z = sqrt( 1.0 + m( 3, 3 ) - m( 1, 1 ) - m( 2, 2 ) ) * 0.5;
        z4 = 1.0 / (4.0 * q.z);
        q.x = ( m( 1, 3 ) + m( 3, 1 ) ) * z4;
        q.y = ( m( 2, 3 ) + m( 3, 2 ) ) * z4;
        q.w = ( m( 2, 1 ) - m( 1, 2 ) ) * z4;
    end

    quat_v = [ q.x, q.y, q.z, q.w ];

    quat_v = NormalizeQuaternion( quat_v );

end

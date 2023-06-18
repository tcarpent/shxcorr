function dist = DistanceBetweenQuaternions( quat1_v, quat2_v )

    % ==============================================================================
    % Computes the distance between two (unit) quaternions, as the 
    % inner product of the unit quaternions
    % the quaternions are supposed to be normalized
    % ==============================================================================

    assert( length( quat1_v ) == 4 );
    assert( length( quat2_v ) == 4 );

    dist = 1 - abs( dot( quat1_v, quat2_v ) );

end

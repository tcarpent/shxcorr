function dist = DistanceBetweenMatrices( mat1_m, mat2_m )

    % ==============================================================================
    % Computes distance between two 3x3 rotation matrices
    % ==============================================================================

    quat1_v = QuaternionFromMatrix( mat1_m );
    quat2_v = QuaternionFromMatrix( mat2_m );
    dist    = DistanceBetweenQuaternions( quat1_v, quat2_v );

end

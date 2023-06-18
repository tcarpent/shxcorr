function hoaOrder = NumComponentsToOrder( numComponents )
    
    % ==============================================================================
    % Returns the HOA order, given the number of SH components
    % ==============================================================================
    
    assert( IsUnsignedInt( numComponents ) == true );

    % only for 3D case, obviously
    hoaOrder = sqrt( numComponents ) - 1;

    assert( IsUnsignedInt( hoaOrder ) == true );

end
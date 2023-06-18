function numComponents = OrderToNumComponents( hoaOrder )
    
    % ==============================================================================
    % Returns the number of SH components for a given HOA order
    % ==============================================================================
    
    assert( IsUnsignedInt( hoaOrder ) == true );

    % only for 3D case, obviously
    numComponents = (hoaOrder + 1)^2;
    
    assert( IsUnsignedInt( numComponents ) == true );
    
end

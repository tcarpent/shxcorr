function hasNaN = ContainsNaN( data_m )

% ==============================================================================
% returns true if the 'data_m' matrix contains NaN 
% ==============================================================================

hasNaN = any( isnan( data_m(:) ) );

end

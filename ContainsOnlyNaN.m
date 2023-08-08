function onlyNaN = ContainsOnlyNaN( data_m )

% ==============================================================================
% returns true if the 'data_m' matrix contains only NaN 
% ==============================================================================

onlyNaN = all( isnan( data_m(:) ) );

end

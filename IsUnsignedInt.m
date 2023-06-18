function result_b = IsUnsignedInt( data_m )

% ==============================================================================
%  Return true if all elements are unsigned integers
% ==============================================================================

result_b = all( isnumeric( data_m ) & ( uint64( data_m ) == data_m ), 'all' );    

end
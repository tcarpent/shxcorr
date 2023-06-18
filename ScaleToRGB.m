function color_m = ScaleToRGB( value_v, minValue, maxValue )

% ==============================================================================
% Scale float value (in a given range) to RGB color
% ==============================================================================

color_m = zeros( length( value_v ), 3 );

% get the 'jet' colormap
cmap    = jet( 256 );
mapSize = size( cmap, 1 );
    
for kk = 1 : length( value_v )

    value = value_v(kk);

    assert( minValue <= value );
    assert( value <= maxValue );
    
    scaled = Scale( value, minValue, maxValue, 1, mapSize );
    color_m(kk,:)  = cmap( round( scaled ), : );
end

end

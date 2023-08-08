function [] = ImagescWithoutNaN( x, y, data_m )
    
% ==============================================================================
% Similar to 'imagesc( x, y, data_m )'
% but NaN values are ignored (set to transparent color)
% ==============================================================================

imagesc( x, y, data_m );

% and now, set transparent color for the NaN values
imAlpha = ones( size( data_m ) );
imAlpha( isnan( data_m ) ) = 0;
imagesc( x, y, data_m, 'AlphaData', imAlpha );
set( gca, 'Color', 1 * [1 1 1] );

end

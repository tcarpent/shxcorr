function PolarPlotSH( anm_v, kind_s, scale_s, range_dB_v, color_s )

if( nargin < 5 )
    color_s = 'k';
end
if( nargin < 4 )
    range_dB_v = [10 80];
end

if( strcmpi( kind_s, 'real' ) == true )
    PolarPlot_RSH( anm_v, scale_s, range_dB_v, color_s );
elseif ( strcmpi( kind_s, 'complex' ) == true )
    % todo
else
    % unexpected SH kind !
    assert( false );
end

end

% ==============================================================================
%%
function PolarPlot_RSH( anm_v, scale_s, range_dB_v, color_s )

if strcmpi( scale_s, 'db' )
    usedBScale = true;
    assert( length( range_dB_v ) == 2 );
    assert( range_dB_v(1) < range_dB_v(2) );
    rminIndB = range_dB_v(1);
    rmaxIndB = range_dB_v(2);
else
    usedBScale = false;
end

% anm_v is expected to be a vector with 25 elements (= 4th order HOA)
assert( size( anm_v, 1 ) == 1 || size( anm_v, 2 ) == 1 );

% expected to be real
assert( isreal( anm_v ) == true );

if( size( anm_v, 1 ) < size( anm_v, 2 ) )
    anm_v = anm_v.';
end

numComponents = size( anm_v, 1 );
maxOrder = NumComponentsToOrder( numComponents );

azim_v = linspace( -180, 180, 360 );
Ynm_m = zeros( length( azim_v ), numComponents );
for kk = 1 : length( azim_v )
    elevation = 0.0;
    azimuth   = azim_v(kk);
    dirs      = AzElToDir( azimuth, elevation );
    Ynm_m(kk,:) = getSH( maxOrder, dirs, 'real' );
    % N3D :
    Ynm_m(kk,:) = Ynm_m(kk,:) .* 1/sqrt(4*pi);
end

projection_v = Ynm_m * anm_v;

assert( length( projection_v ) == length( azim_v ) );

linewidth = 2;
if( usedBScale == true )

    rvalues_v = db( projection_v );
    rvalues_v = Clamp( rvalues_v, rminIndB, rmaxIndB );
    rvalues_v = abs( rvalues_v );
    polarplot( deg2rad( -azim_v + 90 ), ...
        rvalues_v, ...
        'Color', color_s, ...
        'LineWidth', linewidth );
    set( gca, 'RLim',  [ rminIndB rmaxIndB ]);
    set( gca, 'RTick', ( rminIndB : 10 : rmaxIndB ) );
    rticks = num2str( ( rminIndB : 10 : rmaxIndB ) );
    rticks{1} = '';
else
    % normalize to 1.
    projection_v = projection_v ./ max( abs( projection_v ) );

    polarplot( deg2rad( -azim_v + 90 ), ...
        abs( projection_v ), ...
        'Color', color_s, ...
        'LineWidth', linewidth );
    set( gca, 'RLim', [0 1]);
    set( gca, 'RTick', 0:0.25:1 );
end
set( gca, 'TickLabelInterpreter', 'latex' );
title( '$f( \mathbf{\Omega} )$', ...
    'Interpreter', 'latex', ...
    'FontSize', 14 );
set( gca, 'RAxisLocation', 90-22 );
set( gca, 'ThetaTick', linspace(0,360,17) );
set( gca, 'ThetaTickLabel', { '$+90^{\circ}$', '', ...
    '$+45^{\circ}$', '', ...
    '$0^{\circ}$', '', ...
    '$-45^{\circ}$', '', ...
    '$-90^{\circ}$', '', ...
    '$-135^{\circ}$', '', ...
    '$\pm 180^{\circ}$', '', ...
    '$+135^{\circ}$', '' } );
grid on;

end

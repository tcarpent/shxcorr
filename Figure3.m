clearvars;
close all;
clc;

% ==============================================================================
% Figure3 of the paper
% ==============================================================================

maxOrder = 4;
B = maxOrder + 1;
numComponents = OrderToNumComponents( maxOrder );

kind_s = 'real';

figure;

acnIndices_v = [ 1, 4, 9, 16, 25, 100 ];

for zz = 1 : length( acnIndices_v )
    
    acnIndex = acnIndices_v(zz);
    
    if( acnIndex == 100 )
        dir_v = AzElToDir( 0.0, 0.0 );
        anm_v = getSH( maxOrder, dir_v, kind_s );
    else
        anm_v = zeros( 1, numComponents );
        anm_v( acnIndex ) = 1;
    end

    yaw_v = linspace( -180, 180, 360 );
    
    correlation_v = zeros( 1, length( yaw_v ) );
    
    for ii = 1 : length( yaw_v )
        yaw    = yaw_v( ii );
        yaw    = deg2rad( yaw );
        quat_v = EulerZYZToQuaternion( yaw, 0, 0 );

        % compute bnm_v, a rotated version of anm_v
        bnm_v = RotateSH( anm_v, quat_v, kind_s );

        % compute correlation
        correlation_f = NormalizedCorrelationSH( anm_v, bnm_v, kind_s );
        correlation_v( ii ) = correlation_f;
    end

    % ==============================================================================
    % top figure
    subplot( 2, length( acnIndices_v ), zz );    
    PolarPlotSH( anm_v, kind_s, 'linear' );

    set( gca, 'RTickLabel', {} );
    set( gca, 'ThetaTickLabel', {} );
    grid on;
    switch( zz )
        case 1
            title( '$f \equiv Y_0^0( \mathbf{\Omega} )$', 'Interpreter', 'latex' );
        case 2
            title( '$f \equiv Y_1^1( \mathbf{\Omega} )$', 'Interpreter', 'latex' );
        case 3
            title( '$f \equiv Y_2^2( \mathbf{\Omega} )$', 'Interpreter', 'latex' );
        case 4
            title( '$f \equiv Y_3^3( \mathbf{\Omega} )$', 'Interpreter', 'latex' );
        case 5
            title( '$f \equiv Y_4^4( \mathbf{\Omega} )$', 'Interpreter', 'latex' );
        case 6
            title( 'Dirac delta', 'Interpreter', 'latex' );
    end


    % ==============================================================================
    % bottom figure    
    subplot( 2, length( acnIndices_v ), length( acnIndices_v ) + zz );
    color = 'k';
    plot( yaw_v, correlation_v, 'Color', color, 'linewidth', 2 );
    grid on; grid minor;
    axis tight;
    xlim([-180 180]);
    ylim([-1 1]);
    set( gca, 'XTick', -180:90:180 );
    set( gca, 'TickLabelInterpreter', 'latex' );
    xlabel( '$\alpha$', ...
            'Interpreter', 'latex' );
    if( zz == 1 )
        ylabel( '$\; \mathcal{C}_\mathbf{R}( f, \; f)$', ...
                'Interpreter', 'latex' );
    end
    switch( zz )
        case 1
            title( '(a)', 'Interpreter', 'latex' );
        case 2
            title( '(b)', 'Interpreter', 'latex' );
        case 3
            title( '(c)', 'Interpreter', 'latex' );
        case 4
            title( '(d)', 'Interpreter', 'latex' );
        case 5
            title( '(e)', 'Interpreter', 'latex' );
        case 6
            title( '(f)', 'Interpreter', 'latex' );
    end
end

set( gca, 'TickLabelInterpreter', 'latex' );
grid on; grid minor;
set( gcf, 'Position', [0 0 1500 550] );
SetFont( 24 );


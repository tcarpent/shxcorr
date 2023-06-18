%%
clearvars;
close all;
clc;

% ==============================================================================
% Figure7 of the paper
% Matrix of cross-correlation values for all recorded tones, 
% including all partials, organized by frequency
% ==============================================================================


% ==============================================================================
maxOrder      = TU_GetMaxOrder();
numComponents = OrderToNumComponents( maxOrder );
kind_s        = 'complex';
B             = maxOrder + 1;

for inst = { 'Clarinet_modern_et_ff', ...
             'Cello_modern_et_ff', ...
             'Tuba_modern_et_ff', ...
             'Double_bass_modern_et_ff' }

    folder_s = TU_GetSingleTonesFolder();
    filename = [ folder_s filesep char( inst ) '.mat' ];
    load( filename );

    instName = TU_GetInstrumentFromFilename( filename );

    % number of partials
    numPartials = size( radiation.frequencies, 2 );

    % number of played tones
    numNotes    = size( radiation.frequencies, 1 );

    pnm_m         = radiation.pnm( :, 1:numPartials, : );
    frequencies   = radiation.frequencies( :, 1:numPartials );

    % ==============================================================================
    offset = 1;

    numData = numPartials * numNotes;

    x_v = zeros( 1, numData );
    y_v = zeros( 1, numData );
    cross_v   = zeros( 1, numData );
    dotsize_v = zeros( 1, numData );

    % ==============================================================================
    for ii = 1 : numData
        for jj = 1 : numData

            partialIndex1 = ceil( ii / numNotes );
            noteIndex1    = ii - (partialIndex1 - 1) * numNotes;

            assert( 1 <= partialIndex1 );
            assert( partialIndex1 <= numPartials );
            assert( 1 <= noteIndex1 );
            assert( noteIndex1 <= numNotes );

            partialIndex2 = ceil( jj / numNotes );
            noteIndex2    = jj - (partialIndex2 - 1) * numNotes;

            assert( 1 <= partialIndex2 );
            assert( partialIndex2 <= numPartials );
            assert( 1 <= noteIndex2 );
            assert( noteIndex2 <= numNotes );

            anm_v = pnm_m( :, partialIndex1, noteIndex1 );
            bnm_v = pnm_m( :, partialIndex2, noteIndex2 );

            % without rotational matching
            correlation = NormalizedCorrelationSH( anm_v, bnm_v, kind_s );

            x = radiation.frequencies( noteIndex1, partialIndex1 );
            y = radiation.frequencies( noteIndex2, partialIndex2 );

            x_v( offset ) = x;
            y_v( offset ) = y;
            cross_v( offset ) = correlation;

            minIndex = min( ii, jj );
            dotsize_v( offset ) = Scale( minIndex, 1, numData, 20, 5 );

            offset = offset + 1;
        end

    end

    %%
    figure;
    color_m = ScaleToRGB( abs( cross_v ), 0, 1 );
    scatter( x_v, y_v, dotsize_v, color_m, 'filled' );
    hold on;
    set( gca, 'XScale', 'log' );
    set( gca, 'YScale', 'log' );
    ticks_v = [ 125 250 500 1000 2000 4000 ];
    set( gca, 'XTick', ticks_v );
    set( gca, 'YTick', ticks_v );
    
    title( strrep( instName, '_', ' ' ), ...
           'Interpreter', 'latex', ...
           'FontSize', 20, ...
           'FontWeight', 'normal' );

    axis tight;
    colorbar;
    colormap jet;
    set( get( gca, 'Colorbar' ), 'TickLabelInterpreter', 'latex' );
    set( gca, 'TickLabelInterpreter', 'latex' );
    grid on;
    axis square;    
    set( gcf, 'Position', [ 0 0 800 800 ] );
    SetFont( 22 );

end % for inst

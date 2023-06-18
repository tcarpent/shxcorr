%%
clearvars;
close all;
clc;

% ==============================================================================
% Figure3 of the paper
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

    % select range of interest
    if( startsWith( instName, 'Clarinet_modern_et_' ) == true )
        noteStart = find( strcmp( radiation.noteNames, 'C4' ) );
        % C4 to C5
    elseif( startsWith( instName, 'Double_bass_modern_et_' ) == true )
        noteStart = find( strcmp( radiation.noteNames, 'C2' ) );
        % C2 to C3
    elseif( startsWith( instName, 'Tuba_modern_et_' ) == true )
        noteStart = find( strcmp( radiation.noteNames, 'C1' ) );
        % C1 to C2
    elseif( startsWith( instName, 'Cello_modern_et_' ) == true )
        noteStart = find( strcmp( radiation.noteNames, 'E2' ) );
        % E2 to E3
    else
        assert( false );
    end

    notes_range_v = noteStart:(noteStart+12);
    numPartials = size( radiation.pnm, 2 );

    % ==============================================================================
    % only the chromatic scale of interest
    kk = 1;
    for ii = notes_range_v
        noteNames{kk} = radiation.noteNames{ii};
        kk = kk + 1;
    end

    % ==============================================================================
    pnm_m         = radiation.pnm( :, 1:numPartials, notes_range_v );
    frequencies   = radiation.frequencies( notes_range_v, 1:numPartials );

    % number of played tones
    numNotes = length( noteNames );

    Anm_m = zeros( numComponents, numNotes * numPartials );

    % ==============================================================================
    offset = 1;
    for jj = 1 : numPartials
        for ii = 1 : numNotes
            anm_v = pnm_m( :, jj, ii );

            assert( length( anm_v ) == numComponents );

            Anm_m( :, offset ) = anm_v;
            offset = offset + 1;
        end
    end

    matSize = numNotes * numPartials;

    total = matSize * matSize;

    % ==============================================================================
    cross_m = zeros( matSize, matSize );

    for ii = 1 : matSize
        for jj = 1 : matSize

            anm_v = Anm_m( :, ii );
            bnm_v = Anm_m( :, jj );

            % without rotational matching
            cross_m( ii, jj ) = NormalizedCorrelationSH( anm_v, bnm_v, kind_s );
        end
    end

    % ==============================================================================
    %%
    figure;
    pcolor( abs(cross_m) );
    colorbar;
    colormap jet;
    clim( [0 1] );
    hold on;
    % horizontal/vertical lines
    for kk = 1 : numPartials
        linewidth = 3;
        linecolor = 'k';
        linestyle = '--';
        line( [numNotes*kk+1 numNotes*kk+1], [1 matSize ], ...
            'LineWidth', linewidth, ...
            'Color', linecolor, ...
            'LineStyle', linestyle );
        line( [1 matSize ], [numNotes*kk+1 numNotes*kk+1], ...
            'LineWidth', linewidth, ...
            'Color', linecolor, ...
            'LineStyle', linestyle );
    end
    axis tight;
    axis square;
    xlim( [1 matSize ] );
    ylim( [1 matSize ] );
    title( strrep( instName, '_', ' ' ), ...
           'Interpreter', 'latex', ...
           'FontSize', 20, ...
           'FontWeight', 'normal' );
    xlabel( [ 'partials of notes ranging from ' noteNames{1} ' to ' noteNames{end} ], ...
            'FontSize', 16, ...
            'Interpreter', 'latex' );
    ylabel( [ 'partials of notes ranging from ' noteNames{1} ' to ' noteNames{end} ], ...
            'FontSize', 16, ...
            'Interpreter', 'latex' );
    % offset to center the ticks
    xTick = -round( numNotes/2 ) + numNotes .* ( 1:numPartials );
    set( gca, 'XTick', xTick );
    xlabel_S = {};
    for kk = 1 : numPartials
        xlabel_S{kk} = nthToString( kk );
    end
    set( gca, 'YTick', 1:matSize );
    ylabel_S = {};
    offset = 1;
    for ii = 1 : numPartials
        for jj = 1 : numNotes
            f = frequencies( jj, ii );
            ylabel_S{ offset } = num2str( round( f ) );
            offset = offset+1;
        end
    end
    set( gca, 'YTick', xTick );
    set( gca, 'XTickLabel', xlabel_S, 'FontSize', 16 );
    set( gca, 'YTickLabel', xlabel_S, 'FontSize', 16 );
    set( get( gca, 'Colorbar' ), 'TickLabelInterpreter', 'latex' );
    set( gca, 'TickLabelInterpreter', 'latex' );
    shading flat;
    clim( [0 1] );
    set( gcf, 'Position', [ 0 0 800 800 ] );
    SetFont( 22 );

end % for inst

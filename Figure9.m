clearvars;
close all;
clc;

% ==============================================================================
% Similar to Acta Figure9
% MDS analysis on the fundamental frequencies
% ==============================================================================


available_S = TU_GetListOfInstruments();
% keep only instruments with 'ff' dynamics
available_S = available_S.ff_S; 

% keeping only the fundamental frequency
fundamentalIndex = 1;

for theNote = { 'E3', 'B3' }
    
    clc;    
    numInstruments = 0; % number of instruments containing the note of interest
    
    for zz = 1 : length( available_S )        
        inst     = available_S{ zz };
        folder_s = TU_GetSingleTonesFolder();
        filename = [ folder_s filesep char( inst ) '.mat' ];
        load( filename );
    
        instName = TU_GetInstrumentFromFilename( filename );
        
        % number of played tones
        numNotes = length( radiation.noteNames );

        theNoteIndex = -1;
        for ii = 1 : numNotes
            noteName = radiation.noteNames{ ii };
            if( strcmpi( noteName, theNote ) == true )
                theNoteIndex = ii;
            end
        end

        if( theNoteIndex > 0 )
            % keep this instrument for MDS analysis
            numInstruments = numInstruments + 1;            
            instrument_S{ numInstruments } = instName;

            anm_v = radiation.pnm( :, fundamentalIndex, theNoteIndex );
            pnm_m( numInstruments, : ) = anm_v;
        else
            % no E3 or B3 for this instrument
        end
    end
    
    
    cross_m = zeros( numInstruments, numInstruments );           
    for ii = 1 : numInstruments
        for jj = 1 : numInstruments                        
            anm_v = pnm_m( ii, : );
            bnm_v = pnm_m( jj, : );
            
            % without rotational matching
            kind_s = 'complex';
            correlation = NormalizedCorrelationSH( anm_v, bnm_v, kind_s );
            cross_m( ii, jj ) = abs( correlation );
        end        
    end
    
    %%    
    % sanity check : ensure ones in diagonal
    ensureOnesInDiagonal( cross_m );
    % sanity check : ensure symetry
    ensureSymmetry( cross_m );
    
    %%
    dissimilarity_m = sqrt( 1 - cross_m.^2 );
    
    % sanity check : ensure no negative values
    ensureAllPositive( dissimilarity_m );    
    % sanity check : ensure symetry
    ensureSymmetry( dissimilarity_m );
    
    %% 
    % force perfect symetry (not needed)
    %forceSymmetry( dissimilarity_m );
    
    mdsDimension = 2;
    [ Y, eigvals ] = cmdscale( dissimilarity_m, mdsDimension );
    
    figure;
    fontSize = 22;

    for ii = 1 : numInstruments            
        color    = ScaleToRGB( ii, 1, numInstruments );        
        instName = instrument_S{ ii };        
        category = TU_GetInstrumentCategory( instName );
        
        if( category == 1 )
            marker = 'o';
            color = 'r';
        elseif( category == 2 )
            marker = 'd';
            color = 'b';
        elseif( category == 3 )
            marker = 'x';
            color = 'k';
        else
            assert( false );
        end
            
        instName = strrep( instName, 'et_ff', '' );
        instName = strrep( instName, '_', ' ' );
        instName = strrep( instName, ' modern', ' ' );
                
        plot( Y(ii,1), Y(ii,2), marker, ...
             'Color', color, ...
             'MarkerSize', 16 );
        xOffset = 0;
        if( Y(ii,1) > 0.25 )
            xOffset = -0.2;
        end
        text( Y(ii,1), Y(ii,2) + 0.02, instName, ...
              'Color', color, ...
              'FontSize', fontSize-2, ...
              'HorizontalAlignment', 'center', ...
              'Interpreter', 'latex' );        
        hold on;
    end        
    grid on;
    xlim auto; xlim auto; zlim auto;    
    legend off;
    axis padded;
    axis equal;    
    set( gca, 'TickLabelInterpreter', 'latex' );
    set( gcf, 'Position', [0 0 1000 1200]);
    SetFont( fontSize );
    
    if( strcmp( char( theNote ), 'B3' ) == true )
        title( '(a)', 'Interpreter', 'latex', 'FontSize', 30 );
    elseif( strcmp( char( theNote ), 'E3' ) == true )
        title( '(b)', 'Interpreter', 'latex', 'FontSize', 30 );
    end

end

% ==============================================================================
%%
function ensureOnesInDiagonal( matrix_m )
assert( size( matrix_m, 1 ) == size( matrix_m, 2 ) );

for ii = 1 : size( matrix_m, 1 )
    err = abs( matrix_m(ii,ii) - 1 );
    assert( err < 1e-9 );
end
end

% ==============================================================================
%%
function ensureSymmetry( matrix_m )

assert( size( matrix_m, 1 ) == size( matrix_m, 2 ) );

for ii = 1 : size( matrix_m, 1 )
    for jj = 1 : size( matrix_m, 2 )
        err = abs( matrix_m(ii,jj) - matrix_m(jj,ii) );
        assert( err < 1e-9 );
    end
end
end

% ==============================================================================
%%
function ensureAllPositive( matrix_m )
for ii = 1 : size( matrix_m, 1 )
    for jj = 1 : size( matrix_m, 2 )
        assert( 0 <= matrix_m(ii,jj) );
    end
end
end

% ==============================================================================
%%
function forceSymmetry( matrix_m )
assert( size( matrix_m, 1 ) == size( matrix_m, 2 ) );
for ii = 1 : size( matrix_m, 1 )
    for jj = 1 : size( matrix_m, 2 )
        matrix_m( ii, jj ) = matrix_m( jj, ii );
    end
end
end

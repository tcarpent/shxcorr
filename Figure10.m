clearvars;
close all;
clc;

% ==============================================================================
% Figure10 : Matrix of cross-correlation values between instruments for the 
% third-octave band centered at 198 Hz.
% ==============================================================================

centerFrequency_f = 198;
bandsOfInterest   = 11; % corresponding to 198 Hz

available_S     = TU_GetListOfInstruments();
instruments_S   = available_S.ff_sorted_S;
clear available_S;
numInstruments  = length( instruments_S );

oversampling    = 2;
quats_m         = TU_GetSO3Sampling( oversampling );

correlation_before_m = NaN .* ones( numInstruments, numInstruments );
correlation_after_m  = NaN .* ones( numInstruments, numInstruments );

for dim1 = 1 : numInstruments
    instrumentA = instruments_S{ dim1 };
    pnmA_m      = TU_LoadThirdOctave( instrumentA );
    anm_v       = pnmA_m( : , bandsOfInterest );
    if( ContainsNaN( anm_v ) == false )
        parfor dim2 = 1 : numInstruments
            instrumentB = instruments_S{ dim2 };
            pnmB_m      = TU_LoadThirdOctave( instrumentB );
            bnm_v       = pnmB_m( : , bandsOfInterest );

            if( ContainsNaN( bnm_v ) == false )
                kind_s = 'real';

                correlationBeforeRotation = NormalizedCorrelationSH( anm_v, bnm_v, kind_s );

                [ ~, maxCorrelation, ~ ] = MaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s );
                correlationAfterRotation = maxCorrelation;

                correlation_before_m( dim1, dim2 ) = correlationBeforeRotation;
                correlation_after_m( dim1, dim2 )  = correlationAfterRotation;
            end 
        end
    end
end

assert( ContainsOnlyNaN( correlation_before_m ) == false );
assert( ContainsOnlyNaN( correlation_after_m ) == false );

clear dim1 dim2 anm_v pnmA_m pnmB_m instrumentA instrumentB;


%% ==============================================================================
% The matrix of cross-correlation (before/after rotational matching)
% for all instruments
correlation_before_and_after_m = NaN .* ones( numInstruments, numInstruments );

for ii = 1 : numInstruments 
    for jj = 1 : numInstruments
        if ii > jj
            correlation_before_and_after_m(ii,jj) = correlation_before_m(ii,jj);
        else
            correlation_before_and_after_m(ii,jj) = correlation_after_m(ii,jj);
        end
    end
end

%%
% ==============================================================================
% clean up instrument names
for ii = 1 : numInstruments
    clean_instruments_S{ ii } = renameInstrumentForDisplay( instruments_S{ ii } );
end


figure;
data_m = abs( correlation_before_and_after_m ).';
ImagescWithoutNaN( 1:numInstruments, 1:numInstruments, data_m );
set( gca, 'YDir', 'normal' );
hold on;
set( gca, 'XScale', 'lin' );
set( gca, 'YScale', 'lin' );
set( gca, 'XTick', 1:numInstruments );
set( gca, 'YTick', 1:numInstruments );
set( gca, 'XTickLabel', clean_instruments_S );
set( gca, 'YTickLabel', clean_instruments_S );
axis tight;
colorbar;
colormap jet;
clim([0 1]);
title( ['Cross-correlation with and without rotational matching @ ' num2str( round( centerFrequency_f ) ) ' Hz' ], ...
       'FontSize', 22, ...
       'Interpreter', 'latex' );
title('');
axis square

% ==============================================================================
% Count the number of instrument in each category
numBrass    = TU_GetNumBrassInstruments( instruments_S );
numWoodwind = TU_GetNumWoodwindInstruments( instruments_S );
numString   = TU_GetNumStringInstruments( instruments_S );

hold on;
line([0.5 numInstruments+0.5], [numBrass+0.5 numBrass+0.5], 'Color', 'k', 'LineWidth', 3 );
line([0.5 numInstruments+0.5], [numBrass+numWoodwind+0.5 numBrass+numWoodwind+0.5], 'Color', 'k', 'LineWidth', 3 );
line([numBrass+0.5 numBrass+0.5], [0.5 numInstruments+0.5], 'Color', 'k', 'LineWidth', 3 );
line([numBrass+numWoodwind+0.5 numBrass+numWoodwind+0.5], [0.5 numInstruments+0.5], 'Color', 'k', 'LineWidth', 3 );

grid off; grid on;
set( gcf, 'Position', [0 0 1500 1500 ]);

%%
function cleanName_s = renameInstrumentForDisplay( name_s )
    % ==============================================================================
    % Clean up the instrument name for plot purposes
    % ==============================================================================
    
    cleanName_s = name_s;
    cleanName_s = strrep( cleanName_s, '_', ' ' );
    cleanName_s = strrep( cleanName_s, ' et ff', '' );
    cleanName_s = strrep( cleanName_s, ' modern', '' );
    cleanName_s = strrep( cleanName_s, ' historical', ' hist' );
end


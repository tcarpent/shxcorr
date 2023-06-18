clearvars;
close all;
clc;

% ==============================================================================
% Figure4 of the paper
% Polar representation of angular pattern for N = 4 and for various values of the directivity factor
% ==============================================================================

maxOrder  = 4;

%%
% ==============================================================================
step    = 20;
range_v = 0:step:100;
                                     
figure;
for selectivity = range_v

    subplot( 1, 6, selectivity/step + 1 );
                    
    dir_v = AzElToDir( 0.0, 0.0 );
    kind_s = 'real';
    anm_v = getSH( maxOrder, dir_v, kind_s );

    gnm_v = GetWeightingGains( maxOrder, selectivity );
    anm_v = anm_v .* gnm_v;           
        
    PolarPlotSH( anm_v, kind_s, 'linear' );

    set( gca, 'RTickLabel', {} );
    set( gca, 'ThetaTickLabel', {} );
    title( [ '$\zeta=' num2str( selectivity ) '\%$' ] );
end
set( gcf, 'Position', [0 0 1000 250] );
SetFont( 22 );


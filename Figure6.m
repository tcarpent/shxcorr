clearvars;
close all;
clc

% ==============================================================================
% Figure6 : correlation between Dirac delta f and directionally reduced g
% ==============================================================================
%
% Computation time depends on the number of Monte-Carlo runs (iterations),
% oversampling ratio, and number of tested "directivity factor" ζ

iterations      = 100;  % must be adjusted
maxOrder        = 4;

reduction_v = linspace( 0, 100, 20 ); % length can be adjusted

correlation_after_v = zeros( 1, length( reduction_v ) );
matrix_distances_v  = zeros( 1, length( reduction_v ) );

% bandwidth
B = maxOrder + 1;

numComponents     = OrderToNumComponents( maxOrder );
oversamplingRatio = 3; % can be adjusted
numSamples        = round( (2 * B) * oversamplingRatio );
quats_m           = SO3SamplingUsingEulerAngles( maxOrder, numSamples );
    
tic;
parfor reductionIndex = 1 : length( reduction_v )
        
    reduction = reduction_v( reductionIndex );

    tmp_correlation_after_v = zeros( 1, iterations );
    tmp_matrix_distances_v  = zeros( 1, iterations );
    
    for it = 1 : iterations
    
        % generate a random set of SH coefficients anm_v
        anm_v = -1 + 2 * rand( 1, numComponents );
        
        % generate directionally reduced SH coefficients bnm_v
        bnm_v = anm_v .* GetWeightingGains( maxOrder, reduction );

        % which kind of SH to use
        kind_s = 'real';

        % generate a random rotation matrix
        quat_v = RandomVersor();

        % rotation in SH domain
        bnm_v = RotateSH( bnm_v, quat_v, kind_s );

        % Search for rotational matching
        [ matching_rot3x3_m, maxCorrelation, matching_quat_v ] ...
            = MaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s );
        
        dist = DistanceBetweenQuaternions( matching_quat_v, quat_v );
    
        tmp_correlation_after_v( it ) = maxCorrelation;
        tmp_matrix_distances_v( it )  = dist;

    end
        
    correlation_after_v( reductionIndex ) = mean( tmp_correlation_after_v );
    matrix_distances_v( reductionIndex )  = mean( tmp_matrix_distances_v );

end
toc       

%%
% ==============================================================================

%
figure;
subplot( 2, 1, 1 );
plot( reduction_v, correlation_after_v, ...
      'Color', 'b', ...
      'LineWidth', 2 );
xlim([ min( reduction_v ) max( reduction_v) ] );
xlabel( '$\zeta$', ...
        'Interpreter', 'latex' );
ylabel( '$\; \mathcal{C}_\mathbf{R}(\Lambda_{\hat{\mathbf{R}}}(f), \; g)$', ...
        'Interpreter', 'latex' );
title( 'Normalized cross-correlation between spatial Dirac $f$ and directionally reduced $g$', ...
       'Interpreter', 'latex', ...
       'FontSize', 14 );
set( gca, 'TickLabelInterpreter', 'latex' );
grid minor;

% ==============================================================================
%
subplot( 2, 1, 2 );
plot( reduction_v, matrix_distances_v, ...
      'Color', 'b', ...
      'LineWidth', 2 );
set( gca, 'YScale', 'log' );
xlim([ min( reduction_v ) max( reduction_v) ] );
xlabel( '$\zeta$', ...
        'Interpreter', 'latex' );
ylabel( '$\textrm{d}( \mathbf{R}, \hat{\mathbf{R}} )$', ...
        'Interpreter', 'latex' );
title( 'Distance between expected and estimated rotation matrices', ...
       'Interpreter', 'latex', ...
       'FontSize', 14 );
set( gca, 'YScale', 'log' );
set( gca, 'TickLabelInterpreter', 'latex' );
grid minor;

set( gcf, 'Position', [0 0 1100 850] );
SetFont( 20 );


clearvars;
close all;
clc

% ==============================================================================
% Figure2 : Impact of oversampling the SO(3) search space
% ==============================================================================
%
% Computation time depends on the number of Monte-Carlo runs (iterations),
% and size of oversampling_v 
% 

iterations      = 10; 
% number of Monte-Carlo runs --> should be at least 10000 for 'smooth'
% plots
oversampling_v  = linspace( 1, 5, 20 );
maxOrder        = 5;

correlation_after_m = zeros( maxOrder, length( oversampling_v ) );
matrix_distances_m  = zeros( maxOrder, length( oversampling_v ) );

for order = 1 : maxOrder

    % bandwidth
    B = order + 1;
    
    disp( [ 'B = ' num2str(B) ' / ' num2str( maxOrder+1 ) ] );
    
    tic;
    parfor oversmpIndex = 1 : length( oversampling_v )
            
        oversamplingRatio = oversampling_v( oversmpIndex );
        numSamples        = round( (2 * B) * oversamplingRatio );
        quats_m           = SO3SamplingUsingEulerAngles( order, numSamples );
            
        tmp_correlation_after_v = zeros( 1, iterations );
        tmp_matrix_distances_v  = zeros( 1, iterations );
        
        numComponents = OrderToNumComponents( order );

        for it = 1 : iterations
        
            % generate a random set of SH coefficients anm_v
            anm_v = -1 + 2 * rand( 1, numComponents );
            
            % generate a random rotation matrix
            quat_v = RandomVersor();
            
            % which kind of SH to use
            kind_s = 'real';

            % rotation in SH domain
            bnm_v = RotateSH( anm_v, quat_v, kind_s );
            
            % Search for rotational matching
            [ matching_rot3x3_m, maxCorrelation, matching_quat_v ] ...
                = MaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s );
            
            dist = DistanceBetweenQuaternions( matching_quat_v, quat_v );
        
            tmp_correlation_after_v( it ) = maxCorrelation;
            tmp_matrix_distances_v( it )  = dist;

        end
            
        correlation_after_m( order, oversmpIndex ) = mean( tmp_correlation_after_v );
        matrix_distances_m( order, oversmpIndex )  = mean( tmp_matrix_distances_v );

    end
    toc       
    
end

% ==============================================================================
%%
legend_S = [];
for order = 1 : maxOrder
    B = order + 1;
    legend_S = strvcat( legend_S, [ '$B=' num2str( B ) '$' ] );
end

%
figure;
subplot( 2, 1, 1 );
for order = 1 : maxOrder
    B = order + 1;
    color = ScaleToRGB( B, 1+1, maxOrder+1 );
    plot( oversampling_v, correlation_after_m( order, : ), ...
          'Color', color, ...
          'Marker', '.', ...
          'MarkerSize', 15, ...
          'LineWidth', 2 );
    hold on;
end
hold on;
xlim([ min( oversampling_v ) max( oversampling_v) ] );
legend( legend_S, 'Location', 'southeast', ...
        'Interpreter', 'latex' );
xlabel( 'Oversampling for $\mathit{SO}(3)$ discretization    $\; \frac{\mathcal{N}}{2 B}$', ...
        'Interpreter', 'latex' );
ylabel( '$\; \mathcal{C}_\mathbf{R}(\Lambda_{\hat{\mathbf{R}}}(f), \; g)$', ...
        'Interpreter', 'latex' );
title( 'Normalized cross-correlation after rotational matching', ...
       'Interpreter', 'latex', ...
       'FontSize', 14 );
set( gca, 'TickLabelInterpreter', 'latex' );
grid minor;

% ==============================================================================
%
subplot( 2, 1, 2 );
for order = 1 : maxOrder
    B = order + 1;
    color = ScaleToRGB( B, 1+1, maxOrder+1 );
    plot( oversampling_v, matrix_distances_m( order, : ), ...
          'Color', color, ...
          'Marker', '.', ...
          'MarkerSize', 15, ...
          'LineWidth', 2 );
    hold on;
end
hold on;
set( gca, 'YScale', 'log' );
xlim([ min( oversampling_v ) max( oversampling_v) ] );
subplot( 2, 1, 2 );
legend( legend_S, 'Location', 'northeast', 'Interpreter', 'latex' );
xlabel( 'Oversampling for $\mathit{SO}(3)$ discretization    $\; \frac{\mathcal{N}}{2 B}$', ...
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


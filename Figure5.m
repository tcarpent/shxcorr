clearvars;
close all;
clc

% ==============================================================================
% Figure5 of the paper
% Example of rotational alignment of two patterns with different bandwidths.
% ==============================================================================

maxOrder = 4;
B = maxOrder + 1;
kind_s = 'real';

% Original : facing forward
azimuth   = 0.0;
elevation = 0.0;
dir_v = AzElToDir( azimuth, elevation );
anm_v = getSH( maxOrder, dir_v, kind_s );

yaw    = deg2rad( -135.0 );
pitch  = deg2rad( 0.0 );
roll   = deg2rad( 0.0 );
quat_v = EulerZYZToQuaternion( yaw, pitch, roll );

% rotation in SH domain
bnm_v = RotateSH( anm_v, quat_v, kind_s );
zeta  = 40.0;
gn_v  = GetWeightingGains( maxOrder, zeta );
bnm_v = bnm_v .* gn_v;

%%
% Search for rotational matching
numSamples = (2 * B) * 3;
quats_m = SO3SamplingUsingEulerAngles( maxOrder, numSamples );
[ matching_rot3x3_m, maxCorrelation, matching_quat_v ] = ...
    MaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s );
rotated_anm_v = RotateSH( anm_v, matching_quat_v, kind_s );

%%
figure;
PolarPlotSH( anm_v, kind_s, 'linear', [], [1.0000 0.7529 0.7961] );
hold on;
PolarPlotSH( bnm_v, kind_s, 'linear', [], [0 0 0] );
PolarPlotSH( rotated_anm_v, kind_s, 'linear', [], [1 0 0] );
set( gca, 'RTickLabel', {} );
title( '' );
SetFont( 22 );
set( gcf, 'Position', [ 0 0 1000 1000 ] );

% Distance between quaternions : 
dist = DistanceBetweenQuaternions( matching_quat_v, quat_v )

% Normalized cross-correlation before rotation matching
correlationBefore = abs( NormalizedCorrelationSH( anm_v, bnm_v, kind_s ) ); 

% Normalized cross-correlation after rotation matching
correlationAfter = maxCorrelation


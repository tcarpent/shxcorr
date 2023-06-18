clearvars;
close all;
clc;

% ==============================================================================
% Figure1 of the paper
% Plot the sampling distribution of SO(3) space
% ==============================================================================

%%
% ==============================================================================
figure;

% ==============================================================================
subplot( 1, 3, 1 );

maxOrder = 3;
B = maxOrder + 1;

quats_m = SO3SamplingUsingEulerAngles( maxOrder, 2*B );
plotQuaternions( quats_m );
title( '(a)', 'Interpreter', 'latex' );

% ==============================================================================
subplot( 1, 3, 2 );

quats_m = SO3SamplingUsingHalton( 512 );
plotQuaternions( quats_m );
title( '(b)', 'Interpreter', 'latex' );

% ==============================================================================

subplot( 1, 3, 3 );

quats_m = SO3SamplingUsingHopf( 1 );
plotQuaternions( quats_m );
title( '(c)', 'Interpreter', 'latex' );

set( gcf, 'Position', [0 0 1000 400] );



%%
% ==============================================================================
function plotQuaternions( quats_m )

numSamples = size( quats_m, 1 );
color_m = zeros( numSamples, 3 );
XX      = zeros( 1, numSamples );
YY      = zeros( 1, numSamples );
ZZ      = zeros( 1, numSamples );
for ii = 1 : numSamples    
    [ x, y, z, angleInRadians ] = QuaternionToAxisAngle( quats_m(ii,:) );
    assert( 0 <= angleInRadians && angleInRadians <= pi );
    xyz = [ x y z ];
    xyz = xyz ./ norm( xyz ) * angleInRadians;
    XX(ii) = xyz(1);
    YY(ii) = xyz(2);
    ZZ(ii) = xyz(3);
    color_m(ii,:) = ScaleToRGB( angleInRadians, 0.0, pi );
end
scatter3( XX, YY, ZZ, 20, color_m, 'filled' );
hold on;
plotSphere();
axis equal;
grid on;
set( gca, 'XTickLabel', {} );
set( gca, 'YTickLabel', {} );
set( gca, 'ZTickLabel', {} );
rotate3d on;
set( gcf, 'Position', [0 0 800 800 ]);
view( -35, 30 );
SetFont( 24 );

end

%%
function plotSphere()

[X,Y,Z] = sphere(100);
radius = pi;
X = X * radius;
Y = Y * radius;
Z = Z * radius;

alpha  = 0.15;
color  = 0.9608 .* ones( 1, 3 );
surf( X, Y, Z, ...
    'FaceColor', color, ...
    'FaceAlpha', alpha, ...
    'LineWidth', 1, ...
    'EdgeColor', 'none', ...
    'LineStyle', '-', ...
    'FaceLighting', 'flat' );
  
end


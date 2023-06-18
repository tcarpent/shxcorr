function [ quats_m ] = SO3SamplingUsingHalton( numSamples )

% ==============================================================================
% Generates a sampling grid for SO(3), using Halton sequences in the unit cube
%
% quats_m : unit quaternions
% ==============================================================================

halton_m = generateHaltonMatrix( numSamples );

quats_m = zeros( numSamples, 4 );

for ii = 0 : (numSamples-1)

    x1 = halton_m( 1, ii+1 );
    x2 = halton_m( 2, ii+1 );
    x3 = halton_m( 3, ii+1 );

    % compute vector v
    scale = 1.0 / sqrt( numSamples );
    twopix2 = (2*pi) * x2;
    v = zeros( 1, 3 );
    v(1) = scale * cos( twopix2 ) * sqrt( x3 );
    v(2) = scale * sin( twopix2 ) * sqrt( x3 );
    v(3) = scale * sqrt( numSamples - x3 );

    H = computeMatrixH( v );

    % compute matrix R
    R = computeMatrixR( x1 );

    H = H .* -1;
    M = H * R;

    q = QuaternionFromMatrix( M );
    
    quats_m( ii+1, : ) = q;
end

end

%%
function H_m = computeMatrixH( vec_v )
v0 = vec_v(1);
v1 = vec_v(2);
v2 = vec_v(3);
mat3x3_m = zeros( 3, 3 );
mat3x3_m( 1, 1 ) = v0 * v0;
mat3x3_m( 1, 2 ) = v0 * v1;
mat3x3_m( 1, 3 ) = v0 * v2;
mat3x3_m( 2, 1 ) = v1 * v0;
mat3x3_m( 2, 2 ) = v1 * v1;
mat3x3_m( 2, 3 ) = v1 * v2;
mat3x3_m( 3, 1 ) = v2 * v0;
mat3x3_m( 3, 2 ) = v2 * v1;
mat3x3_m( 3, 3 ) = v2 * v2;
mat3x3_m = mat3x3_m .* 2;
H_m = ( eye(3) - mat3x3_m );
% since this is a Houselholder matrix, it's supposed to be symetric and orthogonal.
end

%%
function mat3x3_m = computeMatrixR( x1 )
c = cos( 2 * pi * x1 );
s = sin( 2 * pi * x1 );
mat3x3_m = zeros( 3, 3 );
mat3x3_m( 1, 1 ) = c;
mat3x3_m( 1, 2 ) = s;
mat3x3_m( 1, 3 ) = 0;
mat3x3_m( 2, 1 ) = -s;
mat3x3_m( 2, 2 ) = c;
mat3x3_m( 2, 3 ) = 0;
mat3x3_m( 3, 1 ) = 0;
mat3x3_m( 3, 2 ) = 0;
mat3x3_m( 3, 3 ) = 1;
end

%%
function halton_m = generateHaltonMatrix( numSamples )
halton_m = zeros( 3, numSamples );
for ii = 1:3
    seq = generateHaltonSequence( numSamples, ii );
    halton_m( 3 - ii + 1, : ) = seq;
end
end

%%
function seq_v = generateHaltonSequence( numSamples, base )

assert( 1 <= base && base <= 3 );

if( base == 1 )
    seq_v = zeros( 1, numSamples );
    for ii = 1 : numSamples
        seq_v(ii) = ii;
    end
    return;
end

seq_v = generateVanDderCorputSequence( numSamples, base );

end

%%
function seq_v = generateVanDderCorputSequence( numSamples, base )
seq_v = zeros( 1, numSamples );
for ii = 1 : numSamples
    seq_v( ii ) = corput( ii, base );
end
end

%%
function value = corput( n, base )
assert( 2 <= base && base <= 3 );
q  = 0.0;
bk = 1.0 / base;
while( n > 0 )
    q = q + mod( n, base ) * bk;
    n = floor( n / base );
    bk = bk / base;
end
value = q;
end



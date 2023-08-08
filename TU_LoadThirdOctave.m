function [ pnm_m, frequencies_v ] = TU_LoadThirdOctave( instrumentName_s )

% ==============================================================================
% Load radiation data from the TU database, 
% for ThirdOctaves, centered.
% ==============================================================================

% where to find the data
folder_s = [ TU_GetDirectivitiesFolder() filesep 'ThirdOctaves' ];

numComponents     = 25; % 4th order HOA (hard coded)
numFrequencyBands = 31; % hard coded

% ==============================================================================
filename1  = [ folder_s filesep instrumentName_s '.mat' ];
load( filename1 );
    
% ==============================================================================
% Convert to real-valued SH
assert( size( radiation.pnm, 1 ) == numComponents );
assert( size( radiation.pnm, 2 ) == numFrequencyBands );

for ii = 1 : numFrequencyBands
    pnm_v = radiation.pnm( :, ii );
    rsh_v = convert_CSH_to_RSH( pnm_v );
    radiation.pnm( :, ii ) = rsh_v;
end

% ==============================================================================
% cleanup data (low and high frequency bands)
radiation = discardUnusableFrequencyBands( radiation );

% ==============================================================================
% Keep only pnm and center frequencies. The rest is not useful for our
% analysis.
pnm_m         = radiation.pnm;
frequencies_v = radiation.bands.center_frequencies;

assert( length( frequencies_v ) == numFrequencyBands );
assert( size( pnm_m, 1 ) == numComponents );
assert( size( pnm_m, 2 ) == numFrequencyBands );

% ==============================================================================
% ensure there is non-zero data 
for kk = 1 : numFrequencyBands

    pnm_v = pnm_m( :, kk );

    if( ContainsOnlyNaN( pnm_v ) == true )
        % contains only NaN. Ignore that.
    else
        assert( norm( pnm_v ) > 0 ); 
    end
end

end

%%
function rsh_v = convert_CSH_to_RSH( pnm_v )

% convert complex value pnm_v coefficients (from TU Berlin)
% to real-valued coefficients rsh_v (ACN N3D)

assert( size( pnm_v, 1 ) == 1 || size( pnm_v, 2 ) == 1 );
assert( size( pnm_v, 1 ) == 25 || size( pnm_v, 2 ) == 25 );

needsTranspose = false;

if( size( pnm_v, 1 ) == 1 )
    pnm_v = pnm_v.';
    needsTranspose = true;
end

numComponents = size( pnm_v, 1 );

maxOrder = NumComponentsToOrder( numComponents );
assert( maxOrder == 4 );

%Convert complex-valued SH to real-valued SH
c2r_m = complexToRealMatrix( maxOrder );
rsh_v = real( c2r_m * pnm_v );

assert( size( rsh_v, 1 ) == numComponents );
assert( size( rsh_v, 2 ) == 1 );

% and convert to N3D
rsh_v = unnormalizedToN3D( rsh_v );

% make sure output has the same dimension as input
if( needsTranspose == true )    
    rsh_v = rsh_v.';
end    

end

%%
function anm_v = unnormalizedToN3D( anm_v )

numComponents = length( anm_v );
maxOrder      = NumComponentsToOrder( numComponents );

acnIndex = 1;
for n = 0 : maxOrder
    for m = -n : n
        if( m == 0 )
            anm_v( acnIndex ) = anm_v( acnIndex ) * sqrt( 4 * pi );
        else
            anm_v( acnIndex ) = anm_v( acnIndex ) * (-1)^m * sqrt( 8 * pi );
        end
        acnIndex = acnIndex + 1;
    end
end

end

%%
function c2r_m = complexToRealMatrix( maxOrder )

    numComponents = OrderToNumComponents( maxOrder );
    c2r_m = zeros( numComponents, numComponents );

    offset = 1;
    for n = 0 : maxOrder
        numberOfComponentsPerOrder = 2 * n + 1;
        tmp_m = zeros( numberOfComponentsPerOrder, numberOfComponentsPerOrder );
        tmp_m( n+1, n+1 ) = 1;
        for m = 1 : n
            tmp_m( n-m+1, n-m+1 ) = (-1)^m * 1i * 0.5;
            tmp_m( n+m+1, n-m+1 ) = (-1)^m * 0.5;
            tmp_m( n-m+1, n+m+1 ) = -0.5 * 1i;
            tmp_m( n+m+1, n+m+1 ) = 0.5;
        end

        startIndex = offset;
        endIndex   = startIndex + numberOfComponentsPerOrder-1;
        c2r_m( startIndex:endIndex, startIndex:endIndex ) = tmp_m;
        offset = offset + numberOfComponentsPerOrder;        
    end

end

%%
function radiation = discardUnusableFrequencyBands( radiation )

% ==============================================================================
% Replaces the suspicious information with NaN
% ==============================================================================

% hard-coded sizes for data from TU Berlin
numFrequencyBands = 31;
numComponents     = 25;

assert( isfield( radiation, 'pnm' ) == true );
assert( size( radiation.pnm, 1 ) == numComponents );
assert( size( radiation.pnm, 2 ) == numFrequencyBands );

pnm = radiation.pnm;

% ==============================================================================
% Replace omnidirectional frequency bands with NaN
for kk = 1 : numFrequencyBands
    pnm_v = pnm( :, kk );

    % low frequency bands are usually omnidirectional 
    % (in the TU database)
    if( isOmniDirectional( pnm_v ) == true )
        pnm( :, kk ) = NaN;
    end
end

% ==============================================================================
% Replace repeated frequency bands with NaN
% starting with the last band
for kk = numFrequencyBands : -1 : 2
    band1 = pnm( :, kk );
    band2 = pnm( :, kk-1 );
    diff_v = max( abs( diff( band1 - band2 ) ) );
    if( diff_v == 0 )
        pnm( :, kk ) = NaN;
    end
end

radiation.pnm = pnm;

end

%%
function isOmni_b = isOmniDirectional( pnm_v )
    
    for kk = 2 : length( pnm_v )
        if( abs( pnm_v( kk ) ) ~= 0 )
            isOmni_b = false;
            return;
        end
    end

    isOmni_b = true;
end


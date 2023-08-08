function [ bnm_v ] = RotateSH( anm_v, quat_v, kind_s )

% ==============================================================================
% Rotate a set of SH coefficients anm_v by the given (unit) quaternion quat_v
%
% kind_s : kind of SH coefficients ('real' or 'complex')
% ==============================================================================

if( ContainsNaN( anm_v ) == true )
    % contains NaN.
    bnm_v = anm_v;
    return;
end

% must be a vector
assert( size( anm_v, 1 ) == 1 || size( anm_v, 2 ) == 1 );

% must be a (unit) quaternion
assert( length( quat_v ) == 4 );
assert( isreal( quat_v ) == true );

needTranspose = false;
if( size( anm_v, 1 ) < size( anm_v, 2 ) )
    needTranspose = true;
    anm_v = anm_v.';
end

if( strcmpi( kind_s, 'real' ) == true )
    bnm_v = RotateRealSH( anm_v, quat_v );
elseif ( strcmpi( kind_s, 'complex' ) == true )
    bnm_v = RotateComplexSH( anm_v, quat_v );
else
    % unexpected SH kind !
    assert( false );
end

if( needTranspose == true )
    anm_v = anm_v.';
    bnm_v = bnm_v.';
end

% rotation should preserve the shape of the array
assert( size( bnm_v, 1 ) == size( anm_v, 1 ) );
assert( size( bnm_v, 2 ) == size( anm_v, 2 ) );

% rotation should preserve the norm of the SH coefficients !
assert( abs( norm( anm_v ) - norm( bnm_v ) ) < 1e-6 );

end

%%
function [ bnm_v ] = RotateRealSH( anm_v, quat_v )

% ==============================================================================
% Rotate a set of real SH coefficients anm_v by the given (unit) quaternion quat_v
% ==============================================================================

% must be real
assert( isreal( anm_v ) == true );

rotationMatrix_m = getRotationMatrix( anm_v, quat_v, 'real' );

assert( isreal( rotationMatrix_m ) == true );

bnm_v = rotationMatrix_m * anm_v;

end

%%
function [ bnm_v ] = RotateComplexSH( anm_v, quat_v )

% ==============================================================================
% Rotate a set of complex SH coefficients anm_v by the given (unit) quaternion quat_v
% ==============================================================================

rotationMatrix_m = getRotationMatrix( anm_v, quat_v, 'complex' );
bnm_v = rotationMatrix_m * anm_v;

end

%%
function [ rotationMatrix_m ] = getRotationMatrix( anm_v, quat_v, kind_s )

hoaOrder = NumComponentsToOrder( length( anm_v ) );

rot3x3_m         = QuaternionToMatrix( quat_v );

% this requires the "Spherical-Harmonic-Transform" toolbox
% https://github.com/polarch/Spherical-Harmonic-Transform
% See also InitializePath.m
rotationMatrix_m = getSHrotMtx( rot3x3_m, hoaOrder, kind_s );

if( strcmp( kind_s, 'complex' ) == true )
    % For some reason, the rotation matrix calculated by getSHrotMtx()
    % needs to be conjugated. Not entirely sure why.
    % Depends on intrinsic vs extrinsic convention ?
    rotationMatrix_m = conj( rotationMatrix_m );
end

assert( size( rotationMatrix_m, 2 ) == size( anm_v, 1 ) );

end

function [ rot3x3_m, maxCorrelation, winner_quat_v ] = ...
    MaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s, ignorePhase )

% ==============================================================================
% find the 3x3 rotation that maximizes the spherical correlation
% between SH coefficients anm_v and bnm_v
% quats_m : the list of quaternions sampling SO(3) for our search space
% kind_s : kind of SH coefficients ('real' or 'complex')
% ignorePhase : ignore the sign of the correlation
%
% rot3x3_m, winner_quat_v : the 3x3 rotation matrix (and its equivalent unit quaternion) that reaches
% the optimal rotational matching
% maxCorrelation : normalized cross-correlation, for this optimal rotational matching
% ==============================================================================

if( nargin < 5 )
    ignorePhase = true;
end

if( strcmpi( kind_s, 'real' ) == true ...
 || strcmpi( kind_s, 'complex' ) == true )
    [ rot3x3_m, maxCorrelation, winner_quat_v ] = ...
        internalMaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s, ignorePhase );
else
    % unexpected SH kind !
    assert( false );
end

end

%%
function [ rot3x3_m, maxCorrelation, winner_quat_v ] = ...
    internalMaximimeCorrelationSH( anm_v, bnm_v, quats_m, kind_s, ignorePhase )

% ==============================================================================
% find the 3x3 rotation that maximizes the spherical correlation
% between SH coefficients anm_v and bnm_v
% quats_m : the list of quaternions sampling SO(3) for our search space
% ignorePhase : ignore the sign of the correlation
%
% rot3x3_m, winner_quat_v : the 3x3 rotation matrix (and its equivalent unit quaternion) that reaches
% the optimal rotational matching
% maxCorrelation : normalized cross-correlation, for this optimal rotational matching
% ==============================================================================

if( nargin < 4 )
    ignorePhase = true;
end

if( ContainsNaN( anm_v ) == true ...
 || ContainsNaN( bnm_v ) == true )
    % contains NaN.
    maxCorrelation  = NaN;
    rot3x3_m        = ones( 3, 3 ) .* NaN;
    winner_quat_v   = ones( 1, 4 ) .* NaN;
    return;
end

assert( size( quats_m, 2 ) == 4 );  % 4 elements for a quaternion [x y z w]
assert( size( quats_m, 1 ) > 10 );  % SO(3) needs to be sampled more finely !


correlationBeforeRotationalMatching = NormalizedCorrelationSH( anm_v, bnm_v, kind_s );
maxCorrelation = correlationBeforeRotationalMatching;
%winner_quat_v  = EulerZYZToQuaternion(0,0,0);
winner_quat_v  = [ 0 0 0 1 ];

numSamplesToTest = size( quats_m, 1 );

% explore all rotations.
% obviously, this can be very very lengthy (and not optimized)
for kk = 1 : numSamplesToTest

    quat_v = quats_m( kk, : );

    rotated_anm_v = RotateSH( anm_v, quat_v, kind_s );

    % correlation between rotated anm and bnm
    corr = NormalizedCorrelationSH( rotated_anm_v, bnm_v, kind_s );

    if( ignorePhase == true )
        % ignore the sign of the correlation
        corr = abs( corr );
    end

    if( corr > maxCorrelation )
        maxCorrelation = corr;
        winner_quat_v = quat_v;
    end
end

rot3x3_m = QuaternionToMatrix( winner_quat_v );

% correlation must be higher after rotational matching
% (unless if the SO(3) sampling grid does not contain identity)
correlationAfterRotationalMatching = maxCorrelation;
if( abs( correlationAfterRotationalMatching ) < abs( correlationBeforeRotationalMatching ) )
    disp( [ 'correlation before rotational matching = ' num2str( abs(correlationBeforeRotationalMatching) ) ] );
    disp( [ 'correlation after rotational matching = ' num2str( abs(correlationAfterRotationalMatching) ) ] );
end

end


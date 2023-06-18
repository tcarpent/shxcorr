function [ correlation_f ] = NormalizedCorrelationSH( anm_v, bnm_v, kind_s, shouldCenter )

% ==============================================================================
% Computes the normalized correlation between two sets of spherical harmonics coefficients
% anm_v and bnm_v. 
%
% kind_s : kind of SH coefficients ('real' or 'complex')
% shouldCenter : center data (i.e. remove spatial mean)
% ==============================================================================

if( nargin < 4 )
    shouldCenter = false;
end

if( ContainsNaN( anm_v ) == true ...
 || ContainsNaN( bnm_v ) == true )
    % NaN if anm or bnm have NaN
    correlation_f = NaN;
    return;
end

% SH coefficients must have the same length
assert( length( anm_v ) == length( bnm_v ) );

if( strcmpi( kind_s, 'real' ) == true )
	correlation_f = NormalizedCorrelationRealSH( anm_v, bnm_v, shouldCenter );
elseif ( strcmpi( kind_s, 'complex' ) == true )
	correlation_f = NormalizedCorrelationComplexSH( anm_v, bnm_v, shouldCenter );
else
	% unexpected SH kind !
	assert( false ); 
end

end

%%
function [ correlation_f ] = NormalizedCorrelationRealSH( anm_v, bnm_v, shouldCenter )

% ==============================================================================
% Computes the normalized correlation between two sets of real-valued spherical harmonics coefficients
%
% shouldCenter : center data (i.e. remove spatial mean)
% ==============================================================================

% This function is for real-value SH coefficients
assert( isreal( anm_v ) == true );
assert( isreal( bnm_v ) == true );

% the formula for complex SH are valid for real SH too.
correlation_f = NormalizedCorrelationComplexSH( anm_v, bnm_v, shouldCenter );

assert( isreal( correlation_f ) == true );

end

%%
function [ correlation_f ] = NormalizedCorrelationComplexSH( anm_v, bnm_v, shouldCenter )

% ==============================================================================
% Computes the normalized correlation between two sets of complex-valued spherical harmonics coefficients
%
% shouldCenter : center data (i.e. remove spatial mean)
% ==============================================================================

% transpose if necessary
if( size( anm_v, 1 ) < size( anm_v, 2 ) ) 
    anm_v = anm_v.';
end
if( size( bnm_v, 1 ) < size( bnm_v, 2 ) ) 
    bnm_v = bnm_v.';
end

if( shouldCenter == true )
    % remove the spatial mean (= W component)
    meanA = anm_v(1);
    meanB = bnm_v(1);
    anm_v = (anm_v - meanA);
    bnm_v = (bnm_v - meanB);
end

normA = anm_v' * anm_v;
normB = bnm_v' * bnm_v;

assert( isreal( normA ) == true );
assert( isreal( normB ) == true );

denominator = sqrt( normA * normB );

if( denominator < eps )
    % both anm and bnm are zeros
    correlation_f = 1;
    return;
end

numerator   = bnm_v' * anm_v;

correlation_f = numerator / denominator;

% sanity check
assert( abs( correlation_f ) <= 1.00001 );

end



function [ quats_m ] = TU_GetSO3Sampling( oversampling )

% ==============================================================================
% Returns a sampling grid for SO(3), appropriate for TU Berlin database (4th order)
%
% oversampling : oversampling factor
% ==============================================================================

if( nargin < 1 )
    oversampling = 1;
end

assert( oversampling >= 1 );

% Generate sampling for SO(3)
maxOrder = TU_GetMaxOrder();   
B = maxOrder + 1;   % bandwidth

% number of samples, for each Euler angle :
numSamples   = round( (2*B) * oversampling );

quats_m      = SO3SamplingUsingEulerAngles( maxOrder, numSamples );

end

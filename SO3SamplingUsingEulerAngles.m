function [ quats_m ] = ...
        SO3SamplingUsingEulerAngles( maxOrder, numSamples )

% ==============================================================================
% Generates a sampling grid for SO(3), based on ZYZ Euler angles
% numSamples : the number of samples, for each Euler angle.
% (the total size of the grid is therefore numSamples^3)
%
% quats_m : unit quaternions
% ==============================================================================


% bandwidth of the function
B = ( maxOrder + 1 );

if( nargin < 2 )
	% default value
    numSamples = 2*B;
end

assert( IsUnsignedInt( numSamples ) == true );

% the sampling resolution must be AT LEAST 2*B
assert( numSamples >= 2*B );

gridSize   = numSamples;

% precaution (to avoid extra long computation times)
gridSize = min( gridSize, 360 );

% oversamplingFactor = gridSize / (2*B);

% 2B x 2B x 2B
totalSize = gridSize * gridSize * gridSize;

quats_m = zeros( totalSize, 4 );

offset = 1;
for ii = 0 : 1 : (gridSize-1)
    for jj = 0 : 1 : (gridSize-1)
        for kk = 0 : 1 : (gridSize-1)
            alpha = ii * (2 * pi) / gridSize;
            beta  = (2 * jj + 1) * pi / ( 2 * gridSize );
            gamma = kk * (2 * pi) / gridSize;

            % need to swap alpha and gamma ?
            quat_v = EulerZYZToQuaternion( gamma, beta, alpha );
            
            quats_m( offset, : ) = quat_v;

            offset = offset + 1;
        end
    end
end

end


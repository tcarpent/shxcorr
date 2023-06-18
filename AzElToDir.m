function dir_v = AzElToDir( azimuth, elevation )

theta = pi/2 - deg2rad( elevation );    % elevation
phi   = deg2rad( 90 - azimuth );        % azimuth
dir_v = [ phi theta ];

end

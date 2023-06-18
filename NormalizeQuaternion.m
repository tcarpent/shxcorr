function quat_v = NormalizeQuaternion( quat_v )
   
% ==============================================================================
% Normalizes the input quaternion, so that is has unit length
% ==============================================================================

assert( length( quat_v ) == 4 );
assert( isreal( quat_v ) == true );

x = quat_v(1);
y = quat_v(2);
z = quat_v(3);
w = quat_v(4);
quatLength = sqrt( x * x + y * y + z * z + w * w );

if( quatLength > 1e-4 )
    quat_v = quat_v .* ( 1 / quatLength );
end

end

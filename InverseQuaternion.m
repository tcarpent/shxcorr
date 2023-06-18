function inv_quat_v = InverseQuaternion( quat_v )

% ==============================================================================
% Returns the inverse quaternion
% ==============================================================================

assert( length( quat_v ) == 4 );
assert( isreal( quat_v ) == true );

x = quat_v(1);
y = quat_v(2);
z = quat_v(3);
w = quat_v(4);

inv_quat_v = [-x -y -z w];

end

function [ output ] = Clamp( input, min, max )

assert( min < max );
output = min( max( input, min ), max );

end

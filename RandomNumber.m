function value = RandomNumber( minValue, maxValue )

% ==============================================================================
% Generates a random number in the [ minValue, maxValue ] range
% ==============================================================================

assert( minValue < maxValue );
value = minValue + (maxValue - minValue) * rand(1);

assert( minValue <= value );
assert( value <= maxValue );

end
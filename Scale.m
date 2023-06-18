function output = Scale( input, minimumIn, maximumIn, minimumOut, maximumOut )

assert( maximumIn ~= minimumIn );

scaling = ( maximumOut - minimumOut ) / ( maximumIn - minimumIn );
output  = minimumOut + ( input - minimumIn ) .* scaling;

end

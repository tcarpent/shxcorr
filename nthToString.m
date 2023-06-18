function str = nthToString( num )

str = num2str( num );
if( endsWith( str, '1' ) == true && endsWith( str, '11' ) == false )
    str = [ str 'st' ];
elseif( endsWith( str, '2' ) == true && endsWith( str, '12' ) == false )
    str = [ str 'nd' ];
elseif( endsWith( str, '3' ) == true && endsWith( str, '13' ) == false )
    str = [ str 'rd' ];
else
    str = [ str 'th' ];
end

end

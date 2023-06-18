function gnm_v = GetWeightingGains( maxOrder, alpha )

assert( 0 <= alpha );
assert( alpha <= 100 );

numComponents = OrderToNumComponents( maxOrder );

gnm_v = ones( 1, numComponents );

if( alpha >= 100 )
    return;
end

if( alpha <= 0 )
    gnm_v = zeros( 1, numComponents );
    gnm_v( 1 ) = 1;
    return;
end

for( nn = 1 : maxOrder )
    
    a01 = alpha / 100;
    
    if( (nn-1)/maxOrder <= a01 && a01 <= nn/maxOrder )
        
        anm_v = zeros( 1, numComponents );
        
        N1 = OrderToNumComponents( nn );
        N2 = OrderToNumComponents( nn-1 );
        
        anm_v(1:N1) = 1;
        
        ratio = Scale( a01, (nn-1)/maxOrder, (nn/maxOrder), 0, 1 );
        ratio = ratio^2;
        
        gnm_v = anm_v;
        for ii = (N2+1):N1
            gnm_v(ii) = ratio;
        end
        
    end
    
end

end

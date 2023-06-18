function howMany = TU_GetNumBrassInstruments( instruments_S )

howMany = 0;
for kk = 1 : length( instruments_S )
    if( TU_GetInstrumentCategory( instruments_S{ kk } ) == 1 )
        howMany = howMany + 1;
    end
end

end

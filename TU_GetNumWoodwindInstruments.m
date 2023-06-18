function howMany = TU_GetNumWoodwindInstruments( instruments_S )

howMany = 0;
for kk = 1 : length( instruments_S )
    if( TU_GetInstrumentCategory( instruments_S{ kk } ) == 2 )
        howMany = howMany + 1;
    end
end

end

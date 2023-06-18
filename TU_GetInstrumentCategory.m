function category = TU_GetInstrumentCategory( instrumentName )

	instrumentName = strrep( instrumentName, ' ', '_' );

    if( startsWith( instrumentName, 'Bassoon' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Contrabassoon' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Natural_trumpet' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Trumpet' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Tenor_trombone' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Bass_trombone' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Viola' ) == true )
        category = 3;
    elseif( startsWith( instrumentName, 'Tuba' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Transverse' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Cello' ) == true )
        category = 3;
    elseif( startsWith( instrumentName, 'Oboe' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'English_horn' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Double_action_harp' ) == true )
        category = 3;
    elseif( startsWith( instrumentName, 'Double_bass' ) == true )
        category = 3;
    elseif( startsWith( instrumentName, 'French_horn' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Clarinet' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Bass_clarinet' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Violin' ) == true )
        category = 3;    
    elseif( startsWith( instrumentName, 'Classic_oboe' ) == true )
        category = 2;    
    elseif( startsWith( instrumentName, 'Romantic_oboe' ) == true )
        category = 2;    
    elseif( startsWith( instrumentName, 'Soprano' ) == true )
        category = 1;   
    elseif( startsWith( instrumentName, 'Classic_bassoon' ) == true )
        category = 2;    
    elseif( startsWith( instrumentName, 'Baroque_bassoon' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Dulcian' ) == true )
        category = 2;  
    elseif( startsWith( instrumentName, 'Timpani' ) == true )
        category = 3;  
    elseif( startsWith( instrumentName, 'Pedal_timpani' ) == true )
        category = 3;     
    elseif( startsWith( instrumentName, 'Natural_horn' ) == true )
        category = 1;    
    elseif( startsWith( instrumentName, 'Acoustic_guitar' ) == true )
        category = 3; 
    elseif( startsWith( instrumentName, 'Keyed_flute' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Baroque_traverse_flute' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Basset_horn' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Alto_trombone' ) == true )
        category = 1;
    elseif( startsWith( instrumentName, 'Alto_saxophone' ) == true )
        category = 2;
    elseif( startsWith( instrumentName, 'Tenor_saxophone' ) == true )
        category = 2;
    else
        assert( false );
    end

end
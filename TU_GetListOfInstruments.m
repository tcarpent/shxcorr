function [ instruments_S ] = TU_GetListOfInstruments()

% instruments_S.all_S : all available data (both ff+pp)
% instruments_S.ff_S : all available instruments, ff only. Alphabetical order
% instruments_S.pp_S : all available instruments, pp only. Alphabetical order
% instruments_S.ff_brass_S : all 'brass' instruments, ff only. Alphabetical order
% instruments_S.ff_woodwind_S : all 'woodwind' instruments, ff only. Alphabetical order
% instruments_S.ff_string_S : all 'string' instruments, ff only. Alphabetical order
% instruments_S.ff_sorted_S : brass + woodwind + string, ff only.
% instruments_S.pp_brass_S : all 'brass' instruments, pp only. Alphabetical order
% instruments_S.pp_woodwind_S : all 'woodwind' instruments, pp only. Alphabetical order
% instruments_S.pp_string_S : all 'string' instruments, pp only. Alphabetical order
% instruments_S.pp_sorted_S : brass + woodwind + string, pp only.
% instruments_S.sorted_S : brass + woodwind + string, ff and pp.

% ==============================================================================
index = 1;
all_S{ index } = 'Acoustic_guitar_modern_et_ff'; index = index + 1;
all_S{ index } = 'Acoustic_guitar_modern_et_pp'; index = index + 1;
all_S{ index } = 'Alto_saxophone_modern_et_ff'; index = index + 1;
all_S{ index } = 'Alto_saxophone_modern_et_pp'; index = index + 1;
all_S{ index } = 'Alto_trombone_historical_et_ff'; index = index + 1;
all_S{ index } = 'Alto_trombone_historical_et_pp'; index = index + 1;
all_S{ index } = 'Baroque_bassoon_historical_et_ff'; index = index + 1;
all_S{ index } = 'Baroque_bassoon_historical_et_pp'; index = index + 1;
all_S{ index } = 'Baroque_traverse_flute_historical_et_ff'; index = index + 1;
all_S{ index } = 'Baroque_traverse_flute_historical_et_pp'; index = index + 1;
all_S{ index } = 'Bass_clarinet_modern_et_ff'; index = index + 1;
all_S{ index } = 'Bass_clarinet_modern_et_pp'; index = index + 1;
all_S{ index } = 'Bass_trombone_historical_et_ff'; index = index + 1;
all_S{ index } = 'Bass_trombone_historical_et_pp'; index = index + 1;
all_S{ index } = 'Bass_trombone_modern_et_ff'; index = index + 1;
all_S{ index } = 'Bass_trombone_modern_et_pp'; index = index + 1;
all_S{ index } = 'Basset_horn_historical_et_ff'; index = index + 1;
all_S{ index } = 'Basset_horn_historical_et_pp'; index = index + 1;
all_S{ index } = 'Bassoon_modern_et_ff'; index = index + 1;
all_S{ index } = 'Bassoon_modern_et_pp'; index = index + 1;
all_S{ index } = 'Cello_historical_et_ff'; index = index + 1;
all_S{ index } = 'Cello_historical_et_pp'; index = index + 1;
all_S{ index } = 'Cello_modern_et_ff'; index = index + 1;
all_S{ index } = 'Cello_modern_et_pp'; index = index + 1;
all_S{ index } = 'Clarinet_historical_et_ff'; index = index + 1;
all_S{ index } = 'Clarinet_historical_et_pp'; index = index + 1;
all_S{ index } = 'Clarinet_modern_et_ff'; index = index + 1;
all_S{ index } = 'Clarinet_modern_et_pp'; index = index + 1;
all_S{ index } = 'Classic_bassoon_historical_et_ff'; index = index + 1;
all_S{ index } = 'Classic_bassoon_historical_et_pp'; index = index + 1;
all_S{ index } = 'Classic_oboe_historical_et_ff'; index = index + 1;
all_S{ index } = 'Classic_oboe_historical_et_pp'; index = index + 1;
all_S{ index } = 'Contrabassoon_modern_et_ff'; index = index + 1;
all_S{ index } = 'Contrabassoon_modern_et_pp'; index = index + 1;
all_S{ index } = 'Double_action_harp_modern_et_ff'; index = index + 1;
all_S{ index } = 'Double_action_harp_modern_et_pp'; index = index + 1;
all_S{ index } = 'Double_bass_historical_et_ff'; index = index + 1;
all_S{ index } = 'Double_bass_historical_et_pp'; index = index + 1;
all_S{ index } = 'Double_bass_modern_et_ff'; index = index + 1;
all_S{ index } = 'Double_bass_modern_et_pp'; index = index + 1;
all_S{ index } = 'Dulcian_historical_et_ff'; index = index + 1;
all_S{ index } = 'Dulcian_historical_et_pp'; index = index + 1;
all_S{ index } = 'English_horn_modern_et_ff'; index = index + 1;
all_S{ index } = 'English_horn_modern_et_pp'; index = index + 1;
all_S{ index } = 'French_horn_modern_et_ff'; index = index + 1;
all_S{ index } = 'French_horn_modern_et_pp'; index = index + 1;
all_S{ index } = 'Keyed_flute_historical_et_ff'; index = index + 1;
all_S{ index } = 'Keyed_flute_historical_et_pp'; index = index + 1;
all_S{ index } = 'Natural_horn_historical_et_ff'; index = index + 1;
all_S{ index } = 'Natural_horn_historical_et_pp'; index = index + 1;
all_S{ index } = 'Natural_trumpet_historical_et_ff'; index = index + 1;
all_S{ index } = 'Natural_trumpet_historical_et_pp'; index = index + 1;
all_S{ index } = 'Oboe_modern_et_ff'; index = index + 1;
all_S{ index } = 'Oboe_modern_et_pp'; index = index + 1;
all_S{ index } = 'Pedal_timpani_et_ff'; index = index + 1;
all_S{ index } = 'Pedal_timpani_et_pp'; index = index + 1;
all_S{ index } = 'Romantic_oboe_historical_et_ff'; index = index + 1;
all_S{ index } = 'Romantic_oboe_historical_et_pp'; index = index + 1;
all_S{ index } = 'Soprano_et_ff'; index = index + 1;
all_S{ index } = 'Soprano_et_pp'; index = index + 1;
all_S{ index } = 'Tenor_saxophone_modern_et_ff'; index = index + 1;
all_S{ index } = 'Tenor_saxophone_modern_et_pp'; index = index + 1;
all_S{ index } = 'Tenor_trombone_historical_et_ff'; index = index + 1;
all_S{ index } = 'Tenor_trombone_historical_et_pp'; index = index + 1;
all_S{ index } = 'Tenor_trombone_modern_et_ff'; index = index + 1;
all_S{ index } = 'Tenor_trombone_modern_et_pp'; index = index + 1;
all_S{ index } = 'Timpani_et_ff'; index = index + 1;
all_S{ index } = 'Timpani_et_pp'; index = index + 1;
all_S{ index } = 'Transverse_flute_modern_et_ff'; index = index + 1;
all_S{ index } = 'Transverse_flute_modern_et_pp'; index = index + 1;
all_S{ index } = 'Trumpet_modern_et_ff'; index = index + 1;
all_S{ index } = 'Trumpet_modern_et_pp'; index = index + 1;
all_S{ index } = 'Tuba_modern_et_ff'; index = index + 1;
all_S{ index } = 'Tuba_modern_et_pp'; index = index + 1;
all_S{ index } = 'Viola_historical_et_ff'; index = index + 1;
all_S{ index } = 'Viola_historical_et_pp'; index = index + 1;
all_S{ index } = 'Viola_modern_et_ff'; index = index + 1;
all_S{ index } = 'Viola_modern_et_pp'; index = index + 1;
all_S{ index } = 'Violin_historical_et_ff'; index = index + 1;
all_S{ index } = 'Violin_historical_et_pp'; index = index + 1;
all_S{ index } = 'Violin_modern_et_ff'; index = index + 1;
all_S{ index } = 'Violin_modern_et_pp'; index = index + 1;

% ==============================================================================
index = 1;
for kk = 1 : length( all_S )
    inst = all_S{ kk };
    if( endsWith( inst, '_et_ff' ) == true )
        ff_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( all_S )
    inst = all_S{ kk };
    if( endsWith( inst, '_et_pp' ) == true )
        pp_S{ index } = inst;
        index = index + 1;
    end
end

assert( length( pp_S ) == length( ff_S ) );
assert( length( pp_S ) + length( ff_S ) == length( all_S ) );

% ==============================================================================
index = 1;
for kk = 1 : length( ff_S )
    inst = ff_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 1 )
        ff_brass_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( ff_S )
    inst = ff_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 2 )
        ff_woodwind_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( ff_S )
    inst = ff_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 3 )
        ff_string_S{ index } = inst;
        index = index + 1;
    end
end

% ==============================================================================
index = 1;
for kk = 1 : length( pp_S )
    inst = pp_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 1 )
        pp_brass_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( pp_S )
    inst = pp_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 2 )
        pp_woodwind_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( pp_S )
    inst = pp_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 3 )
        pp_string_S{ index } = inst;
        index = index + 1;
    end
end

% ==============================================================================
index = 1;
for kk = 1 : length( ff_brass_S )
    ff_sorted_S{ index } = ff_brass_S{ kk };
    index = index + 1;
end
for kk = 1 : length( ff_woodwind_S )
    ff_sorted_S{ index } = ff_woodwind_S{ kk };
    index = index + 1;
end
for kk = 1 : length( ff_string_S )
    ff_sorted_S{ index } = ff_string_S{ kk };
    index = index + 1;
end

% ==============================================================================
index = 1;
for kk = 1 : length( pp_brass_S )
    pp_sorted_S{ index } = pp_brass_S{ kk };
    index = index + 1;
end
for kk = 1 : length( pp_woodwind_S )
    pp_sorted_S{ index } = pp_woodwind_S{ kk };
    index = index + 1;
end
for kk = 1 : length( pp_string_S )
    pp_sorted_S{ index } = pp_string_S{ kk };
    index = index + 1;
end

% ==============================================================================
index = 1;
for kk = 1 : length( all_S )
    inst = all_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 1 )
        brass_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( all_S )
    inst = all_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 2 )
        woodwind_S{ index } = inst;
        index = index + 1;
    end
end

index = 1;
for kk = 1 : length( all_S )
    inst = all_S{ kk };
    category = TU_GetInstrumentCategory( inst );
    if( category == 3 )
        string_S{ index } = inst;
        index = index + 1;
    end
end

% ==============================================================================
index = 1;
for kk = 1 : length( brass_S )
    sorted_S{ index } = brass_S{ kk };
    index = index + 1;
end
for kk = 1 : length( woodwind_S )
    sorted_S{ index } = woodwind_S{ kk };
    index = index + 1;
end
for kk = 1 : length( string_S )
    sorted_S{ index } = string_S{ kk };
    index = index + 1;
end

%%
instruments_S.all_S = all_S;
instruments_S.ff_S  = ff_S;
instruments_S.pp_S  = pp_S;

instruments_S.ff_brass_S     = ff_brass_S;
instruments_S.ff_woodwind_S  = ff_woodwind_S;
instruments_S.ff_string_S    = ff_string_S;
instruments_S.ff_sorted_S    = ff_sorted_S;

instruments_S.pp_brass_S     = pp_brass_S;
instruments_S.pp_woodwind_S  = pp_woodwind_S;
instruments_S.pp_string_S    = pp_string_S;
instruments_S.pp_sorted_S    = pp_sorted_S;

instruments_S.brass_S        = brass_S;
instruments_S.woodwind_S     = woodwind_S;
instruments_S.string_S       = string_S;
instruments_S.sorted_S       = sorted_S;

end

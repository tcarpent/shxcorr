function instrument_s = TU_GetInstrumentFromFilename( filename_s )

% Example : 
% '~/Downloads/2_Directivities/SingleTones/centered/Clarinet_modern_et_ff.mat'
% --> return 'Clarinet_modern_et_ff'

indexOfLastSlash = strfind( filename_s, filesep );
if( isempty( indexOfLastSlash ) == false )
    indexOfLastSlash = max( indexOfLastSlash );
    indexOfLastSlash = indexOfLastSlash + 1;
else
    indexOfLastSlash = 1;
end

instrument_s = filename_s( indexOfLastSlash : end );

indexOfDot = strfind( instrument_s, '.mat' );
if( isempty( indexOfDot ) == false )
    instrument_s = instrument_s( 1 : indexOfDot-1 );
end

end

function folder_s = TU_GetSingleTonesFolder()

% folder containing the SingleTones data, with acoustic centering
folder_s = [ TU_GetDirectivitiesFolder() filesep 'SingleTones' filesep 'centered' ];
end

function SetFont( fontSize )

% ==============================================================================
% Change font size in the current figure
% ==============================================================================

% get the handle of the current figure without forcing the creation of a figure if one does not exist
figHandle = get( groot, 'CurrentFigure' );

%%
if( isempty( figHandle ) )
    return;
end

%%
% set the font size and font face for all children:
% legend, axes, colorbar, etc.
for ii = 1 : length( figHandle.Children )

    child = figHandle.Children( ii );

    if strcmp( child.Type, 'uicontextmenu' ) == false
        set( child, 'FontSize', fontSize );
        set( child, 'FontName', 'Arial' );
    end
end

end

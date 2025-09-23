function askThreshold()
    
    global threshold;

    screen_size = get(0, 'MonitorPositions'); % gets the monitor size.
                                              % Consider that multiple
                                              % monitors might be involved.
    window_width = 450;
    window_height = 200;

    window_pos = [(screen_size(3) - window_width)/2 ...
                  (screen_size(4) - window_height)/2 ...
                  window_width ...
                  window_height];

    text_size = 15;

    fig = uifigure('Name','Threshold Input','Position', window_pos, ...
                   'Resize','off','WindowStyle','modal', ...
                   'CloseRequestFcn',@(src,evt) cancelAction(fig)); % X button = Cancel

    % Title / instruction text
    uilabel(fig, 'Text','Enter overheat detection threshold (0–200 °C):', ...
                 'Position',[0 135 window_width 2*text_size], ...
                 'FontSize', 15, 'FontWeight','bold', 'HorizontalAlignment','center');

    % Numeric edit field
    numField = uieditfield(fig, 'numeric', ...
                                'Position',[160 90 100 30], ...
                                'Limits',[0 200], 'Value',100, 'FontSize',14);

    % OK button
    uibutton(fig,'push','Text','OK', ...
                 'Position',[110 30 80 30], ...
                 'ButtonPushedFcn',@(btn,event) okAction(fig,numField));

    % Cancel button
    uibutton(fig,'push','Text','Cancel', ...
                 'Position',[230 30 80 30], ...
                 'ButtonPushedFcn',@(btn,event) cancelAction(fig));

    % Key press handling (Enter = OK, Esc = Cancel)
    fig.KeyPressFcn = @(src,event) keyHandler(event,fig,numField);

    % Wait for user input
    uiwait(fig);

    % Check outcome
    if isvalid(fig) && isappdata(fig,'cancel')
        threshold = []; % User canceled
    elseif isvalid(fig)
        threshold = numField.Value; % Valid number
    else
        threshold = [];
    end

    % Close figure
    if isvalid(fig)
        delete(fig);
    end
end

function okAction(fig,numField)
    val = numField.Value;
    if isempty(val) || isnan(val) || val < 0
        uialert(fig,'Please enter a valid non-negative number (0, 200 °C).','Invalid Input');
    else
        uiresume(fig);
    end
end

function cancelAction(fig)
    setappdata(fig,'cancel',true);
    uiresume(fig);
end

function keyHandler(event,fig,numField)
    switch event.Key
        case 'return'   % Enter key
            okAction(fig,numField);
        case 'escape'   % Escape key
            cancelAction(fig);
    end
end
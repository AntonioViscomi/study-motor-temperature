function displayReport(timestamps, temperature, diagnostic)
    
    arguments
        timestamps  (1,:) {mustBeVector}
        temperature (1,:) double
        diagnostic struct
    end
    
    plotOverheatingZones(timestamps, temperature, diagnostic.mask.OVERHEAT, diagnostic.regions.OVERHEAT);
    
    printDiagnosticMarkdown(timestamps, diagnostic)

end
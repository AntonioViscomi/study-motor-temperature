function experimentData = loadData()

    [experimentName, experimentPath] = uigetfile({'*.mat','Data Files (*.mat)'}, ...
                                                  'Select the real data to run the test.');

    experimentData = load([experimentPath experimentName]);

end
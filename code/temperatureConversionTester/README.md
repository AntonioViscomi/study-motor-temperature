# temperatureConversionTester

This module is a working application for checking the conversion method used in the class `ITemperatureSensor` in `embObjMotionControl` for transforming the temperature data from raw value (as managed by the `2FOC` and `EMS` board, i.e. in the fw side) to the value in Celsius degree usable by the user (in the sw side) and viceversa. 
It is important to note that, as defined in the documentation for `ITemperatureSensor` class, the conversion methods can be used only with the temperature detection sensors `PT100` and `PT1000`.
Moreover, the input files must be formatted as the one available as an example in the `data` folder. Basically, they must be formatted in 2 columns divided by a `|` (pipe). The first column contains the temperatures in Celsius degree, while the second column has the raw temperature values as written in the `PT100` and `PT1000` tables, which can be found online.

## Module description

Specifically to this example, we are simply reading file of input data and writing the final data to an output file. This output file is organized as follows:
- 1st column: input temperature in Celsius
- 2nd column: input raw temperature
- 3rd column: output converted temperature in Celsius
- 4th column: output converted raw temperature
- 5th column: delta between input and converted temperatures in Celsius
- 6th column: delta between input and converted raw values

## General code architecture

Considering the code itself, it is quite simple. The input values are read and saved into vectors. Then they are converted from raw to Celsius and viceversa and all the values with the relative deltas are written in the output file.

Currently, we can check the conversion only for the TDB setup that we are using, which can be connected to a `PT100` or to a `PT1000` temperature resistor.

## Usage of the application module

In order to use this module the following steps should be done:

- create inside the project the `build` directory
- run the commands in order:
    
    ```
    cd build
    ccmake ../
    make
    make install (eventually if wanna install on local)
    ```
- run with the following command:
  
    - if user test it using the default files provided in `data` folder
        ```
        ./build/TemperatureConvRuleTester <sensor_type> 
        ```
    - if user use its own files:
        ```
        ./build/TemperatureConvRuleTester <sensor_type> <input_file_path> <output_file_path>
        ```


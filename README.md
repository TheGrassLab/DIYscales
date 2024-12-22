# DIYscales
Below are some openSCAD files and Arduino code to make your own scales.

**'doubleHole' files**
-The files with 'doubleHole' in the name are a design that accommodates strain gauges with two holes on each end for attachment.  The strain gauges I ordered came from AliExpress, however, they were quite temperature sensitive and did not work very well for my purpose, but I'm leaving the files in here in case we (or someone) needs them in the future.
- Thread size of the screw holes on strain gauge are ...


**files with 'sparkfun' in the name**
- The files with 'sparkfun' in the name use 5kg strain gauges that I ordered through Spark Fun (sparkfun.com).  These strain gauges are much more stable (ie. less temperature sensitive) but only have 1 hole at each end for attachment.
- Thread size of the screw holes on strain gauge are ...

The Arduino code can be found inside the 'DIYscale_4scales' folder.  As the name suggests, this particular code is written to collect the data from 4 scales.  it is also important to note that I wrote this code for a Adafruit Feather M0 with an RTC module attached.  If you are using a different microcontroller you will need to adjust the pin designations.  At some point I will go through and comment the Arduino code better than how it is currently commented.




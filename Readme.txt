Different (hardware) methods to drive large arrays of vibration motors.

1) I2C

Roughly based upon the Adafruit 16* Servo board with the PCA9685, includes driver for 16 vibration motors and an adjustable voltage regulator for the motors and the driver. Easiest way to solder (and cheapest), easy to use, and up to 62 boards in a row thanks to six dress pins (solder different resistors)

2) Serial

Misuse of the WS2811 LED driver, you can also drive up to 3 vibration motors with on chip (instead of the three colors), in this case we use just one for a vibration motor and the other two for control less. As a result, up to 1024 of these boards can be daisy chained, using the same programs and library as for the led strips. Main disadvantage for a wearable use case is that if one of these breaks, the rest behind will be dead as well. Therefore use only for static devices.

3) Parallel

A dedicated micro controller (in this case: A MSP430G2553 (small package and two wire programming interface)) drives up to four vibration motors. Wiring is done with a standard 4 wire flat ribbon cable with crimped connectors. A voltage regulator board in certain distances (corresponding to power consumption - see max current for flat ribbon cables) will regulate voltage down from a higher supply voltage. While wiring is easy, you have to program each controller with a unique ID (all boards receive serial commands parallel) - the programing interface is also included in the 4 wire connector.

Can be found in the deprecated files, at the moment we use the I2C version, with 3D-design files for holder for 
- Intel Realsense Camera
- Up Bord (Chassis from https://sketchfab.com/models/c38cb411538d41c281d08b0f8ed3b875)
- Battery Pack  (Sandberg PowerBank 18200)
- Wires, PCBs
- Motor (5mm diameter, 8mm length, integrated excenter)


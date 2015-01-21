# powerduino
Monitor power usage (kWh) with Arduino and Nagios / Icinga

This project includes the following components:
- Arduino code for reading a photo resistor pulse and write output over USB serial
- Icinga/Nagios plugin for reading USB serial output from the Arduino.
- Icinga/nagios configuration example
- MySQL/MariaDB database definition

Arduino setup
-------------
The included code assumes that the photo resitor is connected to analog input pin 0, but you
can easily alter the code if you want to use another pin. Use a 10K ohm pull down resistor 
connected to ground. The Arduino will output it's reading over USB serial.
To get a proper fit over the pulse light from your power meter you can print out and use the
included 3D model

Icinga/nagios setup
-------------------
The included perl script will try to read from the USB port where the Arduino is connected. 
With my Arduino Nano this was /dev/ttyUSB0, but you might have to change this.
The user running the script must be in the dialout group (on Debian at least), and I run it using 
screen:

/usr/bin/screen -S powerusage <YOURPATH>/readpowerusage.pl

Detach from screen using ctrl+a+d.

This script will continuously read from the USB port and write the power usage readings to
the MySQL/MariaDB database. Please remember to adjust the SQL username/password/database settings
to your environment.

The included icinga/nagios perl plugin reads from the SQL database and outputs power usage
readings to the icinga/nagios, along with performance data. I personally recommend pnp4nagios 
to graph the performance data.

MySQL/MariaDB setup
-------------------
To set up the database use the following commands. These settings must be updated in the included
perl scripts:

% mysql -uroot -p
mysql> create database powerusage;
mysql> grant all on powerusage.* to power@localhost identified by 'YOURPASSWORD';

% mysql -uroot -p powerusage < sql/powerusage.sql

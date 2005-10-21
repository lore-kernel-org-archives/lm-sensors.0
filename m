From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 21 Oct 2005 11:15:41 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <4358B291.6070702@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

As promised some time ago here is a new version of the Abit uGuru 
driver, this version fully supports the sensor part of the uGuru, that 
means it supports the following:

-reading all sensors
-reading and writing min/max settings for all sensors
-reading/writing settings for all sensors (enable alarm, beep, shutdown)
-reading alarms
-configuring the fan speed control (quiet fan or whatever buzzword)

I would like to submit the libsensors part here and the driver upstream, 
so please review.

Thanks,

Hans


For some more info I've also written a small readme, see Attachment.
-------------- next part --------------
Abit Uguru driver README.
============
This driver supports the sensor part of the custom Abit uGuru chip found
on Abit uGuru motherboards. Currently it has been tested on an Abit KV8
Pro, AV8, AX8 and AN8-SLI. The openguru program this driver is based on
has also been successfully tested on: Abit AV8 3rd Eye, AN8 Ultra and AN7.

Unfortunatly there are no specs for this chip, this driver is based on reverse
enginering done by Olle Sandberg <ollebull@gmail.com> and some additional
reverse engineering done by me. I would like to express my thanks to Olle,
this driver couldnot have been written without his efforts.

Because of the lack of specs only the sensors part of the uGuru is
supported. IOW the voltage / clock programming is NOT supported.


Installing:
=====
Driver
------

This version of the driver is meant for out of tree compilation, although it
should work fine in tree, I don't have the makefile mods to make it work
in tree. Because of rescent hwmon api changes this driver needs kernel
2.6.13 or newer, compiled with sensors support.

Just type "make" in the directory containing Makefile and abituguru.c . This
will give you an abituguru.ko file, you can copy this to
/lib/modules/xxx/kernel/drivers/hwmon if you want, or use it from its current
location.

To load the driver type:
modprobe i2c-isa
modprobe hwmon
insmod <path-to>/abituguru.ko

If the driver fails to load you can try:
insmod <path-to>/abituguru.ko force=1

Now you should have a /sys/bus/i2c/devices/9191-00e0/ dir with a bunch of
files for all your sensors, you can read them with "cat <file>".

Userspace support
-----------------
To make libsensors programs (sensors ksensors) recognize the driver you
also need to patch libsensors, this can be done by checking out the latest
version of the lm_sensors code out of CVS, applying userspace.patch to the
lm_sensors source and then building and installing libsensors.

Once libsensors is installed you need to edit /etc/sensors.conf to match
your motherboard, the Abit uGuru part is at the bottom of the file. If you
have a motherboard which is not listed there I would appreciate it if you
could send me a mail with the settings for your motherboard.

Now run "sensors" and enjoy. Note: support for reading the alarms hasn't been
added to userspace yet.


Optional features
========
There are several files under /sys/bus/i2c/devices/9191-00e0/ for which
libsensors doesn't have support but which may still be usefull. Note: all
filenames below are relative to /sys/bus/i2c/devices/9191-00e0/ .

To set read/write values you can use:
echo "<value>">/sys/bus/i2c/devices/9191-00e0/<file>

Sensors
-------

* alarm_in
This read only file is a bitmask containing a 1 for all volt sensors who's
reading is or has been past its tresholds. Note that all bitmasks are read
decimal when catting, so if the first 11 volt sensors are past there treshold
this file will contain 2047. If in2 is past its treshold it will hold 4, etc.

* alarm_temp, alarm_fan
Idem, but then for temp resp fan sensors.

* enable_in, enable_temp, enable_fan
This read/write (decimal) bitmask contains a 1 for all sensors whos alarm is
enabled. If a sensors alarm is not enabled, passing its treshold will not
result in a 1 showing up in alarm_in, nor will it beep or cause a shutdown.

* beep_in, beep_temp, beep_fan
Read/write (decimal) bitmask, enabled sensors with a 1 in this bitmask will
cause the PC-speaker to beep if an alarm occurs.

* shutdown_in, shutdown_temp, shutdown_fan
Read/write (decimal) bitmask, enabled sensors with a 1 in this bitmask will
cause the computer to shutdown if an alarm persist for a certain amount of
time (usually 30 seconds).

Fan PWM (speed control) (only fans 1-3)
---------------------------------------

* enable_fan_pwm
This read/write (decimal) bitmask contains a 1 for all fans whos speed is
controlled depending on the temperature, fans for which pwm is disabled or
which don't have a pwm (fan > 3) always run at max speed.

* fanX_temp_sensor
This read/write file contains the number of the temperature sensor to use to
control the speed of the fan. It is wise to never use a different sensor no
then 1 for fan 1 (cpu temp for cpu fan). For other fans you can play with
this.

* fanX_temp_min
This read/write file contains the temperature in degrees celcius below which
the fan will always run at its lowest speed.

* fanX_temp_max
This read/write file contains the temperature in degrees celcius above which
the fan will always run at its maximum speed.

* fanX_pwm_min
This read/write file contains the minium speed at which the fan will rotate,
this is a value between 0 and 255 with 0 being standing still and 255 being
max speed. The uGuru seems to ignore values below 170, which is a good thing
since a to low voltage to the fan could cause it to stand still and slowly
burn away.

* fanX_pwm_max
This read/write file contains the maximum speed at which the fan will
rotate, in the same format as fanX_pwm_min.


Questions/comments
=========

You can send any questions you have to me at: <j.w.r.degoede@hhs.nl>, or to
the lm_sensors mailinglist:
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


Copyright/Warranty
=========

This software is licenced under the GNU GPL v2, see COPYING, and as such
comes WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

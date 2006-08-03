From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 03 Aug 2006 07:33:36 +0000
Subject: [lm-sensors] Abit uGuru2 kernel driver release
Message-Id: <44D1A6D0.7040802@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

As most of you know I'm the writer and maintainer of the lm_sensors
driver for the Abit uguru sensors uC. Some time ago I got reports from
various sources that my driver didn't work on newer Abit motherboards.

It turns out that newer Abit uGuru motherboards (2005 and later models)
have a different uGuru uC, which I have named uGuru2.

Thanks to Louis Kruger's hard and great work. I've been able to create
the openguru2 program to read the uGuru2 which some of you all have been
so kind to test.

Now its time for the next step. I've written a kernel driver with the
same capabilities as the opengure2.3.1 program:
http://people.atrpms.net/~hdegoede/abituguru2-0.1.1.tar.gz

To test it untar, cd into the extracted dir and then type:
make
modprobe hwmon
insmod abituguru2.ko
ls /sys/bus/platform/devices/abituguru2.224

The ls should give you a list of all sensors+settings, you can get the
label belonging to a sensor like this:
cat /sys/bus/platform/devices/abituguru2.224/in0_label
And the actual value:
cat /sys/bus/platform/devices/abituguru2.224/in0_input

The others should be pretty much self explaining: min / max are the min
/ max limits before giving an alarm, treshold crit, is the shutdown
treshold for temps. beep / shutdown give you wether or not beep and
shutdown on alarm is enabled. alarm shows if there is an alarm for this
sensors and alarm_enable wether alarms have been enabled for this sensor.

I haven't gotten around to writing libsensors support for this yet, so
don't expect sensors or ksensors to work (yet).

Thanks to Jonathan Felder for the initial testing of this driver, please
give it a thorough trashing and let me know of any problems.

Regards,

Hans



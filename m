From: Dag B <dag@bakke.com>
Date: Wed, 25 May 2022 16:36:23 +0000
Subject: dht11 vs iio-hwmon
Message-Id: <e437eea6-9027-fa9e-22ba-5710672530b6@bakke.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi.

I have managed to make use of the dht11 driver and can get data from my 
sensor quite reliably.

I want to be able to read this sensor via lm-sensors, and was hoping to 
employ the iio-hwmon bridge for this purpose. Sadly, I do not get any 
nodes in the /sys/class/hwmon/ directory for the dht11 sensor.

Do iio-drivers (like dht11) have to be written with this bridge in mind, 
in order to get the hwmon entries? Or am I just missing a touch of magic 
somewhere? I see that the dht11 device-tree overlay doesn't have any 
reference to iio-hwmon, like some other drivers do.


root@rpi2:/boot# lsmod | egrep 'iio|hw|dht'
dht11                  16384  0
iio_hwmon              16384  0
raspberrypi_hwmon      16384  0
industrialio           81920  2 iio_hwmon,dht11

root@rpi2:/boot# cat /sys/bus/iio/devices/iio\:device0/in_temp_input
19400

root@rpi2:/boot# ls -l /sys/class/hwmon/
total 0
lrwxrwxrwx 1 root root 0 May 25 08:59 hwmon0 -> ../../devices/virtual/thermal/thermal_zone0/hwmon0
lrwxrwxrwx 1 root root 0 May 25 08:59 hwmon1 -> ../../devices/platform/soc/soc:firmware/raspberrypi-hwmon/hwmon/hwmon1


Thanks,


Dag B.

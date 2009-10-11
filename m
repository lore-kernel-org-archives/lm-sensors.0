From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Sun, 11 Oct 2009 22:32:02 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <4AD25CE2.2080207@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> Looks good so far. What are the underlying device types for your
>> devices (what does their "subsystem" link point to)? libsensors names
>> devices uniquely, partly based on the device type. If it doesn't know
>> the type, it ignores the device. In particular we don't have support
>> for USB yet... that could be the problem.
>>
>> It might be difficult to come up with a device numbering convention for
>> USB devices that will fit in what libsensors expectes, given to the
>> unlimited nature of USB daisy-chaining. But hopefully we can come up
>> with something good enough for the most common cases.

Although the underlying device is USB, the device appears in the relatively
new "hid" class, as it is a standard USB HID device (I imagine so it doesn't
require kernel drivers to be installed under Windows.)

> Oh, please also send the output of: 
> $ ls -l /sys/class/hwmon/hwmon*/device

lrwxrwxrwx 1 root root 0 2009-10-11 22:55 /sys/class/hwmon/hwmon0/device ->
../../../devices/platform/it87.656
lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon1/device ->
../../../devices/platform/coretemp.0
lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon2/device ->
../../../devices/platform/coretemp.1
lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon3/device ->
../../../devices/platform/coretemp.2
lrwxrwxrwx 1 root root 0 2009-10-11 21:28 /sys/class/hwmon/hwmon4/device ->
../../../devices/platform/coretemp.3
lrwxrwxrwx 1 root root 0 2009-10-11 23:40 /sys/class/hwmon/hwmon5/device ->
../../../devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.0/0003:1044:4001.0012

> and
> $ ls -l /sys/class/hwmon/hwmon[45]/device/

/sys/class/hwmon/hwmon4/device/:
total 0
drwxr-xr-x  3 root root    0 2009-09-30 13:00 .
drwxr-xr-x 15 root root    0 2009-10-08 10:22 ..
lrwxrwxrwx  1 root root    0 2009-10-11 22:55 bus -> ../../../bus/platform
lrwxrwxrwx  1 root root    0 2009-10-11 22:55 driver ->
../../../bus/platform/drivers/coretemp
lrwxrwxrwx  1 root root    0 2009-10-11 23:26 hwmon:hwmon4 ->
../../../class/hwmon/hwmon4
-r--r--r--  1 root root 4.0K 2009-10-11 23:26 modalias
-r--r--r--  1 root root 4.0K 2009-10-11 22:55 name
drwxr-xr-x  2 root root    0 2009-10-11 23:26 power
lrwxrwxrwx  1 root root    0 2009-10-11 22:55 subsystem -> ../../../bus/platform
-r--r--r--  1 root root 4.0K 2009-10-11 22:55 temp1_crit
-r--r--r--  1 root root 4.0K 2009-10-11 22:55 temp1_crit_alarm
-r--r--r--  1 root root 4.0K 2009-09-30 13:00 temp1_input
-r--r--r--  1 root root 4.0K 2009-10-11 22:55 temp1_label
-r--r--r--  1 root root 4.0K 2009-10-11 23:04 temp1_max
-rw-r--r--  1 root root 4.0K 2009-10-11 23:26 uevent

/sys/class/hwmon/hwmon5/device/:
total 0
drwxr-xr-x 3 root root    0 2009-10-11 23:40 .
drwxr-xr-x 4 root root    0 2009-10-11 23:40 ..
lrwxrwxrwx 1 root root    0 2009-10-11 22:55 bus -> ../../../../../../../bus/hid
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr0_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr0_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr1_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr1_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr2_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr2_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr3_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr3_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr4_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr4_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr5_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr5_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr6_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr6_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr7_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 curr7_label
lrwxrwxrwx 1 root root    0 2009-10-12 08:00 driver ->
../../../../../../../bus/hid/drivers/gbt-odin
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 fan1_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 fan1_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 fan2_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 fan2_label
lrwxrwxrwx 1 root root    0 2009-10-12 08:00 hidraw:hidraw4 ->
../../../../../../../class/hidraw/hidraw4
lrwxrwxrwx 1 root root    0 2009-10-12 08:00 hwmon:hwmon5 ->
../../../../../../../class/hwmon/hwmon5
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in0_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in0_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in1_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in1_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in2_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in2_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in3_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in3_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in4_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in4_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in5_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in5_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in6_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in6_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in7_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 in7_label
lrwxrwxrwx 1 root root    0 2009-10-12 08:00 leds:gbt-odin:blue:fan ->
../../../../../../../class/leds/gbt-odin:blue:fan
-r--r--r-- 1 root root 4.0K 2009-10-11 23:40 name
drwxr-xr-x 2 root root    0 2009-10-11 22:56 power
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power0_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power0_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power1_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power1_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power3_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power3_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power4_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power4_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power5_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power5_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power6_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power6_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power8_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 power8_label
lrwxrwxrwx 1 root root    0 2009-10-11 22:55 subsystem ->
../../../../../../../bus/hid
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp1_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp1_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp2_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp2_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp3_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp3_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp4_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp4_label
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp5_input
-r--r--r-- 1 root root 4.0K 2009-10-12 08:00 temp5_label
-rw-r--r-- 1 root root 4.0K 2009-10-11 22:55 uevent

> And I am curious about your USB device and what sensors it has. If
> these are I2C sensor chips and there's an I2C bus inside the device, it
> may make more sense to write a bus drivers for that I2C segment, and
> use regular I2C sensor chip drivers on top of it. But of course it
> depends whether you have all the needed technical information to do
> this or not (if the hardware design allows it at all.)

I am unsure what type of chips are inside the device, but whatever they are
the HID protocol abstracts it away so you never get direct access.
Essentially you send a number to the device and it responds with a few bytes,
to which you apply a formula and obtain the sensor reading.

If it would help I can post a gadgetfs userspace program I wrote to emulate
the device.  When you run this - assuming you have gadgetfs support in your
kernel set up with the "dummy" device - you will see a new USB device appear
on your system which behaves the same as the real device.  You can then load
my driver and it will talk to the "fake" device.  (Just as a bit of background
this proved extremely useful for reverse engineering the device - I was able
to tell my fake device what data to respond with, and using VirtualBox, see
which sensors changed in the manufacturer's Windows program as the fake device
responded with different values.)

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

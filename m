From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 06 Jun 2007 15:43:25 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <014d01c7a851$6d205000$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

No idea what I did, but it works now?
I'll try to debug what actually happened. Must be something with the order 
the modules are loaded.

I will report back when I find more information

--
[root@localhost log]# cat kern
Jun  6 15:17:28 localhost kernel: klogd 1.4.1, log source = /proc/kmsg 
started.
Jun  6 15:17:44 localhost kernel: device class 'hwmon': registering
Jun  6 15:17:44 localhost kernel: bus pci: add driver sis5595
Jun  6 15:17:44 localhost kernel: pci: Matched Device 0000:00:01.0 with 
Driver s 
is5595
Jun  6 15:17:44 localhost kernel: pci: Probing driver sis5595 with device 
0000:0 
0:01.0
Jun  6 15:17:44 localhost kernel: bus platform: add driver sis5595
Jun  6 15:17:44 localhost kernel: Registering platform device 'sis5595.656'. 
Par 
ent at platform
Jun  6 15:17:44 localhost kernel: DEV: registering device: ID = 
'sis5595.656'
Jun  6 15:17:44 localhost kernel: PM: Adding info for platform:sis5595.656
Jun  6 15:17:44 localhost kernel: bus platform: add device sis5595.656
Jun  6 15:17:44 localhost kernel: platform: Matched Device sis5595.656 with 
Driv 
er sis5595
Jun  6 15:17:44 localhost kernel: platform: Probing driver sis5595 with 
device s 
is5595.656
Jun  6 15:17:44 localhost kernel: CLASS: registering class device: ID = 
'hwmon0'
Jun  6 15:17:44 localhost kernel: class_uevent - name = hwmon0
Jun  6 15:17:44 localhost kernel: class_device_create_uevent called for 
hwmon0
Jun  6 15:17:44 localhost kernel: bound device 'sis5595.656' to driver 
'sis5595'
Jun  6 15:17:44 localhost kernel: platform: Bound Device sis5595.656 to 
Driver s 
is5595
[root@localhost log]# sensors
sis5595-isa-0290
Adapter: ISA adapter
VCore 1:   +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
VCore 2:   +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+3.3V:     +2.74 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+5V:       +3.44 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+12V:     +13.80 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
alarms:   Board temperature input (usually LM75 chips) ALARM

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Ivo Manca" <pinkel@gmail.com>
Cc: "LM Sensors" <lm-sensors@lm-sensors.org>
Sent: Wednesday 6 June 2007 14:51
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform 
driver


> Ivo,
>
> Please don't forget the mailing list!
>
> On Wed, 6 Jun 2007 13:21:23 +0200, Ivo Manca wrote:
>> [root@localhost ~]# sensors -v
>> sensors version 2.10.1 with libsensors version 2.10.1
>>
>> I'll update it if you want.
>
> No, that should be OK.
>
>> > If you already have lm-sensors version >= 2.10.1, please compile with
>> > CONFIG_HWMON_DEBUG_CHIP=y and look into your logs when loading the
>> > driver. Also check what you see under /sys/class/hwmon
>> > and /sys/bus/platform.
>>
>> I already enabled hwmon_debug_chip, however, nothing seems to get logged. 
>> It
>> should go somewhere to /var/log, shouldn't it? Only log file changing is 
>> my
>> messages, but that's just moaning about  nmbd ;)
>
> If should show in the output of "dmesg" to start with, and indeed also
> in /var/log/messages and/or /var/log/debug.
>
>> [ivo@localhost log]$ ls -l /sys/class/hwmon/
>> total 0
>>
>> [ivo@localhost log]$ ls -lR /sys/bus/platform/
>> /sys/bus/platform/:
>> total 0
>> drwxr-xr-x 2 root root    0 Jun  6 10:05 devices
>> drwxr-xr-x 4 root root    0 Jun  6 10:05 drivers
>> -rw-r--r-- 1 root root 4096 Jun  6 10:56 drivers_autoprobe
>> --w------- 1 root root 4096 Jun  6 10:56 drivers_probe
>>
>> /sys/bus/platform/devices:
>> total 0
>> lrwxrwxrwx 1 root root 0 Jun  6 10:05 floppy.0 ->
>> ../../../devices/platform/floppy.0
>> lrwxrwxrwx 1 root root 0 Jun  6 10:05 i8042 ->
>> ../../../devices/platform/i8042
>> lrwxrwxrwx 1 root root 0 Jun  6 10:05 microcode ->
>> ../../../devices/platform/microcode
>> lrwxrwxrwx 1 root root 0 Jun  6 10:05 pcspkr ->
>> ../../../devices/platform/pcspkr
>> lrwxrwxrwx 1 root root 0 Jun  6 10:05 serial8250 ->
>> ../../../devices/platform/serial8250
>> lrwxrwxrwx 1 root root 0 Jun  6 10:05 serial8250.0 ->
>> ../../../devices/platform/serial8250.0
>>
>> /sys/bus/platform/drivers:
>> total 0
>> drwxr-xr-x 2 root root 0 Jun  6 10:05 i8042
>> drwxr-xr-x 2 root root 0 Jun  6 10:05 serial8250
>>
>> /sys/bus/platform/drivers/i8042:
>> total 0
>> --w------- 1 root root 4096 Jun  6 10:57 bind
>> lrwxrwxrwx 1 root root    0 Jun  6 10:57 i8042 ->
>> ../../../../devices/platform/i8042
>> --w------- 1 root root 4096 Jun  6 10:57 unbind
>>
>> /sys/bus/platform/drivers/serial8250:
>> total 0
>> --w------- 1 root root 4096 Jun  6 10:57 bind
>> lrwxrwxrwx 1 root root    0 Jun  6 10:57 serial8250 ->
>> ../../../../devices/platform/serial8250
>> lrwxrwxrwx 1 root root    0 Jun  6 10:57 serial8250.0 ->
>> ../../../../devices/platform/serial8250.0
>> --w------- 1 root root 4096 Jun  6 10:57 unbind
>
> Odd. No sign of sis5595 anywhere.
>
>> [ivo@localhost log]$ lsmod
>> Module                  Size  Used by
>> sis5595                14348  0
>> i2c_sis5595            10244  0
>> i2c_dev                 9860  0
>> hwmon                   6404  1 sis5595
>> ne2k_pci               12128  0
>> 8390                   11520  1 ne2k_pci
>>
>> /sys/class/hwmon shouldn't be empty, should it?
>
> It shouldn't, but OTOH given that the sis5595 platform driver seemingly
> wasn't registered properly, I am not surprised.
>
> My previous patch had some error paths which didn't display any error
> nor debug message. I guess that one of these error conditions occurred
> and this is why you don't see anything in the logs. So I attached a new
> version of the patch with messages on all the error paths. Please
> revert the previous patch and apply this one instead, leaving debugging
> enabled of course. Hopefully you'll have something in the log this
> time, and from there we'll see what needs to be fixed.
>
> Thanks,
> -- 
> Jean Delvare
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

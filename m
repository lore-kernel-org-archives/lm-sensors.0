From: "Ivo Manca" <pinkel@gmail.com>
Date: Sun, 01 Jul 2007 21:05:55 +0000
Subject: Re: [lm-sensors] Help wanted: individual alarm files
Message-Id: <006001c7bc23$a0c96960$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701220005.1dda9d8f@hyperion.delvare>
In-Reply-To: <20070701220005.1dda9d8f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean, Hans,

I will give it a shot. Since I am _completely_ new to this, it might take a 
while.

Ivo


----- Original Message ----- 
From: "Hans de Goede" <j.w.r.degoede@hhs.nl>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: "LM Sensors" <lm-sensors@lm-sensors.org>
Sent: Sunday 1 July 2007 23:13
Subject: Re: [lm-sensors] Help wanted: individual alarm files


> Hi All,
>
> I'll take care of converting the "fscher" driver as my work PC has such a
> beast. I hope to be able todo this soon.
>
> Ivo, if you are reading this, any chance you could try to convert the 
> sis5595
> driver?
>
> Regards,
>
> Hans
>
>
> Jean Delvare wrote:
>> Hi all,
>>
>> The future libsensors assumes that all hardware monitoring drivers
>> follow the standard sysfs interface defined in
>> Documentation/hwmon/sysfs-interface. They all mostly do already, except
>> for one thing: alarms. Most drivers are still only exposing a single
>> file with all alarms in a bit-vector, in chip-dependent order. In order
>> to let the new libsenors display the alarms properly, we must add
>> individual alarm files to these drivers. For some drivers, fault and/or
>> beep files need to be added too.
>>
>> Here's the current status, to the best of my knowledge.
>>
>> Already have individual alarm files:
>> abituguru.c
>> coretemp.c
>> ds1621.c
>> dme1737.c
>> f71805f.c
>> lm63.c
>> lm83.c
>> lm85.c
>> lm90.c
>> pc87427.c
>> smsc47m192.c
>> vt1211.c
>> w83627ehf.c
>> w83793.c
>>
>> Don't have alarms at all:
>> ad7418.c
>> adm1029.c
>> ams
>> applesmc.c
>> atxp1.c
>> hdaps.c
>> k8temp.c
>> lm70.c
>> lm75.c
>> max6650.c
>> smsc47b397.c
>> w83l785ts.c
>>
>> Need to be converted:
>> adm1021.c
>> adm1025.c
>> adm1026.c
>> adm1031.c
>> adm9240.c
>> asb100.c
>> fscher.c
>> fscpos.c
>> gl518sm.c
>> gl520sm.c
>> it87.c
>> lm77.c
>> lm78.c
>> lm80.c
>> lm87.c
>> lm92.c
>> max1619.c
>> pc87360.c
>> sis5595.c
>> smsc47m1.c
>> via686a.c
>> vt8231.c
>> w83627hf.c
>> w83781d.c
>> w83791d.c
>> w83792d.c
>>
>> As you can see, the list is quite long, so I need help. That's not a
>> difficult job, but you need chip ship in question to test.
>>
>> How to add individual alarm files:
>>
>> * Read Documentation/hwmon/sysfs-interface, so that you know what are
>> the valid names for individual alarm, fault and beep files.
>>
>> * Take a look at this patch which adds individual alarm support to 4
>> drivers:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h-45771e6ea79f56a7d85e448f702f60ef86c228#patch2
>>
>> * Do the same to your driver. To find out which alarm bit correspond to
>> what, you can look at the defines used in the current version of
>> libsensors:
>> http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/kernel/include/sensors.h?revD73
>> Or you can look at the datasheet for your chip, but it's likely to take
>> longer.
>>
>> * Test. You can test manually (change the limits and read the alarm
>> files from sysfs) or you can use the next version of libsensors, which
>> is in branch "lm-sensors-3.0.0" under SVN:
>> svn checkout http://lm-sensors.org/svn/lm-sensors/branch/lm-sensors-3.0.0 
>> lm-sensors-3
>>
>> * Submit your patch to the lm-sensors list, I'll review it.
>>
>> Thanks,
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

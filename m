From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 23 Feb 2007 08:10:59 +0000
Subject: [lm-sensors] #2159: lm-sensors doesn't work on Abit AB9 Pro
Message-Id: <45DEA193.6050100@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm-sensors wrote:
> #2159: lm-sensors doesn't work on Abit AB9 Pro
> -----------------------+----------------------------------------------------
>   Reporter:  ticket    |       Owner:  ruik    
>       Type:  defect    |      Status:  assigned
>   Priority:  major     |   Milestone:          
>  Component:  hardware  |     Version:  2.10.0  
> Resolution:            |    Keywords:          
> -----------------------+----------------------------------------------------
> Comment (by ticket):
> 
>  I've installed the 2.6.20.1 kernel, temps still aren't working but
>  voltages are. I did an modprobe of the abituguru module, it didn't seem to
>  help. I'm using sensors 2.10.1.
> 
>  Adapter: ISA adapter
>  VCore:     +2.04 V  (min =  +2.04 V, max =  +2.04 V) ALARM
>  in1:      +13.46 V  (min = +13.46 V, max = +13.46 V) ALARM
>  AVCC:      +4.08 V  (min =  +4.08 V, max =  +4.08 V) ALARM
>  3VCC:      +4.08 V  (min =  +4.08 V, max =  +4.08 V) ALARM
>  in4:       +2.04 V  (min =  +2.04 V, max =  +2.04 V) ALARM
>  in5:       +2.04 V  (min =  +2.04 V, max =  +2.04 V) ALARM
>  in6:       +6.53 V  (min =  +6.53 V, max =  +6.53 V) ALARM
>  VSB:       +4.08 V  (min =  +4.08 V, max =  +4.08 V) ALARM
>  VBAT:      +4.08 V  (min =  +4.08 V, max =  +4.08 V) ALARM
>  in9:       +2.04 V  (min =  +2.04 V, max =  +2.04 V) ALARM
>  Case Fan:    0 RPM  (min =    0 RPM, div = 128) ALARM
>  CPU Fan:     0 RPM  (min =    0 RPM, div = 128) ALARM
>  Aux Fan:     0 RPM  (min =    0 RPM, div = 128) ALARM
>  fan4:        0 RPM  (min =    0 RPM, div = 128) ALARM
>  Sys Temp:     -1?C  (high =    -1?C, hyst =    -1?C)   ALARM
>  CPU Temp:   +0.0?C  (high =  +0.0?C, hyst =  +0.0?C)   ALARM
>  AUX Temp:   +0.0?C  (high =  +0.0?C, hyst =  +0.0?C)   ALARM
> 


Commenting through mail and not through trac as I don't seem to have the 
necessary edit rights.

Yes the AB9 pro probably has an uguru and most likely the 3th revision of the 
uguru, which doesn't work with the abituguru driver currently in the kernel 
I've written a driver for the 3th revision called abituguru3, which I've posted 
for review to the lm-sensors list quite some time ago.

Also notice that although the motherboard contains a super-io chip with 
sensors, this chip is not used by Abit for sensors and the sensors thus cannot 
be used. As can be seen from the worthless voltage readings (notice reading = 
min = max) , and the non working fan and temp readings.

The easiest way to get sensors readings on this board is by using the openguru 
userspace utility I wrote for this (must be run as root):
http://people.atrpms.net/~hdegoede/openguru2.3.1.tar.gz

Compile it like this:
gcc -O2 -Wall -o oguru main2.c openGuru.c

And then as root run: ./oguru

Let me know if and how it works for you any feedback is much appreciated.

You can also try the kernel driver I wrote:
http://people.atrpms.net/~hdegoede/abituguru2-0.1.2.tar.gz

Untar, cd into the dir and run "make", this assumes you have the kernel-devel 
or equivalent package for your distro installed.

Once its made, do:
modprobe hwmon
insmod abituguru2.ko

And then you should have lots of files under 
/sys/bus/platform/devices/abituguru2.224

When you cat in0_input in this dir you should get a voltage in millivolt, if 
you want to know which voltage cat in0_label, etc, etc.

Notice that this version is still called abituguru2, in the kernel patch I've 
send to the list for review I've changed this to abituguru3 as this driver is 
for revision 3 of the uguru.

Regards,

Hans






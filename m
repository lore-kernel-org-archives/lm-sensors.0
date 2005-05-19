From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: rpm of 0 with smsc47m1 does not cause alarm
Message-Id: <41E57B43.7060006@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41879A3F.3050304@earthlink.net>
In-Reply-To: <41879A3F.3050304@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi David,
> 
> 
>># isadump -f 0x0680 0x80
>>
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>00: 01 00 01 00 18 ff e7 18 00 00 18 00 00 00 00 00
>>10: 02 06 67 18 c0 00 00 00 00 00 00 00 00 00 03 03
>>20: 81 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
>>30: 00 00 00 05 05 04 04 01 00 04 84 84 00 01 01 05
>>40: 05 05 04 05 04 05 04 01 01 00 00 00 84 13 04 57
>>50: 00 00 00 00 00 00 14 14 f0 ff ff 68 68 00 00 00
>>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> Bits 6 and 7 of register 0x04 are actually cleared, so this is no driver
> bug. The chipset doesn't set the flags. After reading the datasheet
> again, I don't thing there is a way to disable them, so they have to be
> enabled (but not set at the moment). Could be that the chipset does only
> raise an alarm on slow fan, not on stopped/absent fan. Doesn't make much
> sense of course, but that may still be true.

OK.  I finally got a bit of time to look at this again.  Here's what 
I've seen, even if it doesn't make any sense.

I'm running a Red Hat 9 box with version 2.9.0 of i2c and lm_sensors 
now.  This box also has two lm87s in it.   The fan speeds of 6 fans are 
controlled by the smsc superio.  Each superio pwm output controls 3 
fans.  One of those fans is monitored by the superio and the remaining 
two are each monitored by a different lm87.

After upgrading to the latest version of lm_sensors and i2c, I verified 
the fan speeds and fan control.   It worked as expected.

I then shut off the server and unplugged one bank of fans (don't worry, 
they are set up in a redundant configuration).  When I booted up, the 
unplugged fans showed alarms on the lm87s but not on the smsc superio.

I then raised the alarm threshold for the smsc monitored fans in the 
/etc/sensors.conf to a value greater than the fans were currently 
running.  I then ran sensors -s.   Sensors showed errors for BOTH fans 
on the superIO the first time it was run, then the error on the 
disconnected fan cleared.   I then tried running sensors -s by itself. 
  Each time I ran sensors -s followed by sensors, the disconnected fan 
on the superIO had an alarm, but it cleared the second time sensors was run.



> 
> I'd suggest that you give a try with a working fan and make sure you get
> a valid speed reported. Then change the low limit above the fan speed,
> and see if the alarm triggers. If it does, but disappears if you then
> unplug the fan, then I guess it validates my theory.

The fans get a valid speed report.  As explained above, I can see the 
alarms triggered when the fan speeds drop below the alarm threshold.

However...  I've found something new when trying the "unplug the fan 
test".   When I unplugged the fan, sensors indicates that the fan speed 
has not changed.  Here's the output of sensors:

# sensors
lm87-i2c-1-2d
Adapter: SMBus I801 adapter at 0540
mon0,+V2_5:
            +2.49 V  (min =  +2.37 V, max =  +2.62 V)
+vcc_cpu:  +1.46 V  (min =  +1.35 V, max =  +1.55 V)
mon0,+V3_3:
            +3.30 V  (min =  +3.16 V, max =  +3.44 V)
mon0,+V5_0:
            +4.97 V  (min =  +4.74 V, max =  +5.26 V)
mon0,+V12:+12.13 V  (min = +11.38 V, max = +12.63 V)
battv_mon: +3.14 V  (min =  +2.70 V, max =  +3.30 V)
mon0,Fan1:   0 RPM  (min = 1394 RPM, div = 8)          ALARM
mon0,Fan2:1493 RPM  (min = 1394 RPM, div = 8)
mon0,AmbT:   +28?C  (low  =    +0?C, high =   +60?C)

lm87-i2c-1-2e
Adapter: SMBus I801 adapter at 0540
mon1,+V2_5:
            +2.50 V  (min =  +2.37 V, max =  +2.62 V)
mon1,+V1_8:
            +1.79 V  (min =  +1.72 V, max =  +1.88 V)
mon1,+V3_3:
            +3.30 V  (min =  +3.16 V, max =  +3.44 V)
mon1,+V5_0:
            +4.97 V  (min =  +4.74 V, max =  +5.26 V)
mon1,+V12:+12.13 V  (min = +11.38 V, max = +12.63 V)
mon1,+V1_2:
            +1.20 V  (min =  +1.13 V, max =  +1.27 V)
mon1,Fan1:   0 RPM  (min = 1394 RPM, div = 8)          ALARM
mon1,Fan2:1493 RPM  (min = 1394 RPM, div = 8)
mon1,AmbT:   +28?C  (low  =    +0?C, high =   +60?C)

smsc47m1-isa-0680
Adapter: ISA adapter
superio,Fan1:
           1517 RPM  (min = 1396 RPM, div = 8)
superio,Fan2:
           1498 RPM  (min = 1396 RPM, div = 8)

The superio,Fan1 input should read 0.

Here's the dump from the superio chip while it's in this state:
# isadump -f 0x0680 0x80
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x680 to 0x6ff.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 00 01 00 18 ff e7 1f 00 00 d8 00 00 00 00 00
10: 02 02 67 1f c0 00 00 00 00 00 00 00 00 00 03 03
20: 81 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
30: 00 00 00 05 05 04 04 01 00 04 84 84 00 01 01 05
40: 05 05 04 05 04 05 04 01 01 00 00 00 84 12 04 57
50: 00 00 00 00 00 00 14 14 f0 b9 ba 68 68 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



> 
> We may consider faking the alarm bits it this specific case, since it's
> odd that the chipset doesn't do it, and is contrary to what other chips
> such as the LM87 do, if I'm not mistaken.
> 

As I mentioned, this box has LM87s in it and the smsc superio does not 
behave the same.

Any thoughts are welcome.

David



From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: rpm of 0 with smsc47m1 does not cause alarm
Message-Id: <41FBE63B.4030600@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41879A3F.3050304@earthlink.net>
In-Reply-To: <41879A3F.3050304@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've read the PME section of the 47M102 datasheet about 5 times and I still
don't know how the stupid bits work.
Obviously if  they are edge triggered then the driver shouldn't be clearing them.
I can't remember why I put the clear code in there (I assume I did it)
but it makes sense that the chip wasn't clearing it.

If the bit is truly edge-triggered then the driver can
also make a comparison and assert ALARM if either the bit is on or the
speed comparison fails.

Jean Delvare wrote:
> Hi David,
> 
> 
>>OK.  I finally got a bit of time to look at this again.  Here's what 
>>I've seen, even if it doesn't make any sense.
>>
>>I'm running a Red Hat 9 box with version 2.9.0 of i2c and lm_sensors 
>>now.  This box also has two lm87s in it.   The fan speeds of 6 fans
>>are  controlled by the smsc superio.  Each superio pwm output controls
>>3  fans.  One of those fans is monitored by the superio and the
>>remaining  two are each monitored by a different lm87.
>>
>>After upgrading to the latest version of lm_sensors and i2c, I
>>verified  the fan speeds and fan control.   It worked as expected.
>>
>>I then shut off the server and unplugged one bank of fans (don't
>>worry,  they are set up in a redundant configuration).  When I booted
>>up, the  unplugged fans showed alarms on the lm87s but not on the smsc
>>superio.
>>
>>I then raised the alarm threshold for the smsc monitored fans in the 
>>/etc/sensors.conf to a value greater than the fans were currently 
>>running.  I then ran sensors -s.   Sensors showed errors for BOTH
>>fans on the superIO the first time it was run, then the error on the
>>disconnected fan cleared.   I then tried running sensors -s by itself.
>>
>>Each time I ran sensors -s followed by sensors, the disconnected fan
>>on the superIO had an alarm, but it cleared the second time sensors
>>was run.
> 
> 
> Sounds like 1* missing fans don't reassert alarms and 2* writing to the
> limits register does fore the alarm to reassert if needed.
> 
> The smsc47m1 driver clears alarms after it reads them. Typically the
> other drivers don't do it because other chips do clear them
> automatically. What you describe suggests that it should probably not be
> done (or not always). I guess that this code was put there for a reason
> though. You could try commenting it out (in smsc47m1_update_client):
> 
> if(data->alarms)
> 	smsc47m1_write_value(client, SMSC47M1_REG_ALARM1, 0xc0);
> 
> But if you do, I suspect that at some point alarms will stay even once
> the alarm condition has gone.
> 
> Also note that we attempt to clear both alarm bits regardless of which
> is set. Could it be the cause of the trouble you observe (both alarms
> raised when only one fan is missing)? It would be really weird.
> 
> I tend to think that your chip has a hardware issue, either because it
> is broken or because it wasn't properly wired.
> 
> 
>>However...  I've found something new when trying the "unplug the fan 
>>test".   When I unplugged the fan, sensors indicates that the fan
>>speed  has not changed.  Here's the output of sensors:
>>(...)
>>smsc47m1-isa-0680
>>Adapter: ISA adapter
>>superio,Fan1:
>>           1517 RPM  (min = 1396 RPM, div = 8)
>>superio,Fan2:
>>           1498 RPM  (min = 1396 RPM, div = 8)
>>
>>The superio,Fan1 input should read 0.
>>
>>Here's the dump from the superio chip while it's in this state:
>># isadump -f 0x0680 0x80
>>WARNING! Running this program can cause system crashes, data loss and
>>worse! I will probe address range 0x680 to 0x6ff.
>>Continue? [Y/n] y
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>00: 01 00 01 00 18 ff e7 1f 00 00 d8 00 00 00 00 00
>>10: 02 02 67 1f c0 00 00 00 00 00 00 00 00 00 03 03
>>20: 81 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
>>30: 00 00 00 05 05 04 04 01 00 04 84 84 00 01 01 05
>>40: 05 05 04 05 04 05 04 01 01 00 00 00 84 12 04 57
>>50: 00 00 00 00 00 00 14 14 f0 b9 ba 68 68 00 00 00
>>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> The dump confirms the non-zero speed report (at 0x59 and 0x5a) and no
> alarm raised, so this is definitely a hardware issue. Not the first time
> I hear about this, although I don't remember if it was for the same chip
> or a different one. At any rate there nothing we can do as far as I can
> see. Unless you have an idea?
> 

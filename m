From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Dec 2009 15:37:06 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20091205163706.2eb54fe7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Wed, 2 Dec 2009 14:55:37 -0500 (EST), Sean Fidler wrote:
> Sensors output:
> 
> smsc47m192-i2c-0-2d
> Adapter: SMBus I801 adapter at 1880
> +2.5V:       +0.00 V  (min =  +2.90 V, max =  +2.90 V)   ALARM
> VCore:       +0.00 V  (min =  +2.99 V, max =  +2.99 V)   ALARM
> +3.3V:       +0.00 V  (min =  +4.38 V, max =  +4.35 V)   ALARM
> +5V:         +0.00 V  (min =  +6.64 V, max =  +6.64 V)   ALARM
> +12V:        +3.12 V  (min = +15.81 V, max = +15.88 V)   ALARM
> VCC:         +3.35 V  (min =  +4.38 V, max =  +3.83 V)   ALARM
> +1.5V:       +0.05 V  (min =  +1.49 V, max =  +1.99 V)   ALARM
> +1.8V:       +0.00 V  (min =  +2.39 V, max =  +2.39 V)   ALARM
> Chip Temp:   +34.0°C  (low  = -17.0°C, high =  -1.0°C)  ALARM 
> CPU Temp:    +28.0°C  (low  =  -1.0°C, high = -33.0°C)  ALARM 
> Sys Temp:      FAULT  (low  = -65.0°C, high =  -1.0°C)  ALARM 
> cpu0_vid:   +1.475 V

Not many inputs wired, and the min voltage and high temperature limits
are pretty wrong, but other than that it's not too bad, except for
+12V. Do the temperature values appear to match anything you've seen in
the BIOS?

> smsc47m1-isa-0600
> Adapter: ISA adapter
> fan1:       2925 RPM  (min = 2560 RPM, div = 2)  ALARM
> fan2:          0 RPM  (min = 3072 RPM, div = 4)  ALARM

Looks reasonable. Only one fan on this system? If there are more, you
can try increasing fan2_div to 8 if the other fan is a slow one. I
guess that the first ALARM wears off when running "sensors" again? 2925
is above the min limit so there should be no ALARM.

From the above output, the following configuration section would seem
appropriate for your system:

chip "smsc47m192-i2c-*-2d"

   ignore in0
   ignore in1
   ignore in2
   ignore in3
   label  in5 "+3.3V"
   ignore in6
   ignore in7

   set in4_min   0
   set in5_min 3.3 * 0.95
   set in5_max 3.3 * 1.05

   ignore temp3

   set temp1_min  5
   set temp1_max 50
   set temp2_min  5
   set temp2_max 50

Needs to be confirmed:
* What is wired on in4.
* Temperature input labels.
* Whether cpu0_vid is real. What CPU is there on this machine?
* Which fan is connected to fan1.
* Is there anything connected to fan2.

If you can answer the questions above then we can put a good
configuration file for your machine on the wiki.

> I wouldn't mind test kernel patches. I'll have to figure out how to
> implement them, but I think I'll be able to manage *fingers crossed*. Whatever I can do to
> help.

I've put a modified smsc47m1 driver here:
http://khali.linux-fr.org/devel/misc/smsc47m1/

I would like you to download it and test it. With that driver, you
should no longer have to do the isaset magic at boot time. It include
other changes which should hopefully be transparent to you if I didn't
mess up.

This is a standalone driver, you'll need a proper build environment
(install make, gcc and the kernel headers) then type "make" then load
the driver (with insmod.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

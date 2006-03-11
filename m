From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 11 Mar 2006 10:16:45 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring
Message-Id: <20060311111645.6a3ce5db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603042101570.3972@Laila>
In-Reply-To: <Pine.LNX.4.63.0603042101570.3972@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Raphael,

> I tested the new smsc47m192 driver on my msi rs480m2 system using
> 2.6.16-rc5 and here are my results.

Thanks for reporting!

> To get it working I applied the kernel patch from
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015476.html
> 
> and the ATI SMBus patch from
> 
> http://assembler.cz/download/ati2_patch

I don't have it in my tree, BTW. Can someone please provide a patch
suitable (i.e. including Kconfig and documentation updates) for
inclusion into mainline? Rudolf?

> I also applied the user space patch from
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015477.html

I just replied to it with my comments. It's overall good.

> After this I ran sensors-detect (which still claims not to know what to
> do) and then sensors.

We'll have to update the sensors-detect script, no big deal, I've asked
Hartmut to do it.

> I get
> 
> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:     1861 RPM  (min =  640 RPM, div = 8)         
> fan2:     1107 RPM  (min =  640 RPM, div = 8)         
> 
> smsc47m192-i2c-0-2d
> Adapter: SMBus PIIX4 adapter at 0400
> 
> in0:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
> in1:       +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
> in2:       +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
> in3:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
> in5:       +3.33 V  (min =  +0.00 V, max =  +4.38 V)  
> in6:       +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
> in7:       +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
> temp1:     +35.0 C  (low  =  -128 C, high =  +127 C) 
> temp2:     +55.0 C  (low  =  -128 C, high =   +60 C) 
> temp3:    +116.0 C  (low  =  -128 C, high =  +127 C) 
> vid:      +1.550 V  (VRM Version 2.4)
> 
> 
> which is fantastic!

I see that you don't have the new configuration file installed (labels
should be different). So you may want to copy
lm_sensors2/etc/sensors.conf.eg to /etc/sensors.conf before you go on
hacking your configuration file.

> temp2 is my CPU temp I am 99% sure.  The low and high figures appear to
> be meaningless and change depending on what the cpu is doing.  For example
> 
> temp2:     +57.0 C  (low  =   +55 C, high =   +65 C)
> 
> under light load.

This is really strange. Please load the i2c-dev module, then try
"i2cdump 0 0x2d b" from times to times and see if registers 0x37 and
0x38 change that way too. I guess they will.

Maybe something (BIOS?) is accessing the chip too, but if so I'd expect
other problems to show sooner or later. And I don't get the point
of changing these limits on the fly anyway.

Hartmut, I guess you never observed anything like this on your own
system?

Raphael, do you have any option in your BIOS which could be related to
that "feature"?

> The rest of the measurements are a mystery to me and the 6 ALARMS seem
> slightly... alarming :)

I guess that the chip does loose comparisons for alarms. The voltage
inputs seem to be unused and wired to the ground on your board, so they
report 0, with low limit 0 you end up with 0 <= 0, which is true so the
alarm triggers. Not very smart from SMSC if I'm right.

Anyway you don't really care about these inputs as they are not used.
You could add the following lines to your configuration file (under the
smsc47m192 section):

   ignore in0
   ignore in1
   ignore in2
   ignore in3
   ignore in6
   ignore in7

So you no more see them. You can do the same for temp3 and/or vid if
you don't think they are relevant.

You could also add the following lines:

   set in5_min 3.3 * 0.95
   set in5_max 3.3 * 1.05

So that at least the chip's own voltage is monitored properly. These
settings will take effect after you run "sensors -s" as root.

-- 
Jean Delvare


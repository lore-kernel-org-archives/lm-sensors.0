From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: GL520SM Problem
Message-Id: <20040508221029.64d5caf5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1084022241.6755.316.camel@alpine>
In-Reply-To: <1084022241.6755.316.camel@alpine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I am attempting to hack together a 2.6 port of the GL520SM chip
> driver.

Hey, great. Let us know when you have something working.

Be sure to follow my porting guide and the sysfs interface standard
(Documentation/i2c/porting-clients and
Documentation/i2c/sysfs-interface, respectively). Comments on both
documents are welcome.

> I am a little confused as to the relationship between temp2_input, and
> vin4_input values.

> The way I understand it, the GL520SM can either be configured to
> monitor ambient temperature, or the 4th voltage input.  This is done
> by setting/unsetting the 4th bit of the config register.

Correct, except that it's in4_input, not vin4_input. And it's not
necessarily the ambient temperature, just about any temperature where
the thermistor is. And it's the 5th voltage input. And it's the bit 4 of
configuration register, so 5th bit since we always start at 0. But all
in all you're correct, that's how it works ;)

> However when I set the mode bit, the value of the temp2_input register
> does not change.  I would have expected it to switch over to the
> vin4_input reading, and not remain the exact same value.  Also the
> alarms do not trigger when the mode bit is set, and vin4_input is out
> of range of vin4_max, and vin4_min.
> 
> Is there some kind of reset I have to do on the chip other than just
> setting the mode bit?

I don't particularly know the chip. It's a bit old and obviously not
very common. Neither the datasheet nor our docs mention the need of
changing anything. And the 2.4 driver wasn't restarting the chip or
anything similar. I don't know if it was tested though. All in all I
can't tell you why what you observe happens, sorry.

Anyway, you should probably not change that bit. The physical layout of
the chip isn't supposed to change. The BIOS should take care of properly
initializing the value at boot time, and it should not need to be
changed after that. If you really want it to be user-configurable (but
again I don't think you want to) it should probably be a module
parameter, not part of the interface.

As a result, I'd expect your driver to create either the temp2* or the
in4* sysfs files, not both sets.

I'd also like to insist on the fact that the 2.4 driver seems to be
broken in several places. For example, the init function destroys any
configuration that the BIOS could have set. I can't see any reason for
doing that. This is probably the reason for this bug report:
http://archives.andrew.net.au/lm-sensors/msg05950.html

Also, I think that there's a condition error in gl520_temp:
  if ((nr = 0) && (!data->two_temps))
should most likely read
  if ((nr = 1) && (!data->two_temps))
Do you confirm that?

The update function writes the temp2/in4 registers to both temp*[1] and
voltage*[4] regardless of the configuration. This is no good. And
there's no check done in the detect function to see whether the chip is
actually a gl520sm or not.

Please do better than this in your 2.6 driver. You are also welcome to
provide patches for the 2.4 driver.

Last, could you please provide the output of i2cdump on your chip? The
detection function in sensors-detect is rather poor and I'd like to
improve it a bit.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Nov 2009 15:16:13 +0000
Subject: Re: [lm-sensors] ADT7473 and ADT7475
Message-Id: <20091108161613.02eea6f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091107154621.55b98183@hyperion.delvare>
In-Reply-To: <20091107154621.55b98183@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On Sat, 7 Nov 2009 15:46:21 +0100, Jean Delvare wrote:
> Do you have a list of differences between the ADT7473 and ADT7475?
> Looking briefly at the datasheets and drivers, I am under the
> impression that they are essentially compatible and that a combined
> driver for both chips would make a lot of sense. What do you think?

The more I look at these datasheets, the more obvious is becomes that
we really want a single driver for both chips. It is pointless to have
35 kB of duplicated code.

Now there's the question of which driver to keep. I've gathered the
following evidences:

Difference between the ADT7473 and ADT7475 devices:

* The ADT7475 has a fixed I2C address (0x2e) while some ADT7473
  variants have a selectable address (0x2c, 0x2d or 0x2e).
* The ADT7475 has two additional configuration registers
  (Configuration 6 at 0x10 and Configuration 7 at 0x11), but the
  adt7475 driver doesn't make use of them.
* The ADT7473 has five additional registers (Temperature operating
  points at 0x33-0x35 and Dynamic Tmin control at 0x36 and 0x37)
  but the adt7473 driver doesn't make use of them.

Difference between the adt7473 and adt7475 drivers:

* The adt7473 driver is older (kernel 2.6.25, while the adt7475 driver
  was added in kernel 2.6.29) but the adt7475 driver is probably more
  popular.
* The adt7475 driver reads the extra resolution bits in registers 0x76
  and 0x77, while the adt7473 driver does not.
* The adt7475 driver has support for temperature offsets, critical
  limits and their hysteresis, and fault flag, and PWM frequency
  selection, while the adt7473 driver does not support any of these.
* The adt7473 implements the non-standard attribute
  pwm_use_point2_pwm_at_crit, the adt7475 driver doesn't support that.

I couldn't see any obvious difference between the chips for all the
registers which are used by the drivers. But maybe there are, only a
careful datasheet review would tell.

Bugs found in the drivers:

* The adt7475 driver creates pwm#_auto_channel_temp attributes instead
  of the standard pwm#_auto_channels_temp.
* The adt7475 driver refreshed limit values every 2 seconds even
  though the comment in the code says every 60 seconds. 60 seconds
  would make more sense.
* One coding style error in driver adt7473.

At the light of all this, I think I'd keep the adt7475 driver and merge
ADT7473 support therein. If anyone can think of good reasons to do it
the other way around, please speak up.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

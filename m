From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: GL520SM driver
Message-Id: <dazAmaju.1107173795.9105780.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
In-Reply-To: <20050127104814.GA840@frans.deprez-aerts.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Maarten,

> I rewrote the code, patches to linux and lm_sensors2 (cvs) attached. The
> two_temps file is now implemented as a module parameter (default is
> autodetect, so: what the BIOS thinks).

Code looks really great to me, with the minor following comments.

For the kernel driver:

> +static unsigned short extra_sensor_type = 0;

0 is the default value, omit it.

> +#define GL520_REG_IN0_MIN		GL520_REG_IN0_LIMIT
> +#define GL520_REG_IN0_MAX		GL520_REG_IN0_LIMIT

Why define these (and others) and never use them?

> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> +		    goto exit;

Cut the long line, and kill the extra spaces before the goto.

> +	if (extra_sensor_type) {
> +		if (extra_sensor_type = 1)
> +			conf &= ~0x10;
> +		else if (extra_sensor_type = 2)
> +			conf |= 0x10;
> +	}

The first test looks useless.

> +	if (n < 4) {
> +		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0xff) | r);
> +	}

Kill the useless curly braces (twice).

And finally I'd like you to move all sysfs callback functions in a
single place, instead of having definitions at the top and
implementations at the end.

For the sensors program:

First of all I have to say I am very surprised to see that there were no
code for the gl520sm at all so far! This certainly proves that this chip
doesn't have many users.

> +      printf("ERROR: Can't get TEMP1 or VIN4 data!\n");

That would be TEMP2?

> For the autodetection: the revision register isn't zero for me, so that
> cannot be used.

Well, what is it for you? We can use that with some mask.

> The driver reports that my fan1 is at 8000 RPM while BIOS setup monitor
> utility says 4000 RPM, i don't know which is right (could be useful to
> know that this fan is cooling a 667MHz pentium 3 cpu)?

8000RPM seems very high, I would bet that 4000RPM is correct.

> Maybe fan_div is interpreted wrong by the driver?

Don't misunderstand fan_div. It stands for fan clock divider and
doesn't divide the speed value but an internal clock used to measure
it. What fan clock dividers change is the range and accuracy of the
measure, not its value.

Just took a look at the datasheet and it seems clear that the formula
found in the driver doesn't take in account the fact that most fans
emit two pulses per revolution. Thus you would need to change the 960000
into 480000, and then the driver should agree with your BIOS.

> I don't know what fan1_off is, at least it doesn't turn off my fan.

Maybe that output isn't wired on your board.

> Dump (in word mode because some registers are words) attached.

Care to provide a byte mode dump for ceompleteness?

> Maybe we should also send this to the one who was writing a driver so
> he can check and test it?

No news for quite some times, unfortunately.

> Should i send the linux patches (m7101 unhideing and gl520sm driver) for
> inclusion in the kernel?

Sure. For the m7101 unhiding I'm not too sure who to send it to. For the
gl520sm driver, send it to Greg KH. You should make sure that it
properly applies on top of 2.6.11-rc2-mm2 so that Greg can apply it
easily.

Thanks,
--
Jean Delvare

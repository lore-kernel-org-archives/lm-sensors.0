From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: fscpos driver
Message-Id: <SzKmdzTV.1106133513.8306590.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stefan,

> Okay. Meanwhile I changed the code so that the fan status can't be written
> into anymore - it's automatically cleared when the speed raises above 0
> after a failure.

Great.

> However, I don't think I can do the same with the temperature and 
> watchdog status as I can't really test them and I wouldn't want to clear a
> temperature alarm without knowing that the chip takes care of setting it
> again if required.

Why can't you test temperature? I can't see how this is different from
fans.

As for the watchdog, this is something completely different and not
standardized as far as I know, so I don't much care how you implement
it (if at all).

> I also renamed the fanN_min to pwmN and still haven't figured out how they
> work, that is, what the chip does with those values.

Supposedly, higher values result in faster speeds, lower values result in
lower speeds, and possibly 0 value resuls in a stopped fan. Do you
observe something significantly different?

> Libsensors should probably know about the pwm change and that the
> features 'rev' and 'control' are gone. Should I create a patch or are
> you going to do that?

That's right, we need a patch. Either way is fine, if you propose a
patch I'll apply it, if not I'll do it myself. I guess it's better if
you do because you have the hardware to test it afterwards, but if you
don't feel like it it fine too, just tell me.

> For me, the remaining issues are not really relevant, thus I'd say the
> driver is ready now. What do you think?
>
> I attached a patch against kernel 2.6.11-rc1, if you'd like to take a look
> at the code.

Agreed, driver is almost finished, patch looks great. I would have a
number of comments though.

> +static u8 FSCPOS_REG_IDENT[] = { 0x00, 0x01, 0x02 };

I remember telling you that static arrays could be useful, but only in
the case it actually makes the code shorter. In this specific case, you
still read all three registers individually, so there is no benefit (but
still the static array wastes memory and adds a level of indirection).
Really only use these static arrays when it gives you the possibility to
have some code in an indexed loop instead of repeating the same code
several times.

Same holds for FSCPOS_REG_FAN_MIN. If you want the static array to be of
any benefit over simple individual defines, you would use a loop to read
these values in fscpos_update_device instead of two separate
instructions.

> +	u8  watchdog[3];     /* watchdog */

These do not correspond to 3 channels like temperatures and fans do, just
3 distinct registers to control one watchdog timer. I think that using
an array for this is confusing. Why not just have three named members
like wdog_control, wdog_state and wdog_preset?

> +	u8  fan_min[2];      /* fan min value for rps */

Care to rename these to pwm[2] so that it's less confusing, and reword
the comment accordingly?

BTW please reviwe indentation for this part, single space between type
and name, and comments aligned with tabs, not spaces.

> +static ssize_t set_pwm(struct i2c_client *client, struct fscpos_data *data,
> +				const char *buf, size_t count, int nr, int reg)
> +{
> +	unsigned long v = REG_FROM_RPM(simple_strtoul(buf, NULL, 10)) & 0xff;
> +
> +	/* Range: 0..255 */
> +	if (v < 0 || v > 255) {
> +		dev_err(&client->dev, "fan_pwm value %ld not supported. "
> +					"Must be between 0 and 15300!\n", v);
> +		return -EINVAL;
> +	}

I can't much see how v will be out of the 0-255 range since you did mask
it with 0xff just before. Second, the message should mention "pwm" not
"fan_pwm". Third, the message's range doesn't match the test.

I think you should get rid of the bitmasking which is jut confusing.
Then, either keep the 0-255 range test with a valid error message, or
simply force anything below 0 to 0 and anything over 255 to 255. and go
with this. Either choice is fine with me.

> +	/* Do the remaining detection unless force or force_fscpos parameter */
> +	if (kind < 0) {
> +		if ((fscpos_read_value(new_client, FSCPOS_REG_IDENT[0])
> +			!= 0x50) /* 'P' */
> +		||  (fscpos_read_value(new_client, FSCPOS_REG_IDENT[1])
> +			!= 0x45) /* 'E' */
> +		||  (fscpos_read_value(new_client, FSCPOS_REG_IDENT[2])
> +			!= 0x47))/* 'G' */
> +		{
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +	}

You must NOT return an error on misdetection. Doing so stops the whole
detection loop at i2c core level. Simply return 0. You might add a
dev_dbg stating that the detection failed so that we can track problems
if any arise.

> +	kind = fscpos;

Useless, as you then never use this value (and this is OK).

> +	device_create_file(&new_client->dev, &dev_attr_volt12);
> +	device_create_file(&new_client->dev, &dev_attr_volt5);
> +	device_create_file(&new_client->dev, &dev_attr_voltbatt);

Huu, these have to be named in0, in1 and in2. Sorry for not noticing
before. Now I understand why you did not have to make too many changes
to libsensors.

> +	data->revision =  fscpos_read_value(client,FSCPOS_REG_REVISION);

Additional space after comma, please.

> +static void reset_fan_alarm(struct i2c_client *client, int nr)
> +{
> +    fscpos_write_value(client, FSCPOS_REG_FAN_STATE[nr], 4);
> +}

Indent with tab not spaces.

> +MODULE_AUTHOR("Stefan Ott <stefan@desire.ch> based on work from Hermann Jung "
> +    				"<hej@odn.de>, Frodo Looijaard <frodol@dds.nl>"
> +				" and Philip Edelbrock <phil@netroedge.com>");

Ditto.

OK, please fix the problems I found, then you can send the corrected
patch to Greg KH (CC the list).

Thanks,
--
Jean Delvare

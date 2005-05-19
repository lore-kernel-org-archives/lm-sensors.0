From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: DS1621 support for kernel 2.6 (new patch)
Message-Id: <20040313234834.3624030c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040306213810.GA14805@pc.aurel32.private>
In-Reply-To: <20040306213810.GA14805@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > +#define ALARMS_FROM_REG(val) (!(!((val) & \
> > +                              (DS1621_ALARM_TEMP_HIGH |
> > DS1621_ALARM_TEMP_LOW))))
> > 
> > The double negation makes this macro hardly readble. Care to
> > reformulate?
> 
> The double negation is used to convert a number equal to zero or
> different to zero to a number equal to 0 or 1.
> 
> I don't have a lot of idea to reformulate it, I used:
> 
> #define ALARMS_FROM_REG(val) (((val) & \
> 			      (DS1621_ALARM_TEMP_HIGH |
> 			       DS621_ALARM_TEMP_LOW)) & \
> 			       1)
> 
> Maybe you have a better idea.

The problem is, I don't see what you are trying to do. The original
driver has:

#define ALARMS_FROM_REG(val) ((val) & \
                              (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))

And this is exactly what you are supposed to have. Why did you want to
change it in the first place?

> In fact making the chip to work in non continous mode (starting
> conversion explicitly), give the possibility to get high resolution
> temperature (resolution of 0.01?C) instead of standard resolution
> (0.5?C). In the driver there was a start of 1 shot conversion support,
> but no routines to get high resolution temperatures.
> 
> I removed all routines concerning the continous parameter.

I prefer it that way. That "extra resolution" feature sounded bloated to
me. Who needs such a resolution after all?

> > Polarity
> > should be left unchanged. 
> I not really agree with that. The polarity parameter doesn't control
> the polarity of the alarms, but rather the polarity of the output pin.
> On my circuit, this pin activates a relay, and the polarity would be
> different if you want to connect an heater or an air conditionner!

I usually object that BIOSes are supposed to set things up for you, but
it of course doesn't apply in this case.

Don't you think it should be a module parameter instead? I don't think
that's the kind of setting you want to change at runtime. I'd suggest
that you leave the polarity unchanged by default, and force it to 0 or 1
on user request.

If you don't like the idea, then we have to find a correct name for the
sysfs file. Whenever possible, sysfs names should express precisely what
they represent.

On the patch itself:

> /* The DS1621 registers */
> #define DS1621_REG_TEMP			0xAA /* word, RO */
> #define DS1621_REG_TEMP_OVER		0xA1 /* word, RW */
> #define DS1621_REG_TEMP_HYST		0xA2 /* word, RW -- it's a low temp trigger */
> #define DS1621_REG_CONF			0xAC /* byte, RW */
> #define DS1621_REG_TEMP_COUNTER		0xA8 /* byte, RO */
> #define DS1621_REG_TEMP_SLOPE		0xA9 /* byte, RO */
> #define DS1621_COM_START		0xEE /* no data */
> #define DS1621_COM_STOP			0x22 /* no data */

DS1621_REG_TEMP_COUNTER, DS1621_REG_TEMP_SLOPE and DS1621_COM_STOP are
unused. Removing them completely would simplify ds1621_read_value and
ds1621_write_value much.

> static u16 swap_bytes(u16 val)
> {
> 	return (val >> 8) | (val << 8);
> }

This should be inlined in lm75.h IMHO, but let's leave this for later.

> 
> /* All registers are word-sized, except for the configuration register.
>    DS1621 uses a high-byte first convention, which is exactly opposite to
>    the usual practice. */
> static int ds1621_read_value(struct i2c_client *client, u8 reg)
> {
> 	if ((reg = DS1621_REG_CONF) || (reg = DS1621_REG_TEMP_COUNTER)
> 	    || (reg = DS1621_REG_TEMP_SLOPE))
> 		return i2c_smbus_read_byte_data(client, reg);
> 	else
> 		return swap_bytes(i2c_smbus_read_word_data(client, reg));
> }
> 
> /* All registers are word-sized, except for the configuration register.
>    DS1621 uses a high-byte first convention, which is exactly opposite to
>    the usual practice. */
> static int ds1621_write_value(struct i2c_client *client, u8 reg, u16 value)
> {
> 	if ( (reg = DS1621_COM_START) || (reg = DS1621_COM_STOP) )
> 		return i2c_smbus_write_byte(client, reg);
> 	else
> 	if ((reg = DS1621_REG_CONF) || (reg = DS1621_REG_TEMP_COUNTER)
> 	    || (reg = DS1621_REG_TEMP_SLOPE))
> 		return i2c_smbus_write_byte_data(client, reg, value);
> 	else
> 		return i2c_smbus_write_word_data(client, reg,
> 						 swap_bytes(value));
> }

The comments don't match the code, but it doesn't matter much if you get
rid of DS1621_REG_TEMP_COUNTER and DS1621_REG_TEMP_SLOPE completely.

I don't think I would include DS1621_COM_START in ds1621_write_value,
since it's used only once and isn't a real write. But maybe that's just
me.

> static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO , show_temp_hyst, set_temp_hyst);
> static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_over, set_temp_over);

BTW, is it an hysteresis or a min limit? After a quick look at the
DS1621 datasheet, I'm not absolutely sure. It looks like an hysteresis
for the output but a min for the alarm flags. Doesn't make much sense to
me. Any chance you can clarify the situation?

Also, we just changed the sysfs naming conversions. Please see
Documentation/i2c/sysfs-interface in 2.6.4-mm1 or after applying this
page on top of 2.6.4:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.4-i2c.patch.gz

Baically, the idea is that temp_max1 becomes temp1_max, etc...

> 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
> 	   at this moment; i2c_detect really won't call us. */
> 	if (i2c_is_isa_adapter(adapter)) {
> 		dev_dbg(&adapter->dev, 
> 		        "ds1621.o: ds1621_detect called for an ISA bus adapter?!?\n");
> 		return 0;
> 	}

This block isn't needed. The functionality check below it does the same
as a side effect.

>         memset(new_client, 0, sizeof(struct i2c_client) +
> 	       sizeof(struct ds1621_data));

Bad indentation.

> 	/* Now, we do the remaining detection. It is lousy. */
> 	if (kind < 0) {
> 		conf = i2c_smbus_read_byte_data(new_client,
> 						DS1621_REG_CONF);

Don't you use ds1621_read_value here? (This is a true question, I don't
know if this was not done on purpose in the first place.)

> 		if ((conf & DS1621_REG_CONFIG_MASK)
> 		    != DS1621_REG_CONFIG_VAL)
> 			goto ERROR2;
> 	}

The detection could be improved by reading temperatures (the three of
them) and check that the 7 lower bits are clear. This is how things are
done in sensors-detect.

> 	if (kind = ds1621) {
> 		client_name = "ds1621";
> 	} else {
> 		dev_dbg(&adapter->dev,
> 		        "ds1621.o: Internal error: unknown kind (%d)?!?",
> 		        kind);
> 		goto ERROR2;
> 	}

The "else" block is useless. Several drivers used to do that, but I've
just submitted a patch that fixes this.

> 	/* Fill in remaining client fields and put it into the global list */
> 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);

You could even hardcode "ds1621" here and save some bytes. It's unlikely
that such on old driver will be extended to support an additional chip.

> /* OK, this is not exactly good programming practice, usually. But it is
>    very code-efficient in this case. */
>       ERROR2:
> 	kfree(new_client);
>       ERROR1:
>       ERROR0:
> 	return err;

Merge ERROR0 and ERROR1, and rename labels to exit_free and exit.

A few more things:

1* Don't hesitate to credit yourself for porting the driver.

2* Please provide a patch against 2.6.4-mm1 (or 2.6.4 + the patch
mentioned above). There were changes made to Makefile and Kconfig, your
previous patch wouldn't have applied cleanly.

3* Do you know if there are differences between the DS1621 and the
DS1625? The driver is supposed to support both.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

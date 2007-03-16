From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Fri, 16 Mar 2007 21:07:52 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703162207.53490.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Freitag, 16. M?rz 2007 20:17 schrieb Jean Delvare:
>
> pwm1_enable=0 means fan full on, so you'll have to update your code and
> documentation a bit, sorry.

No problem, wasn't much work.

>
> You should not need to change anything at module load time.

Well, MAX6650 knows 4 modes, we know 3, so there's always one mode the MAX6650 
could be in that we have to map to one of our known modes. In that case I 
map "full off" to "open loop" and set the output to zero (dac%5).

>
> > /* fan_voltage: 5=5V fan, 12V fan, 0=don't change */
> > static int fan_voltage = 0;
> > /* prescaler: Possible values are 1,2,4,8,16, or 0 for don't change */
> > static int prescaler = 0;
>
> The trick is to _not_ initialize these variables at all. The compiler
> will put them in a special section and will zero them all at once
> automatically.

Sounds dangerous. But I trust you :-)

>
> > static int max6650_attach_adapter(struct i2c_adapter *adapter)
> > {
> > 	if (!(adapter->class & I2C_CLASS_HWMON)) {
> > 		dev_err(&adapter->dev,
> > 			"FATAL: max6650_attach_adapter class HWMON not set\n");
> > 		return 0;
> > 	}
> >
> > 	return i2c_probe(adapter, &addr_data, max6650_detect);
> > }
>
> Please make it a dev_dbg(). There are more than one I2C bus on most
> systems, and usually only one with I2C_CLASS_HWMON set, on purpose. You
> don't want to generate an error message in the logs for every other I2C
> bus.

Already noticed that, but didn't know the explanation. Fixed.

>
> > 	if ((kind < 0)&&
> > 	   (  (i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG) & 0xC0)
> >
> > 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_GPIO_STAT) & 0xE0)
> > 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM_EN) & 0xE0)
> > 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM) & 0xE0)
> > 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_COUNT) & 0xFC)))
> >
> > 	{
> > 		dev_dbg(&adapter->dev,
> > 			"max6650: detection failed at 0x%02x.\n", address);
> > 		goto err_free;
> > 	}
>
> Opening curly brace is misplaced.

I know, I know. IMHO, with the curly brace placed correctly, it looks ugly. 
But for the sake of coding style, I fixed it. I hoped you wouldn't notice ;-)

>
> > static const u8 tach_reg[] > > {
> > 	MAX6650_REG_TACH0,
> > 	MAX6650_REG_TACH1,
> > 	MAX6650_REG_TACH2,
> > 	MAX6650_REG_TACH3,
> > };
>
> And same here.

OK, I missed that one.

>
> Other than that I am very happy with this latest version. Great job!
> Thanks for your patience, I know it's always a bit frustrating when
> your code works well enough for yourself and you are still told to make
> many changes before it is acceptable upstream.

Well, I really appreciate good code quality. If this is the price, I'm willing 
to pay it. Actually, I thank you for helping me so much.

>
> Can you please test the user-space support now? I suspect that we need
> to update libsensors at least to match the name change of the "speed"
> file. We're about to release lm_sensors 2.10.3 (in a few days now) and
> I'd like it to support your new driver properly.

Yes, but not so soon, sorry. I'm not at home the whole next week and will not 
have any sensors hardware available. After that, I might find some time to 
have a look. I have an LM93 driver almost ready, so that'll be the next thing 
I'll keep you busy with :-) In the course of that development I can have a 
short look at user space stuff, too.

Thanks,

Hans

-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6650.patch
Type: text/x-diff
Size: 24447 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070316/74f5c1dd/attachment-0001.bin 

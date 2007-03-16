From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 16 Mar 2007 19:17:17 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070316201717.db788a9f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

Thanks for the quick update.

On Fri, 16 Mar 2007 17:44:32 +0100, Hans-J?rgen Koch wrote:
> > I don't understand. For one thing, if you know how to turn the fan off,
> > then you could do it when fan1_target is set to 0, it's just a matter
> > of adding a few more lines of code. For another, fan1_target is related
> > to the closed loop mode (pwm1_enable=2) while the fan off mode would
> > generally be implemented as part of the open loop mode: pwm1_enable=1
> > and pwm1=0. But I see that you don't have a pwm1 file, so... How does
> > the open loop mode work at all?
> 
> Open loop mode just sets the ouput voltage according to a DAC value (0..255).
> If someone needs a defined speed, he's supposed to do the regulator in 
> software. It is not influenced by the speed register used in closed loop 
> mode. I added a pwm1 file to read/write that DAC value. After doing that, I 
> noticed the fan can be brought to full/zero speed by setting pwm1 to 0 or 
> 255, respectively. That's OK for me.
> For pwm1_enable, I only use the well defined values now: 0=off, 1=open loop, 
> 2=closed loop. If I find the chip in "full on" mode at load time, I change 
> mode to open loop and set it to full speed. I hope this always works and 
> won't set somebodies board on fire :-)
> 
> BTW, meanwhile I'm a bit confused about what pwm1_enable=0 means. Is it "fan 
> off" or "PWM off, fan full on"? At the moment, I implemented "fan off", but I 
> can easily change that. The other way round would be slightly simpler.

pwm1_enable=0 means fan full on, so you'll have to update your code and
documentation a bit, sorry.

You should not need to change anything at module load time.

> /* fan_voltage: 5=5V fan, 12V fan, 0=don't change */
> static int fan_voltage = 0;
> /* prescaler: Possible values are 1,2,4,8,16, or 0 for don't change */
> static int prescaler = 0;

The trick is to _not_ initialize these variables at all. The compiler
will put them in a special section and will zero them all at once
automatically.

> static int max6650_attach_adapter(struct i2c_adapter *adapter)
> {
> 	if (!(adapter->class & I2C_CLASS_HWMON)) {
> 		dev_err(&adapter->dev,
> 			"FATAL: max6650_attach_adapter class HWMON not set\n");
> 		return 0;
> 	}
> 
> 	return i2c_probe(adapter, &addr_data, max6650_detect);
> }

Please make it a dev_dbg(). There are more than one I2C bus on most
systems, and usually only one with I2C_CLASS_HWMON set, on purpose. You
don't want to generate an error message in the logs for every other I2C
bus.

> 	if ((kind < 0)&&
> 	   (  (i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG) & 0xC0)
> 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_GPIO_STAT) & 0xE0)
> 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM_EN) & 0xE0)
> 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_ALARM) & 0xE0)
> 	    ||(i2c_smbus_read_byte_data(client, MAX6650_REG_COUNT) & 0xFC)))
> 	{
> 		dev_dbg(&adapter->dev,
> 			"max6650: detection failed at 0x%02x.\n", address);
> 		goto err_free;
> 	}

Opening curly brace is misplaced.

> static const u8 tach_reg[] > {
> 	MAX6650_REG_TACH0,
> 	MAX6650_REG_TACH1,
> 	MAX6650_REG_TACH2,
> 	MAX6650_REG_TACH3,
> };

And same here.

Other than that I am very happy with this latest version. Great job!
Thanks for your patience, I know it's always a bit frustrating when
your code works well enough for yourself and you are still told to make
many changes before it is acceptable upstream.

Can you please test the user-space support now? I suspect that we need
to update libsensors at least to match the name change of the "speed"
file. We're about to release lm_sensors 2.10.3 (in a few days now) and
I'd like it to support your new driver properly.

Thanks,
-- 
Jean Delvare


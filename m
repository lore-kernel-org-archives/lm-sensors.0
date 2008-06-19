From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jun 2008 17:45:47 +0000
Subject: Re: [lm-sensors] [PATCH] ad7414 driver
Message-Id: <20080619194547.0efb8d2f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080613221221.50c642ee@lappy.seanm.ca>
In-Reply-To: <20080613221221.50c642ee@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Thu, 19 Jun 2008 12:37:04 -0400, Sean MacLennan wrote:
> On Thu, 19 Jun 2008 12:46:50 +0200, Jean Delvare wrote:
> > This is overwriting _all_ the bits of the configuration file,
> > including changes that could have been done by the the BIOS or
> > firmware or whatever. That's not OK! You must read the configuration
> > register value, check bit 2, and if it's set, write the value back
> > with just bit 2 cleared.
> 
> I work with, what we call, "board drivers" too much. We always reset
> everything to a know state ;)
> 
> We don't need to worry about bit 2. The chip always runs in continuous
> conversion mode unless it is powered down. The one shot just *forces*
> an immediate conversion rather than waiting 800ms.
> 
> The one shot is really more useful in the powered down mode.

My bad, I really meant bit 7, not bit 2. I read the datasheet in a
hurry it seems.

> All we have to guarantee is that the chip is powered up. Below is the
> new code:
> 
> 	/* Make sure the chip is powered up. */
> 	conf = i2c_smbus_read_byte_data(client, AD7414_REG_CONF);
> 	if (conf < 0)
> 		printk(KERN_WARNING
> 		       "ad7414_probe unable to read config register.\n");
> 	else {
> 		conf &= ~(1 << 7);
> 		i2c_smbus_write_byte_data(client, AD7414_REG_CONF, conf);
> 	}
> 
> I do not fail the driver if the config read fails. The ad7414 is very
> important for our board and will always come up with the reset
> value. So the above code is really a NOP for us. I would hate to fail
> the driver due to an i2c bus glitch.
> 
> If we can agree on the above patch, I can submit a patch with the code
> changes.

Yes, that's totally fine with me. Except that you want to use dev_warn
instead of printk, of course.

> I also added the AD7414_REG_LIMIT array and the round off change.

Great, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

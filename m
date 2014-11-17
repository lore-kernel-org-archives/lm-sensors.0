From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Nov 2014 20:46:24 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm95234) Add support for LM95233
Message-Id: <20141117204624.GA27914@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416162195-25193-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1416162195-25193-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 17, 2014 at 10:23:46AM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 16 Nov 2014 10:23:15 -0800, Guenter Roeck wrote:
> > LM95233 is similar to LM95234, but it only supports two
> > instead of four external temperature sensors.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  Documentation/hwmon/lm95234 | 15 ++++++---
> >  drivers/hwmon/lm95234.c     | 78 ++++++++++++++++++++++++++++++++-------------
> >  2 files changed, 66 insertions(+), 27 deletions(-)
> 
> Please also update drivers/hwmon/Kconfig.
> 
> > (...)
> >  static int lm95234_detect(struct i2c_client *client,
> >  			  struct i2c_board_info *info)
> >  {
> >  	struct i2c_adapter *adapter = client->adapter;
> > +	int address = client->addr;
> >  	int mfg_id, chip_id, val;
> > +	const char *name;
> >  
> >  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> >  		return -ENODEV;
> > @@ -622,8 +640,20 @@ static int lm95234_detect(struct i2c_client *client,
> >  		return -ENODEV;
> >  
> >  	chip_id = i2c_smbus_read_byte_data(client, LM95234_REG_CHIP_ID);
> > -	if (chip_id != LM95234_CHIP_ID)
> > +	switch (chip_id) {
> > +	case LM95233_CHIP_ID:
> > +		if (address != 0x18 && address != 0x2a && address != 0x2b)
> > +			return -ENODEV;
> > +		name = "lm95233";
> > +		break;
> > +	case LM95234_CHIP_ID:
> > +		if (address != 0x18 && address != 0x4d && address != 0x4e)
> > +			return -ENODEV;
> > +		name = "lm95234";
> > +		break;
> > +	default:
> >  		return -ENODEV;
> > +	}
> >  
> >  	val = i2c_smbus_read_byte_data(client, LM95234_REG_STATUS);
> >  	if (val & 0x30)
> 
> After that the code checks for unused bits in 5 registers, 3 of which
> have more unused bits in the case of the LM95233. Checking these would
> make the detection code slightly less prone to false positives, at the
> price of slightly more complicated detection code. Did you not do it on
> purpose, or is it an overlook? I admit I'm not sure myself if the gain
> is worth the code, but OTOH in general we try to keep the detection
> logic the same between drivers and sensors-detect.
> 
Hi Jean,

I'll need to connect the hardware again and make sure that the more specific
detection works. I wrote those patches back in April and completely forgot
about them, so I don't really remember details ...

> Also maybe update MODULE_DESCRIPTION? And as usual add the new device
> to wiki/Devices. Interestingly, sensors-detect is already up-to-date.
> 
Sure, done. I also updated several links to other National Semiconductor
devices to point to the TI website.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks a lot for the reviews!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

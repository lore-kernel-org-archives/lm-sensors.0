From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jul 2011 09:29:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Fix chip detection code
Message-Id: <20110707112948.4c9d3a6a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309207117-9892-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309207117-9892-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Sorry for the late review.

On Tue, 5 Jul 2011 07:32:05 -0700, Guenter Roeck wrote:
> On Mon, Jun 27, 2011 at 04:38:37PM -0400, Guenter Roeck wrote:
> > The LM95241 driver accepts every chip ID equal to or larger than 0xA4 as its
> > own, and other chips such as LM95245 use chip IDs in the accepted ID range.
> > This results in false chip detection.
> > 
> > Fix problem by accepting only the known LM95241 chip ID. Also remove the debug
> > message displayed if chip detection failed since it just adds noise and no real
> > value.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Anyone with objections to this patch please speak up now or be silent forever ...
> I'll submit it to Linus sometime this week.

OK, I'll speak now then.

> > ---
> > Kept name variable to prepare for possible later addition of LM95231 support
> > (after I get samples).
> > 
> >  drivers/hwmon/lm95241.c |   17 ++++++-----------
> >  1 files changed, 6 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> > index 1a6dfb6..f2cfecf 100644
> > --- a/drivers/hwmon/lm95241.c
> > +++ b/drivers/hwmon/lm95241.c
> > @@ -330,24 +330,19 @@ static int lm95241_detect(struct i2c_client *new_client,
> >  			  struct i2c_board_info *info)
> >  {
> >  	struct i2c_adapter *adapter = new_client->adapter;
> > -	int address = new_client->addr;
> >  	const char *name;
> >  
> >  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> >  		return -ENODEV;
> >  
> > -	if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
> > -	     = MANUFACTURER_ID)
> > -	    && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> > -		>= DEFAULT_REVISION)) {
> > -		name = DEVNAME;
> > -	} else {
> > -		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
> > -			address);
> > +	if (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
> > +	    != MANUFACTURER_ID
> > +	    || i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> > +	    != DEFAULT_REVISION)
> >  		return -ENODEV;
> > -	}
> >  
> > -	/* Fill the i2c board info */
> > +	name = DEVNAME;
> > +
> >  	strlcpy(info->type, name, I2C_NAME_SIZE);
> >  	return 0;
> >  }

You are hiding the key change with cleanups and logic inversion. That's
not really desirable in general, and even less so for a fix that IMHO
should go to stable trees. Given that you are reworking the logic in a
later patch anyway ("Add support for LM95231") I'd much prefer that
this first patch simply turns ">=" into "=". This will make the fix
much more obvious.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

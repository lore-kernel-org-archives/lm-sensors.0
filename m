From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 May 2015 17:58:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (atxp1) Drop auto-detection
Message-Id: <20150528175858.GC17302@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432768774-19799-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432768774-19799-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, May 28, 2015 at 07:57:39AM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 27 May 2015 16:19:34 -0700, Guenter Roeck wrote:
> > Auto-detection for this chip is highly unreliable, and one of its
> > I2C addresses can also be used by EEPROMs, increasing the risk for
> > false positives even more. Drop auto-detection entirely to remove
> > the risk.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/atxp1.c | 46 ----------------------------------------------
> >  1 file changed, 46 deletions(-)
> > 
> > diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> > index 4c829bb2f9db..75fa2f603fa1 100644
> > --- a/drivers/hwmon/atxp1.c
> > +++ b/drivers/hwmon/atxp1.c
> > @@ -43,8 +43,6 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
> >  #define ATXP1_VIDMASK	0x1f
> >  #define ATXP1_GPIO1MASK	0x0f
> >  
> > -static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
> > -
> 
> Maybe replace with a comment listing the possible address and
> explaining that the device must be explicitly instantiated?
> 
Ok. Too bad the datasheet is not public; it might be useful to know
if the chip supports other addresses. 

> >  struct atxp1_data {
> >  	struct i2c_client *client;
> >  	struct mutex update_lock;
> > @@ -259,48 +257,6 @@ static struct attribute *atxp1_attrs[] = {
> >  };
> >  ATTRIBUTE_GROUPS(atxp1);
> >  
> > -/* Return 0 if detection is successful, -ENODEV otherwise */
> > -static int atxp1_detect(struct i2c_client *new_client,
> > -			struct i2c_board_info *info)
> > -{
> > -	struct i2c_adapter *adapter = new_client->adapter;
> > -
> > -	u8 temp;
> > -
> > -	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> > -		return -ENODEV;
> > -
> > -	/* Detect ATXP1, checking if vendor ID registers are all zero */
> > -	if (!((i2c_smbus_read_byte_data(new_client, 0x3e) = 0) &&
> > -	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
> > -	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
> > -	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0)))
> > -		return -ENODEV;
> > -
> > -	/*
> > -	 * No vendor ID, now checking if registers 0x10,0x11 (non-existent)
> > -	 * showing the same as register 0x00
> > -	 */
> > -	temp = i2c_smbus_read_byte_data(new_client, 0x00);
> > -
> > -	if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
> > -	      (i2c_smbus_read_byte_data(new_client, 0x11) = temp)))
> > -		return -ENODEV;
> > -
> > -	/* Get VRM */
> > -	temp = vid_which_vrm();
> > -
> > -	if ((temp != 90) && (temp != 91)) {
> > -		dev_err(&adapter->dev, "atxp1: Not supporting VRM %d.%d\n",
> > -				temp / 10, temp % 10);
> > -		return -ENODEV;
> > -	}
> 
> I believe this check should be moved to either atxp1_probe() or the
> module's init function (after expanding module_i2c_driver.)
> 
Makes sense. Done.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

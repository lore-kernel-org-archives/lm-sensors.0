From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 10:15:30 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: (max6650) Convert to be a platform driver
Message-Id: <20140213111530.2a2b4982@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392281438-31836-1-git-send-email-lpapp@kde.org>
	<20140213095817.GD32508@lee--X1>
In-Reply-To: <20140213095817.GD32508@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Laszlo Papp <lpapp@kde.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

On Thu, 13 Feb 2014 09:58:17 +0000, Lee Jones wrote:
> > The MFD driver has now been added, so this driver is now being adopted to be a
> > subdevice driver on top of it. This means, the i2c driver usage is being
> > converted to platform driver usage all around.
> > 
> > Signed-off-by: Laszlo Papp <lpapp@kde.org>
> > ---
> > This patch has been compile tested only and will be tested with real hardware,
> > but early reviews to catch any trivial issues would be welcome.
> >  drivers/hwmon/Kconfig   |   2 +-
> >  drivers/hwmon/max6650.c | 155 ++++++++++++++++++++++++------------------------
> >  2 files changed, 79 insertions(+), 78 deletions(-)
> 
> <snip>
> 
> >  /*
> >   * Insmod parameters
> > @@ -105,24 +108,23 @@ module_param(clock, int, S_IRUGO);
> >  
> >  #define DIV_FROM_REG(reg) (1 << (reg & 7))
> >  
> > -static int max6650_probe(struct i2c_client *client,
> > -			 const struct i2c_device_id *id);
> > -static int max6650_init_client(struct i2c_client *client);
> > -static int max6650_remove(struct i2c_client *client);
> > +static int max6650_probe(struct platform_device *pdev);
> > +static int max6650_init_client(struct platform_device *pdev);
> > +static int max6650_remove(struct platform_device *pdev);
> >  static struct max6650_data *max6650_update_device(struct device *dev);
> 
> It would be good to remove these forward declarations in the future.
> 
> If no one volunteers I'll happily do it.

Guenter just did:

http://lists.lm-sensors.org/pipermail/lm-sensors/2014-February/041224.html

Any change to the max6650 driver should go on top of his patch series
to avoid conflicts:

http://lists.lm-sensors.org/pipermail/lm-sensors/2014-February/041223.html

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

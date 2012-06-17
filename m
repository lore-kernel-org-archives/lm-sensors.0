From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 17 Jun 2012 14:34:11 +0000
Subject: Re: [lm-sensors] [PATCH 75/95] hwmon: (thmc50) Convert to use devm_ functions
Message-Id: <20120617143411.GA4510@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-76-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-76-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 17, 2012 at 08:52:56AM +0200, Jean Delvare wrote:
> On Fri, 15 Jun 2012 08:23:56 -0700, Guenter Roeck wrote:
> > Convert to use devm_ functions to reduce code size and simplify the code.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/thmc50.c |   15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
> > index add9f01..2f78e3f 100644
> > --- a/drivers/hwmon/thmc50.c
> > +++ b/drivers/hwmon/thmc50.c
> > @@ -361,11 +361,11 @@ static int thmc50_probe(struct i2c_client *client,
> >  	struct thmc50_data *data;
> >  	int err;
> >  
> > -	data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL);
> > +	data = devm_kzalloc(&client->dev, sizeof(struct thmc50_data),
> > +			    GFP_KERNEL);
> >  	if (!data) {
> > -		pr_debug("thmc50: detect failed, kzalloc failed!\n");
> > -		err = -ENOMEM;
> > -		goto exit;
> > +		pr_debug("thmc50: detect failed, devm_kzalloc failed!\n");
> 
> This message is confusing, as we are in the probe function and not the
> detect function. Plus, dev_dbg() should be used instead or pr_debug.
> 
> But actually I don't think we need any message here, the driver core
> will display a warning message whenever a probe fails (other than with
> -ENXIO or -ENODEV) so this one is redundant. Please drop it.
> 
Done.

Thanks,
Guenter

> > +		return -ENOMEM;
> >  	}
> > (...)
> 
> Other than this:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

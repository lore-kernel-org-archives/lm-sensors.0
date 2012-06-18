From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Jun 2012 15:28:37 +0000
Subject: Re: [lm-sensors] [PATCH 86/95] hwmon: (w83l785ts) Convert to use devm_ functions
Message-Id: <20120618152837.GA2396@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-87-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-87-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 17, 2012 at 09:42:22PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 15 Jun 2012 08:24:07 -0700, Guenter Roeck wrote:
> > Convert to use devm_ functions to reduce code size and simplify the code.
> > 
> > Also, in probe function, rename new_client variable to client, and introduce
> > local variable dev to point to client->dev, to simplify the code further and
> > improve readability.
> 
> Best done as two separate patches...
> 
Separated ...

> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83l785ts.c |   30 +++++++++++-------------------
> >  1 file changed, 11 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
> > index 5f14e38..35671f5 100644
> > --- a/drivers/hwmon/w83l785ts.c
> > +++ b/drivers/hwmon/w83l785ts.c
> > @@ -176,19 +176,18 @@ static int w83l785ts_detect(struct i2c_client *client,
> >  	return 0;
> >  }
> >  
> > -static int w83l785ts_probe(struct i2c_client *new_client,
> > +static int w83l785ts_probe(struct i2c_client *client,
> >  			   const struct i2c_device_id *id)
> >  {
> >  	struct w83l785ts_data *data;
> > +	struct device *dev = &client->dev;
> >  	int err = 0;
> 
> Not related to your changes directly, but this initialization is not
> needed.
> 
done

> >  (...)
> > @@ -200,18 +199,16 @@ static int w83l785ts_probe(struct i2c_client *new_client,
> >  	 * Nothing yet, assume it is already started.
> >  	 */
> >  
> > -	err = device_create_file(&new_client->dev,
> > -				 &sensor_dev_attr_temp1_input.dev_attr);
> > +	err = device_create_file(dev, &sensor_dev_attr_temp1_input.dev_attr);
> >  	if (err)
> >  		goto exit_remove;
> 
> You might as well turn this into a straight return, as there is nothing
> to remove at this point.
> 
and done.

> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

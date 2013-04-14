From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 14 Apr 2013 14:39:33 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (tmp401) Add support for update_interval attribute
Message-Id: <20130414143933.GB6610@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 14, 2013 at 02:48:12PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri,  5 Apr 2013 18:02:56 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/tmp401.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> Looks good overall, with minor comments though:
> 
> > diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> > index c0cf87d..e16544a 100644
> > --- a/drivers/hwmon/tmp401.c
> > +++ b/drivers/hwmon/tmp401.c
> > @@ -126,6 +126,8 @@ struct tmp401_data {
> >  	unsigned long last_updated; /* in jiffies */
> >  	enum chips kind;
> >  
> > +	int update_interval;	/* in milliseconds */
> 
> Should be unsigned. As a matter of fact you print it with %u not %d.
> 
> > +
> >  	/* register values */
> >  	u8 status;
> >  	u8 config;
> > @@ -193,10 +195,13 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
> >  	struct tmp401_data *data = i2c_get_clientdata(client);
> >  	struct tmp401_data *ret = data;
> >  	int val;
> > +	unsigned long next_update;
> >  
> >  	mutex_lock(&data->update_lock);
> >  
> > -	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> > +	next_update = data->last_updated +
> > +	  msecs_to_jiffies(data->update_interval) + 1;
> 
> More indentation would make this more readable IMHO (for example align
> on "=".)
> 
> > +	if (time_after(jiffies, next_update) || !data->valid) {
> >  		val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
> >  		if (val < 0) {
> >  			ret = ERR_PTR(val);
> 
> > (...)
> > +static ssize_t set_update_interval(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct tmp401_data *data = i2c_get_clientdata(client);
> > +	unsigned long val;
> > +	int err, rate;
> > +
> > +	err = kstrtoul(buf, 10, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	mutex_lock(&data->update_lock);
> > +	/*
> > +	 * For valid rates, interval can be calculated as
> > +	 *	interval = (1 << (7 - rate)) * 125;
> > +	 * Rounded rate is therefore
> > +	 *	rate = 8 - fls(interval * 4 / (125 * 3));
> > +	 * Use clamp_val() to avoid overflows, and to clamp the result
> > +	 * to its valid range.
> > +	 */
> > +	val = clamp_val(val, 0, 100000);
> 
> Use clamp_val(val, 125, 16000), then you no longer need the second call
> to clamp_val(). And then you could also use __fls(), which is faster
> than fls() and starts counting at 0 so no s/7/8/ magic needed. Lastly,
> note that the computation can be done outside of the locked section,
> 
Hi Jean,

Excellent idea.

Something else: The TMP4xx chips have a separate resolution register. Wonder if
it is time to add a "resolution" attribute to the ABI, especially since this has
come up a couple of times already. Thoughts ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

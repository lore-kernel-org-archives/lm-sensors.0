From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Jun 2012 15:51:39 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (acpi_power_meter) Remove unnecessary if statement
Message-Id: <20120620155139.GA14671@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340120803-23543-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340120803-23543-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 20, 2012 at 04:52:01PM +0200, Jean Delvare wrote:
> On Tue, 19 Jun 2012 08:46:42 -0700, Guenter Roeck wrote:
> > An unsigned value is never smaller than 0. Remove the check for it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/acpi_power_meter.c |    2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> > index 34ad5a2..e2b0ae8 100644
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -308,8 +308,6 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
> >  		return res;
> >  
> >  	temp /= 1000;
> > -	if (temp < 0)
> > -		return -EINVAL;
> >  
> >  	mutex_lock(&resource->lock);
> >  	resource->trip[attr->index - 7] = temp;
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> That being said, DIV_ROUND_CLOSEST would be better to use than /=, and
> some clamping on the value would be good to have too, as you can't
> always fit an unsigned long into an int (there may even be other
> constraints, I don't know.)

I thought about doing that as separate patch, but since the above doesn't really
fix a bug anyway, it does not hurt to put it together into one. I'll do that and
resubmit.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

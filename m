From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 19 Jan 2012 16:11:28 +0000
Subject: Re: [lm-sensors] [PATCH 04/39] hwmon: (adm1025) Fix checkpatch issues
Message-Id: <1326989488.2649.140.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-01-19 at 09:55 -0500, Jean Delvare wrote:
> On Mon, 16 Jan 2012 00:49:06 -0800, Guenter Roeck wrote:
> > Fixed:
> > ERROR: do not use assignment in if condition
> > ERROR: space required after that ',' (ctx:VxV)
> > ERROR: spaces required around that '<' (ctx:VxV)
> > ERROR: spaces required around that '=' (ctx:VxV)
> > ERROR: trailing whitespace
> > WARNING: simple_strtol is obsolete, use kstrtol instead
> > WARNING: simple_strtoul is obsolete, use kstrtoul instead
> > 
> > Not fixed:
> > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/adm1025.c |   63 ++++++++++++++++++++++++++++++++++------------
> >  1 files changed, 46 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
> > index 60befc0..14d8997 100644
> > --- a/drivers/hwmon/adm1025.c
> > +++ b/drivers/hwmon/adm1025.c
> > (...)
> > @@ -343,7 +364,14 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> >  		       const char *buf, size_t count)
> >  {
> >  	struct adm1025_data *data = dev_get_drvdata(dev);
> > -	data->vrm = simple_strtoul(buf, NULL, 10);
> > +	unsigned long val;
> > +	int err;
> > +
> > +	err = kstrtoul(buf, 10, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	data->vrm = SENSORS_LIMIT(val, 0, 255);
> >  	return count;
> >  }
> 
> This is a behavioral change, not a mere checkpatch clean-up. The change
> itself is correct but it should be separated.
> 
I have done the same with all vrm assignments, at least the ones similar
to the above. Assigning "value & 255", or in other words a more or less
random value, just seemed wrong.

There are other borderline cases throughout, for example
	unsigned long xxx = simple_strtol(...);
or
	long xxx = simple_strtoul(...);
or
	u32 = simple_strtoul(...);

where I fixed either the variable type or the function call to match
each other, depending on the context. Obviously those also cause minor
behavioral changes - mostly more stringent error checking. I would call
that borderline cases. Sure, I could have fixed the type issues with one
commit and then the coding style issues with another, but that would
just have added complexity to the whole thing for very minor gain.

> The rest looks good, so:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
I'll separate this commit into two and add your Acked-by to both,
assuming this is ok with you.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

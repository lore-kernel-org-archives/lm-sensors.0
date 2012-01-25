From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 25 Jan 2012 10:15:52 +0000
Subject: Re: [lm-sensors] [PATCH 05/79] hwmon: (lm87) Fix vrm value range
Message-Id: <20120125101552.GB12670@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-6-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-6-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 25, 2012 at 04:34:27AM -0500, Jean Delvare wrote:
> On Mon, 23 Jan 2012 18:48:44 -0800, Guenter Roeck wrote:
> > When updating vrm, the value range was not limited. This could result in more or
> > less random vrm values if the value provided by the user was larger than 255.
> > Fix by limiting the range to 0..255 using the SENSORS_LIMIT macro.
> > 
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/lm87.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> > index 8e66f99..2aa5e1a 100644
> > --- a/drivers/hwmon/lm87.c
> > +++ b/drivers/hwmon/lm87.c
> > @@ -604,7 +604,7 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> >  	err = kstrtoul(buf, 10, &val);
> >  	if (err)
> >  		return err;
> > -	data->vrm = val;
> > +	data->vrm = SENSORS_LIMIT(val, 0, 255);
> >  	return count;
> >  }
> >  static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
> 
> Same concerns here as in it87, of course. I suggest you withdraw these
> patches for the time being.
> 
Agreed, makes sense. I'll move those to my "staging" branch for now.

I have a RFC set of patches in the works for hwmon-vid, trying to start addressing
the vrm issue. We can go from there once we decided how to handle it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

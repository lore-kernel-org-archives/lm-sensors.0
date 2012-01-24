From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 14:47:41 +0000
Subject: Re: [lm-sensors] [PATCH 79/79] hwmon: (it87) Fix vrm value range
Message-Id: <20120124144741.GA23333@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 24, 2012 at 03:50:12AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 23 Jan 2012 18:49:58 -0800, Guenter Roeck wrote:
> > When updating vrm, the value range was not limited. This could result in more or
> > less random vrm values if the value provided by the user was larger than 255.
> > Fix by limiting the range to 0..255 using the SENSORS_LIMIT macro.
> > 
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/it87.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > index 0b204e4..bd8775c 100644
> > --- a/drivers/hwmon/it87.c
> > +++ b/drivers/hwmon/it87.c
> > @@ -1324,7 +1324,7 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
> >  	if (kstrtoul(buf, 10, &val) < 0)
> >  		return -EINVAL;
> >  
> > -	data->vrm = val;
> > +	data->vrm = SENSORS_LIMIT(val, 0, 255);
> >  
> >  	return count;
> >  }
> 
> To be honest, I don't know what to do with this.
> 
Same as will all the others, really ;).

> You're replacing a silent failure with another. I'd rather return an
> error if the value doesn't fit. as clamping to 255 will lead to a
> failure in vid_from_reg() later anyway.
> 
I don't mind returning an error instead of using SENSORS_LIMIT(), but doesn't
that defeat the idea behind SENSORS_LIMIT() ?

> On the other hand, we don't validate the VRM value here anyway, it
> could be in the 0-255 range and still lead to a failure in
> vid_from_reg().
> 
... and vid_from_reg() may return 0 even if the value is valid (or at least
it does not have an explicit error return code). So I don't really know
how to validate it. We would have to add a vrm validation call.

> We could improve this of course, but is it worth it? As documented in
> Documentation/hwmon/sysfs-interface, changing the vrm value manually
> should no longer be needed. libsensors does even ignore this attribute
> completely. And newer hardware tends to no longer use the VID pins at
> all. Actually hwmon-vid is in a pretty bad shape at the moment at least
> for all Intel CPUs after Conroe (2007, yeah!) for which we set the VRM
> to 82 i.e. Pentium II/III. And nobody complained yet as far as I know!
> 
> So I'm really not sure if it is worth spending time on. It might make
> more sense to turn all these vrm attributes read-only (and ultimately
> kill them altogether.) If we really want to let the user force the vrm
> value if automatic detection failed, it would probably be better done
> as a module parameter to hwmon-vid. It is certainly less flexible, but
> at least we don't have to repeat it in every hwmon driver.
> 
Your call - let me know.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

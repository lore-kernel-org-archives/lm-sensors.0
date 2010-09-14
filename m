From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Sep 2010 12:38:36 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] hwmon: (lm90) Introduce 3rd set of
Message-Id: <20100914123836.GA4710@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
 <1284038750-8833-6-git-send-email-guenter.roeck@ericsson.com>
 <20100914125137.0928875b@hyperion.delvare>
 <20100914134659.5a9e72df@hyperion.delvare>
In-Reply-To: <20100914134659.5a9e72df@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Jean,

On Tue, Sep 14, 2010 at 07:46:59AM -0400, Jean Delvare wrote:
> On Tue, 14 Sep 2010 12:51:37 +0200, Jean Delvare wrote:
> > On Thu, 9 Sep 2010 06:25:48 -0700, Guenter Roeck wrote:
> > > @@ -818,6 +839,9 @@ static int lm90_detect(struct i2c_client *new_client,
> > >  
> > >  static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
> > >  {
> > > +	if (data->flags & LM90_HAVE_EMERGENCY)
> > > +		sysfs_remove_group(&client->dev.kobj,
> > > +				   &lm90_emergency_group);
> > >  	if (data->flags & LM90_HAVE_OFFSET)
> > >  		device_remove_file(&client->dev,
> > >  				   &sensor_dev_attr_temp2_offset.dev_attr);
> > 
> > But this flag is never set?
> 
> Oh, I get it now, it's set in the next patch. That's not OK, each patch
> should do something useful in its own right. This suggests that you
> have to swap patches 5/7 and 6/7 in the series, first adding a separate
> type for the MAX6659, then adding support for the emergency limits.
> 
Ok.

> Or if this is too much work for you, you may decide to merge both
> patches (hint: "quilt fold" is quite helpful for this, if you're using
> quilt).
> 
I typically use git rebase -i. That lets me do the same, including merging
and reordering patches.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

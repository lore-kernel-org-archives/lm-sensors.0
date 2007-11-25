From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Nov 2007 12:52:16 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] hwmon: (gl518sm) Don't create sysfs
Message-Id: <20071125135216.54e32e9d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071022174617.6866b875@hyperion.delvare>
In-Reply-To: <20071022174617.6866b875@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sat, 24 Nov 2007 20:53:35 -0500, Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2007-10-22 17:46:17 +0200]:
> > The early revisions of the GL518SM do not report voltage values for
> > the first 3 voltage channels. We should not create sysfs attributes
> > for these missing features.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  drivers/hwmon/gl518sm.c |   23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> Applied to hwmon-2.6.git/testing, thanks.  One minor comment though...
> 
> > @@ -496,6 +509,8 @@ static int gl518_detach_client(struct i2
> >  
> >  	hwmon_device_unregister(data->hwmon_dev);
> >  	sysfs_remove_group(&client->dev.kobj, &gl518_group);
> > +	if (data->type = gl518sm_r80)
> > +		sysfs_remove_group(&client->dev.kobj, &gl518_group_r80);
> >  
> >  	if ((err = i2c_detach_client(client)))
> >  		return err;
> 
> Don't forget: you can do sysfs_remove_group() unconditionally.

Thanks for the review. I know that I could call sysfs_remove_group()
unconditionally, and actually I do when it makes the code more simple
(e.g. in error paths). However, in this case the condition is simple
and it seems more efficient to skip the call to sysfs_remove_group()
when we know it won't do anything.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

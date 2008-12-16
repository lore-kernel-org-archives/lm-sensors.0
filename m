From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 18:39:54 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <20081216193954.41298ad4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Dec 2008 19:16:32 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Just as I suspected. Hans, as you can see, fan4's speed is 0 in the
> > chip. So it's not a hardware issue, but a bug in your driver. Which I
> > presume the following patch would fix?
> > 
> > Fix fan4 for the F8000.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  drivers/hwmon/f71882fg.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-2.6.28-rc8.orig/drivers/hwmon/f71882fg.c	2008-12-16 17:42:05.000000000 +0100
> > +++ linux-2.6.28-rc8/drivers/hwmon/f71882fg.c	2008-12-16 18:14:52.000000000 +0100
> > @@ -982,7 +982,7 @@ static struct f71882fg_data *f71882fg_up
> >  
> >  		/* The f8000 can monitor 1 more fan, but has no pwm for it */
> >  		if (data->type = f8000)
> > -			data->fan[3] = f71882fg_read8(data,
> > +			data->fan[3] = f71882fg_read16(data,
> >  						F71882FG_REG_FAN(3));
> >  		if (data->type = f71882fg)
> >  			data->in_status = f71882fg_read8(data,
> > 
> 
> Good catch!
> 
> > Something to fold into hwmon/hwmon-f71882fg-13-add-f8000-support.patch
> > I presume.
> > 
> 
> Yes,
> 
> Updated version attached

Done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

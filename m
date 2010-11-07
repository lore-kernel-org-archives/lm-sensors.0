From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Nov 2010 21:05:26 +0000
Subject: Re: [lm-sensors] [PATCH 6/7] hwmon: (w83795) Clear intrusion alarm
Message-Id: <20101107220526.261e4b11@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107164719.7a29aedb@endymion.delvare>
In-Reply-To: <20101107164719.7a29aedb@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 7 Nov 2010 09:24:59 -0800, Guenter Roeck wrote:
> On Sun, Nov 07, 2010 at 10:47:19AM -0500, Jean Delvare wrote:
> > When asked to clear the intrusion alarm, do so immediately. We have to
> > invalidate the cache to make sure the new status will be read. But we
> > also have to read from the status register once to clear the pending
> > alarm, as writing to CLR_CHS surprising won't clear it automatically.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  w83795.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > --- a/drivers/hwmon/w83795.c	2010-11-06 22:37:55.000000000 +0100
> > +++ b/drivers/hwmon/w83795.c	2010-11-06 22:40:03.000000000 +0100
> > @@ -755,6 +755,10 @@ store_chassis_clear(struct device *dev,
> >  	val = w83795_read(client, W83795_REG_CLR_CHASSIS);
> >  	val |= 0x80;
> >  	w83795_write(client, W83795_REG_CLR_CHASSIS, val);
> > +
> > +	/* Clear status and force cache refresh */
> > +	w83795_read(client, W83795_REG_ALARM(5));
> 
> Won't that clear other (possibly unreported) alarms as well ?

It will clear the interrupt bit for other sources in that register,
yes. But the update function does exactly this already, so this is
nothing new. I don't think it will have any effect on the real-time
register, but I can't check it, because the other sources in that
register are fan9 to fan14, which do not exist on my system.

If I get any report of a user with more than 8 fans connected to a
W83795G/ADG device, I'll check the exact behavior. But I think the
current code is and will stay acceptable regardless, because clearing
the chassis intrusion status is such a rare event.

> 
> If that is not a problem, 
> 	Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

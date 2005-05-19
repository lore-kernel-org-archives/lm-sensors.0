From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [RESEND4] Dallas 1-wire protocol implementation.
Message-Id: <20040710113229.01a2263c@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040703003032.252325b3@zanzibar.2ka.mipt.ru>
In-Reply-To: <20040703003032.252325b3@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 9 Jul 2004 16:42:22 -0700
Greg KH <greg@kroah.com> wrote:

> On Sat, Jul 03, 2004 at 12:30:32AM +0400, Evgeniy Polyakov wrote:
> > On Sun, 20 Jun 2004 16:51:31 +0400
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > Ping.
> > iButton support will coming soon.
> 
> Ok, sorry for the long delay.

Result definetely worth waiting.

> I finally commited this patch, along with a bunch of minor cleanups:
> 	- small formatting ones (took the extra " " out before the "("
> 	  in a function call)
> 	- made some global symbols have a "w1" in them (like "flock")

I've checked your changes and totally agree.

> And then I disabled this whole function:
> 
> > +ssize_t w1_master_attribute_show (struct device *dev, char *buf)
> > +{
> > +	struct w1_master *md = container_of (dev, struct w1_master,
> > dev);+	int c = PAGE_SIZE;
> > +
> > +	if (down_interruptible (&md->mutex))
> > +		return -EBUSY;
> > +
> > +	c -= snprintf (buf + PAGE_SIZE - c, c, "%s\n", md->name);
> > +	c -= snprintf (buf + PAGE_SIZE - c, c,
> > +		       "bus_master=0x%p, timeout=%d, max_slave_count=%d,
> > attempts=%lu\n",+		       md->bus_master, w1_timeout, md->max_slave_count,
> > +		       md->attempts);
> > +	c -= snprintf (buf + PAGE_SIZE - c, c, "%d slaves: ",
> > +		       md->slave_count);
> > +	if (md->slave_count = 0)
> > +		c -= snprintf (buf + PAGE_SIZE - c, c, "no.\n");
> > +	else {
> > +		struct list_head *ent, *n;
> > +		struct w1_slave *sl;
> > +
> > +		list_for_each_safe (ent, n, &md->slist) {
> > +			sl = list_entry (ent, struct w1_slave, w1_slave_entry);
> > +
> > +			c -= snprintf (buf + PAGE_SIZE - c, c, "%s[%p] ",
> > +				       sl->name, sl);
> > +		}
> > +		c -= snprintf (buf + PAGE_SIZE - c, c, "\n");
> > +	}
> > +
> > +	up (&md->mutex);
> > +
> > +	return PAGE_SIZE - c;
> > +}
> 
> As sysfs files should be 1 value per file.  If you want to output a
> whole bunch of info, you need to make a whole bunch of files.

Ok, I will split it up.

> I've added the patch to my bk trees, and it should show up in the next
> -mm release.  If you need a copy of the patch I've applied, so that
> you can send me updates and you don't want to mess with bitkeeper,
> please let me know and I'll send it to you.
> 
> Oh heck, I've put it here for everyone to see, to make it easier:
> 	www.kernel.org/pub/linux/people/gregkh/i2c/2.6/2.6.7/w1-2.6.7.patch

Actually I found it there:
www.kernel.org/pub/linux/kernel/people/gregkh/i2c/2.6/2.6.7/w1-2.6.7.patch

> thanks, and again, sorry for the delay.

As I said, result worth waiting ;)

Thank you.

> greg k-h


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt

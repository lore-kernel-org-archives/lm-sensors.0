From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030314085618.GD3084@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030314005027.GA1923@kroah.com> <10476033153504@kroah.com> <20030314081904.A11701@infradead.org>
In-Reply-To: <20030314081904.A11701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Fri, Mar 14, 2003 at 08:19:04AM +0000, Christoph Hellwig wrote:
> > +/* Internally used pause function */
> > +void ali15x3_do_pause(unsigned int amount)
> > +{
> > +	current->state = TASK_INTERRUPTIBLE;
> > +	schedule_timeout(amount);
> > +}
> 
> I think this should be moved to linux/kernel.h as delay() - I've seen
> it duplicated in so much code (including XFS)

I'll move this.  I think I have this in the usb.h header file too :)

> > +#ifdef DEBUG
> > +	printk
> > +	    ("i2c-ali15x3.o: Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
> > +	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
> > +	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
> > +	     inb_p(SMBHSTDAT1));
> > +#endif
> 
> use pr_debug() here.

In the next round of patches I'm using dev_dbg() and other dev_*
functions for the printk calls, now that we have device support for the
adapters.

thanks,

greg k-h

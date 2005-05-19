From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030923161929.GB4402@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10642734271572@kroah.com> <1064273428551@kroah.com> <20030923091617.B10818@infradead.org>
In-Reply-To: <20030923091617.B10818@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, Sep 23, 2003 at 09:16:17AM +0100, Christoph Hellwig wrote:
> On Mon, Sep 22, 2003 at 04:30:28PM -0700, Greg KH wrote:
> >  	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
> > -		/* XXX: WTF is going on here??? */
> > -		if ((is_isa && check_region(addr, 1)) ||
> > +		void *region_used = request_region(addr, 1, "foo");
> > +		release_region(addr, 1);
> > +		if ((is_isa && (region_used = NULL)) ||
> 
> WTF??  Your papering over bugs again, this doesn't help at all.

Why?

Ok, from my reading of this horrible chunk of code it does the
following:
	- if this is a isa based controller, then we check the region
	  that is to be used.
	- If it is already in use by someone else, then we skip it, and
	  move on to the next address.
	- If it is not in use, then we pass the address down to the chip
	  driver and let it try to find the chip at this address (it
	  will do the reserving of the address space on its own.)

So basically, check_region is pretty valid here, as we are trying to see
if something else is already at this address, to try to prevent i2c
drivers from stomping on each other.  I replaced this with a
request_region()/release_region() pair to get rid of the compiler
warning.

Is this your understanding too?  Or do you think we should just get rid
of the request_region() check here all together?

thanks,

greg k-h

From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030923172258.B19880@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10642734271572@kroah.com> <1064273428551@kroah.com> <20030923091617.B10818@infradead.org> <20030923161929.GB4402@kroah.com>
In-Reply-To: <20030923161929.GB4402@kroah.com>; from greg@kroah.com on Tue, Sep 23, 2003 at 09:19:29AM -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, Sep 23, 2003 at 09:19:29AM -0700, Greg KH wrote:
> Ok, from my reading of this horrible chunk of code it does the
> following:
> 	- if this is a isa based controller, then we check the region
> 	  that is to be used.
> 	- If it is already in use by someone else, then we skip it, and
> 	  move on to the next address.
> 	- If it is not in use, then we pass the address down to the chip
> 	  driver and let it try to find the chip at this address (it
> 	  will do the reserving of the address space on its own.)
> 
> So basically, check_region is pretty valid here, as we are trying to see
> if something else is already at this address, to try to prevent i2c
> drivers from stomping on each other.  I replaced this with a
> request_region()/release_region() pair to get rid of the compiler
> warning.
> 
> Is this your understanding too?  Or do you think we should just get rid
> of the request_region() check here all together?

Yes, either we should get rid of it or move claiming the address to
the i2c midlayer (not sure whether that's a good idea).  But an
opencoded check_region doesn't make any more sense than an explicit
one.  And you're also looking at the pointer it returned after it's
already invalid again..


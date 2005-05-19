From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: i2c-core driver-model simplified
Message-Id: <20031203223823.GA21063@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0311292347260.4386@cosmos.private>
In-Reply-To: <Pine.LNX.4.53.0311292347260.4386@cosmos.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 30, 2003 at 12:39:47AM +0200, Ky?sti M?lkki wrote:
> 
> In 2.6.0-test10 i2c-core maintains its own list of adapters and drivers.
> I think these are unneccessary as the generic driver-model maintains
> those too, and it can also detach/attach clients when necessary.
> 
> The resulting i2c-core does not yet compile nor work, and I have not yet
> reflected these changes to header file. But no changes in adapter or
> client code is required at this time.

Hm, in looking over this, I don't think it will work at all yet :)  Want
to post something that at least builds?  

> i2c-core driver-model
> 
> 	Attempt to fit i2c-core better with driver-model.

Reason I didn't fully convert i2c to the full driver model was I was
trying to incrementally update the i2c core and ran out of time before
the feature freeze of 2.6.  I do plan on finishing the whole job in 2.7,
unless someone else beats me to it.  There are a few things that need to
be added to the driver model core in order for this to fully work (think
of the i2c-dev driver for why...)

> patch-1
> 
> 	Remove list of adapters and drivers in i2c-core. Driver-model
> 	maintains these for us.

That's nice, but we still need to be able to iterate over them at times,
right?

> patch-2
> 
> 	No functional changes, just make it more readable by moving code
> 	here and there.

Hm, any size savings here?

Also, some of your documentation updates are nice, but why not use the
proper kernel-doc format in order to be able to pick these functions up
in the kernel-api documentation?

thanks,

greg k-h

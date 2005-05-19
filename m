From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: i2c-i810.c bus driver
Message-Id: <20030921064245.GA13860@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030915183026.GA11108@kroah.com>
In-Reply-To: <20030915183026.GA11108@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 20, 2003 at 05:07:54PM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2003-09-15 11:30:26 -0700]:
> > Ugh, in looking over the bus drivers that are currently in the cvs tree,
> > but not in the kernel tree, I ran accross this horrible bit of code in
> > the i2c-i810.c driver:
> > 
> > static unsigned char *mem;
> > 
> > static inline void outlong(unsigned int dat, int off)
> > {
> > 	*((unsigned int *) (mem + off)) = dat;
> > }
> > 
> > static inline unsigned int readlong(int off)
> > {
> > 	return *((unsigned int *) (mem + off));
> > }
> > 
> > Will someone please fix this up properly to not directly access memory!
> > That is not portable at all, and will do bad things on non-i386 based
> > hardware platforms.
> > 
> > After that's done, I'll worry about porting it to 2.6, but not before...
> 
> Is this what you want?  If so I'll update it (and the other two).
> Er, I'll get rid of the outlong/readlong indirection too...

Yes, this is the proper way to do things.

Thanks for looking into this and making the changes.

greg k-h

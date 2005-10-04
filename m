From: greg@kroah.com (Greg KH)
Date: Tue, 04 Oct 2005 23:51:51 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <20051004215003.GA16958@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 04, 2005 at 11:38:13PM +0200, Jean Delvare wrote:
> Hi Stig,
> 
> One preliminary question: Did you attempt to contact Hans Berglund or
> Oleg I. Vdovikin for their opinion on and testing of your patch?
> 
> > I have split the patch into two, annotated and signed off.  Patch 1 is 
> > the bug fixes.  Patch 2 is a bit of code cleanup.  Some of patch 2 you 
> > may think is not worth changing.  I have no problem with that.
> > 
> > On my system, the current elektor driver will oops on module load and 
> > has no chance of working because the IO regions are not mapped.  Patch 
> > 1 fixes it (for me).
> 
> Are you using mmapped=0 or 1? Wasn't it just a matter of using the
> other? I guess there is a reason why this option exists.
> 
> I don't really feel qualified to review the first patch, as I have
> relatively little idea how I/O mapping is supposed to work. Greg, want
> to comment? All the (relatively) recent changes to the driver are
> yours, although I'm not sure it actually means anything.

the iomap stuff looks good, did you run it through sparse to make sure
you got it all correct?

Also, all of the printk() and pr_debug() lines should be changed to use
dev_dbg(), dev_err() and friends.

thanks,

greg k-h

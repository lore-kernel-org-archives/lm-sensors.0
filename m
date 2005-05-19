From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: stub for driver testing (was Re: lm87 ported to Linux 2.6)
Message-Id: <20040824234432.GA13178@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040824034244.GA23169@jupiter.solarsys.private>
In-Reply-To: <20040824034244.GA23169@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 23, 2004 at 11:42:44PM -0400, Mark M. Hoffman wrote:
> Hi Jean:
> 
> (CCs trimmed on purpose)
> 
> * Jean Delvare <khali@linux-fr.org> [2004-08-23 21:52:06 +0200]:
> > This first patch is untested beyond compilation, as I don't own a LM87
> > myself. This is why I rely on you for testing. The more testers there
> 
> Attached is a quick hack that makes this (testing a driver for h/w you
> don't own) a little easier.  It would be even more useful if it wrote to
> a file instead of spamming all those printks - I'll do that if people
> want it.
> 
> You'll probably need to pass force_foo parameters to the chip driver to
> get it to attach. Also be warned: if the driver has any polling loops
> which wait for some byte/data to change, this bus stub could lock it up.
> 
> Stuff like this probably isn't appropriate for kernel.org (Greg?)

Why not?  It looks useful to me.  Care to send me a patch adding this to
the main kernel tree?

thanks,

greg k-h

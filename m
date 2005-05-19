From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <20030903234952.GB1578@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 31, 2003 at 05:27:30PM +0200, Jean Delvare wrote:
> 
> I noticed that new I2C drivers exist there: i2c-sibyte (plus
> i2c-algo-sibyte) and i2c-max1617. Why they end up there without us even
> hearing about it is a complete mystery to me. The max1617 driver is
> crappy (polling + working only with the sibyte bus) and completely
> useless since we already support that chip for years. The bus driver
> probably should have been built into a single module. And none of these
> modules will even compile since they use I2C IDs that are not defined.
> 
> My 2.4.22 patch simply wipe them out. I can't understand how they were
> accepted into the main kernel tree. I couldn't find anything related to
> them in the kernel changelog nor in LKML archives.

These all came in from the merge with the MIPS maintainer.  Bitkeeper is
nice :)

> I feel like we should complain about that, but unfortunately I don't
> have time for that right now. Greg, you have more contact with the
> kernel people than any of us here, do you have any information we
> don't have?

Why complain?  What is it hurting?  The cvs code sure isn't in the
kernel tree so what do we have to base our complaint on?  :)

So I'm guessing that some people with MIPS platforms actually use this
driver.  Good for them.  I would not recommend that your patches "wipe
them out" for that reason.

thanks,

greg k-h

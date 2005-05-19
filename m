From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030814211402.GA3640@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com> <20030802095518.4c5630ef.khali@linux-fr.org> <20030802165638.GF11038@kroah.com> <20030803052728.GC5202@earth.solarsys.private> <20030804160630.GB3395@kroah.com> <20030805034921.GB11605@earth.solarsys.private> <20030814051347.GB15093@earth.solarsys.private>
In-Reply-To: <20030814051347.GB15093@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

On Thu, Aug 14, 2003 at 01:13:47AM -0400, Mark M. Hoffman wrote:
> This is a resend of a patch to the i2c-nforce2.c I2C bus driver.
> The start of the relevant thread was here:
> http://archives.andrew.net.au/lm-sensors/msg03820.html
> 
> [comment]
> This patch restores a line that was wrongly removed.  There are also some
> trivial cleanups.  It applies & compiles vs. 2.6.0-test3.  It's untested
> (no hardware here).
> [/comment]

Oops, sorry I forgot this one.  I've now applied it and will send it on
later to Linus.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] fix recently introduced race in IBM PPC4xx I2C driver
Message-Id: <20041022195515.GF24282@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10982315061975@kroah.com> <1098231506495@kroah.com> <20041020052108.GA14871@gate.ebshome.net> <20041020062633.GA16580@gate.ebshome.net>
In-Reply-To: <20041020062633.GA16580@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, Nishanth Aravamudan <nacc@us.ibm.com>

On Tue, Oct 19, 2004 at 11:26:33PM -0700, Eugene Surovegin wrote:
> On Tue, Oct 19, 2004 at 10:21:08PM -0700, Eugene Surovegin wrote:
> 
> [snip]
> 
> > It looks like this change added race I tried to avoid here.
> > 
> > This code is modeled after __wait_event_interruptible_timeout, where 
> > "prepare_to_wait" is done _before_ checking completion status. This 
> > change breaks this, e.g. if IRQ happens right after we check iic->sts, 
> > but before calling msleep_interruptible(). In this case we'll sleep 
> > much more than required (seconds instead of microseconds)
> > 
> > Greg, if my analysis is correct, please rollback this change.
> > 
> > Nishanth, I'd be nice if you CC'ed me with this patch, my e-mail is at 
> > the top of that source file.
> 
> Oh, well. I should have used wait_event_interruptible_timeout when I 
> ported this driver to 2.6.
> 
> This patch fixes recently introduced race and also cleans ups some 
> 2.4-ism.
> 
> Please, apply.

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: [PATCH 2.6] I2C/SMBus stub for driver testing
Message-Id: <20040908193749.GC6976@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040827031943.GJ3056@jupiter.solarsys.private>
In-Reply-To: <20040827031943.GJ3056@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 26, 2004 at 11:19:43PM -0400, Mark M. Hoffman wrote:
> Hi Greg:
> 
> * Greg KH <greg@kroah.com> [2004-08-24 16:44:32 -0700]:
> > > > Why not?  It looks useful to me.  Care to send me a patch adding 
> > > > this to the main kernel tree?
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2004-08-25 10:25:02 -0400]:
> > Later today, sure.
> 
> Well here it is, one day later because I really didn't want to do this
> with printk.  I spent some time looking around and relayfs seems like
> a good fit.  Do you think relayfs will ever get merged?  Meanwhile...

No, I don't think relayfs will ever get merged, although it is a nice
solution searching for a problem :)


Applied, thanks.

greg k-h

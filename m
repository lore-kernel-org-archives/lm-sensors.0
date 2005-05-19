From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:14 +0000
Subject: [PATCH 2.6] I2C/SMBus stub for driver testing
Message-Id: <20040909023114.GC3686@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040827031943.GJ3056@jupiter.solarsys.private>
In-Reply-To: <20040827031943.GJ3056@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

> On Thu, Aug 26, 2004 at 11:19:43PM -0400, Mark M. Hoffman wrote:
> > Well here it is, one day later because I really didn't want to do this
> > with printk.  I spent some time looking around and relayfs seems like
> > a good fit.  Do you think relayfs will ever get merged?  Meanwhile...

* Greg KH <greg@kroah.com> [2004-09-08 12:37:49 -0700]:
> No, I don't think relayfs will ever get merged, although it is a nice
> solution searching for a problem :)

I.e. I should use netlink for this?  But isn't netlink unreliable, at
least in theory?  Or do you have some other mechanism in mind?  I would
appreciate some advice...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

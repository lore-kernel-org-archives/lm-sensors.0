From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: [RFC PATCH] Add lm78 sensor chip support (2.5.70)
Message-Id: <20030614014747.GA19218@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030608223334.GC30962@earth.solarsys.private> <20030613231135.GE2258@kroah.com>
In-Reply-To: <20030613231135.GE2258@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

* Greg KH <greg@kroah.com> [2003-06-13 16:11:35 -0700]:
> On Sun, Jun 08, 2003 at 06:33:34PM -0400, Mark M. Hoffman wrote:
> > This patch vs. 2.5.70 adds support for LM78, LM78-J, and LM79 sensors
> > chips based on lm_sensors project CVS.  This works on one of my boards.
> 
> Do you want me to add this to the kernel tree?  Sorry I missed this in
> the last round of i2c patches I sent out.

I was hoping to get some feedback w.r.t. the conversion routines...
but I guess silence is consent.  Please pass this on in the next round.
No worries, btw.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

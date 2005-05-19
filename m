From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [RFC PATCH] Add lm78 sensor chip support (2.5.70)
Message-Id: <20030616184213.GE25585@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030608223334.GC30962@earth.solarsys.private>
In-Reply-To: <20030608223334.GC30962@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

On Sun, Jun 08, 2003 at 06:33:34PM -0400, Mark M. Hoffman wrote:
> This patch vs. 2.5.70 adds support for LM78, LM78-J, and LM79 sensors
> chips based on lm_sensors project CVS.  This works on one of my boards.
> 
> I want to draw attention to something I did with this driver by
> comparing it to it87.c in 2.5.70:
> 
> > #define IT87_INIT_TEMP_HIGH_1 600
> > #define IT87_INIT_TEMP_LOW_1  200
> 
> The hardware uses degrees C, and sysfs uses degrees C * 1000.  But
> these #defines are apparently in units of degrees C * 10.  This
> arbitrary intermediate representation bugs me.  And given the new 2.5
> sysfs standard, it's unnecessary.
> 
> In this patch for lm78, I rewrote the conversion routines in terms
> of the sysfs units - getting rid of the intermediate nonsense.  If
> there are no objections, I'm going to start passing patches to do
> this to the other sensor chip drivers in 2.5 as well.  It would be
> nice to get some help with this too... especially since I don't
> have all that hardware at hand to test the results.

Applied, thanks.

greg k-h

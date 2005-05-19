From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: [RFC PATCH] Add lm78 sensor chip support (2.5.70)
Message-Id: <20030613231135.GE2258@kroah.com>
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

Do you want me to add this to the kernel tree?  Sorry I missed this in
the last round of i2c patches I sent out.

thanks,

greg k-h

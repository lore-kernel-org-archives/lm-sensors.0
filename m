From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.6] sensors chip updates
Message-Id: <20031218000433.GE6258@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031216035219.GA1658@earth.solarsys.private>
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

On Mon, Dec 15, 2003 at 10:52:19PM -0500, Mark M. Hoffman wrote:
> Hi Greg:
> 
> The following are four patchsets for 2.6 which were either direct
> from or inspired by recent updates in the lm_sensors CVS.
> 
> These patches should be applied, in order, on top of your -test11
> megapatch [1].  Please queue these up for inclusion after 2.6.0.

Thanks, I've applied all 4 of these to my "after 2.6.0" i2c tree.

greg k-h

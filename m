From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 0/2] i2c: new sysfs class "hwmon"
Message-Id: <20050417220919.GG3178@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411044427.GA4963@jupiter.solarsys.private>
In-Reply-To: <20050411044427.GA4963@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 13, 2005 at 11:34:44AM -0500, Dmitry Torokhov wrote:
> 
> This of course depends on Greg adding support for nested classes to
> the driver code (how is it going, Greg?).

The locking code is still stewing in the -mm tree.  Once all of those
changes hit mainline, we can start adding new stuff like nested classes.

thanks,

greg k-h

From: Ben Hutchings <bhutchings@solarflare.com>
Date: Sat, 23 Nov 2013 16:48:10 +0000
Subject: Re: [lm-sensors] [PATCH 0/5] net: hwmon fixes
Message-Id: <1385225290.20467.73.camel@deadeye.wl.decadent.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Bruce Allan <bruce.w.allan@intel.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>, Don Skidmore <donald.c.skidmore@intel.com>, Greg Rose <gregory.v.rose@intel.com>, Nithin Nayak Sujir <nsujir@broadcom.com>, Michael Chan <mchan@broadcom.com>, e1000-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org

On Fri, 2013-11-22 at 22:07 -0800, Guenter Roeck wrote:
> The hwmon subsystem is used by various network drivers to report temperature
> sensor and other information. Unfortunately, its use is often not correct.
> Typical errors are that the mandatory name sysfs attribute is not created,
> that the temperature sensor index starts with 0 instead of 1, and/or that
> sysfs attributes are created after the hwmon device was created.

As it happens, I was just looking at what we do in sfc
(drivers/net/ethernet/sfc/mcdi_mon.c) and wondering why I made it create
the hwmon device before the attributes.  I think I avoided the other
bugs though.

Ben.

> The following sequence of patches fixes most of the problems.
> 
> The igb patches have been tested with real hardware; the others are compile
> tested only.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

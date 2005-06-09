From: greg@kroah.com (Greg KH)
Date: Thu, 09 Jun 2005 19:01:08 +0000
Subject: [lm-sensors] Re: More archs need to include hwmon/Kconfig
Message-Id: <20050609170045.GF9597@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050609185703.78784b2f.khali@linux-fr.org>
In-Reply-To: <20050609185703.78784b2f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 09, 2005 at 06:57:03PM +0200, Jean Delvare wrote:
> Hi Greg, Mark, all,
> 
> In 2.6.12-mm6-rc1 there is a fixup patch to have hwmon/Kconfig included
> on arch/sparc64:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/broken-out/gregkh-i2c-hwmon-02-sparc64-fix.patch
> 
> A quick search shows that arm and h3800 would need the same fix.
> 
> Additionally, until the hardware monitoring drivers are actually moved
> from drivers/i2c/chips to drivers/hwmon, hwmon/Kconfig should be
> included before i2c/Kconfig (not correct on sparc64 ATM). We will have
> to swap them when moving the drivers.
> 
> A replacement patch follows.

Hm, this is getting quite messy.

Mark, how about I just drop the hwmon patches from my tree right now,
until you respin them, fixing these issues up?

thanks,

greg k-h

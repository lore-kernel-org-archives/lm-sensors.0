From: greg@kroah.com (Greg KH)
Date: Fri, 03 Jun 2005 23:17:47 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
Message-Id: <20050603211722.GA8755@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 03, 2005 at 04:29:28PM -0400, BGardner@Wabtec.com wrote:
> 
> Please ignore the previous patch -- I had left out the Makefile and
> Kconfig changes.
> 
> This is a driver for the PCA9539, a 16 bit digital I/O chip.
> It uses the new i2c-sysfs interfaces.
> 
> Signed-off-by: Ben Gardner <bgardner@wabtec.com>
> 
> --- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/pca9539.c
> 1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.12-rc5-mm2-pca9539/drivers/i2c/chips/pca9539.c
> 2005-06-03 15:15:02.000000000 -0500

Hm, the patch is line-wrapped.  Care to try it again?

thanks,

greg k-h

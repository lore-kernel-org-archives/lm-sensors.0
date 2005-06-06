From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Mon, 06 Jun 2005 22:33:39 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier (retry 5
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C907FD685@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Attached (due to email line-wrapping problems) is an updated patch for
the Philips PCA9539.
I think this one is now ready for inclusion.

Thanks,
Ben

=
This is a driver for the PCA9539, a 16 bit digital I/O chip.
It uses the new i2c-sysfs interfaces.
The patch includes documentation.
It depends on the patch that renames "i2c-sysfs.h" to "hwmon-sysfs.h"

Signed-off-by: Ben Gardner <bgardner@wabtec.com>


From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Jul 2013 07:23:11 +0000
Subject: Re: [lm-sensors] [RESEND PATCH V1 9/9] hwmon: tmp102: expose to thermal fw via DT nodes
Message-Id: <20130718072311.GB11120@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
 <1374074248-31690-10-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1374074248-31690-10-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, wni@nvidia.com, l.stach@pengutronix.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>

On Wed, Jul 17, 2013 at 11:17:28AM -0400, Eduardo Valentin wrote:
> This patch adds to tmp102 temperature sensor the possibility
> to expose itself as thermal zone device, registered on the
> thermal framework.
> 
> The thermal zone is built only if a device tree node
> describing a thermal zone for this sensor is present
> inside the tmp102 DT node. Otherwise, the driver behavior
> will be the same.
> 
NACK, same reason as for the lm75 patch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

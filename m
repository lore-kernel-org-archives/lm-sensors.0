From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Jun 2013 15:43:10 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ina2xx) Add device tree support to pass the shunt resistor
Message-Id: <20130619154310.GA29516@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1371624620-14254-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1371624620-14254-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yuantian.Tang@freescale.com
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

On Wed, Jun 19, 2013 at 02:50:20PM +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Adding another way that is device tree to pass the shunt resistor
> value to driver except for platform data.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>

I noticed that of.h include was missing. No need to re-send; I added it myself.
Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

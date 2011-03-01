From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 01 Mar 2011 16:03:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 v5] hwmon: twl4030: Hwmon Driver for
Message-Id: <20110301160323.GA6983@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298986956-31255-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1298986956-31255-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 01, 2011 at 08:42:36AM -0500, Keerthy wrote:
> This driver exposes the sysfs nodes of the TWL4030 MADC module.
> All the voltage channel values are expressed in terms of mV. Channel 13
> and channel 14 are reserved. There are channels which represent
> temperature and current the output is represented by celcius
> and mA respectively.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

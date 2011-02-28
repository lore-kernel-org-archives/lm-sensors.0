From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 28 Feb 2011 01:03:07 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 v2] hwmon: twl4030: Hwmon Driver for
Message-Id: <20110228010306.GE2749@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org

Hi Keerthy,

On Thu, Feb 24, 2011 at 08:48:50PM +0530, Keerthy wrote:
> This driver exposes the sysfs nodes of the TWL4030 MADC module.
> All the voltage channel values are expressed in terms of mV. Channel 13
> and channel 14 are reserved. There are channels which represent
> temperature and current the output is represented by celcius
> and mA respectively.
It would make sense for me to carry both patches through the MFD tree, but
I'd like to get Guenter's ACK before pushing it upstream.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

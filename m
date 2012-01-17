From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 17 Jan 2012 15:24:34 +0000
Subject: Re: [lm-sensors] [PATCH 00/07] DA9052 patch series
Message-Id: <20120117152433.GA12653@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326806748.3542.338.camel@dhruva>
In-Reply-To: <1326806748.3542.338.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dajun <dajun.chen@diasemi.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, Jan 17, 2012 at 08:25:48AM -0500, Ashish Jangam wrote:
> The following patch series adds support for the features of Dialog Semiconductor
> DA9052/53 PMICs.
> 
> The DA9052/53 PMICs support many functionalities like GPIOs, regulators,
> power-supply, touchscreen, rtc, backlight, etc. So these patches are applicable
> to different sub-systems of the kernel separately.
> 
> This patch series adds support for RTC, HWMON, Watchdog, Touch screen interface,
> Backlight, LEDs and On-Key.
> 
> All of these patches depend on the MFD module for DA9052/53. There is no
> other interdependence of patches.
> 
> Ashish Jangam (7):
> 	[RTC]: RTC module of DA9052/53 PMICs with time and alarm support.
> 	[HWMON]: Support for ADC of DA9052/53 PMICs.
> 	[Watchdog]: Watchdog support for DA9052/53 PMICs.
> 	[Touchscreen]: Driver for touch screen interface of DA9052/53 PMICs.
> 	[Backlight]: Backlight module for DA9052/53 PMICs.
> 	[LEDS]: Support for DA9052/53 LEDs.
> 	[On-Key]: Support for DA9052/53 on-key.
> 
Where are the patches ? I see some of them on the kernel kernel mailing list,
but not the hwmon driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

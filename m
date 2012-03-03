From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Mar 2012 14:52:20 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: exynos4: Move thermal sensor driver to driver/mfd directory
Message-Id: <20120303145220.GA29335@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
 <1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
In-Reply-To: <1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Sat, Mar 03, 2012 at 06:06:05AM -0500, Amit Daniel Kachhap wrote:
> This movement is needed because the hwmon entries and corresponding
> sysfs interface is a duplicate of utilities already provided by
> driver/thermal/thermal_sys.c. The goal is to place it in mfd folder
> and add necessary calls to get the temperature information.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> ---
>  Documentation/hwmon/exynos4_tmu |   81 ------
>  Documentation/mfd/exynos4_tmu   |   81 ++++++
>  drivers/hwmon/Kconfig           |   10 -
>  drivers/hwmon/Makefile          |    1 -
>  drivers/hwmon/exynos4_tmu.c     |  514 ---------------------------------------
>  drivers/mfd/Kconfig             |   10 +
>  drivers/mfd/Makefile            |    1 +
>  drivers/mfd/exynos4_tmu.c       |  514 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 606 insertions(+), 606 deletions(-)
>  delete mode 100644 Documentation/hwmon/exynos4_tmu
>  create mode 100644 Documentation/mfd/exynos4_tmu
>  delete mode 100644 drivers/hwmon/exynos4_tmu.c
>  create mode 100644 drivers/mfd/exynos4_tmu.c
> 

You are just moving the driver from hwmon to mfd. It is still a hwmon driver
and registers itself as hwmon driver. That does not make sense. If you want it
as mfd driver, it should not register itself as hwmon driver. It might have sub-devices
which are thermal and/or hwmon devices in the respective trees, or it might just be
a thermal driver (which then registers itself as hwmon device automatically).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

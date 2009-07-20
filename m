From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Jul 2009 13:19:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware monitoring
Message-Id: <20090720151940.30bd38ca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1248090225-16387-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1248090225-16387-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>

On Mon, 20 Jul 2009 12:43:45 +0100, Mark Brown wrote:
> This driver provides reporting of the status supply voltage rails
> of the WM835x series of PMICs via the hwmon API.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This should address all the issues Jean raised:
>  - Add a brief document to the hwmon directory.
>  - Use full constant names as arguments for template macro.
>  - Use DIV_ROUND_CLOSEST()
>  - Set driver owner.
>  - Fix typos.
> 
> Thanks to Jonathan and Jean for their reviews.
> 
>  Documentation/hwmon/wm8350      |   26 +++++++
>  drivers/hwmon/Kconfig           |   10 +++
>  drivers/hwmon/Makefile          |    1 +
>  drivers/hwmon/wm8350-hwmon.c    |  151 +++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/wm8350-core.c       |    3 +
>  include/linux/mfd/wm8350/core.h |    6 ++
>  6 files changed, 197 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/wm8350
>  create mode 100644 drivers/hwmon/wm8350-hwmon.c

Good work.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

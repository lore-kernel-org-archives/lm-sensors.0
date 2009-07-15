From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Jul 2009 20:09:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware monitoring
Message-Id: <20090715220937.71823829@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Wed, 15 Jul 2009 16:29:22 +0100, Mark Brown wrote:
> This driver provides reporting of the status supply voltage rails
> of the WM835x series of PMICs via the hwmon API.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/hwmon/Kconfig           |   10 +++
>  drivers/hwmon/Makefile          |    1 +
>  drivers/hwmon/wm8350-hwmon.c    |  155 +++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/wm8350-core.c       |    3 +
>  include/linux/mfd/wm8350/core.h |    6 ++
>  5 files changed, 175 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/wm8350-hwmon.c

I'm pretty busy at the moment and normally I wouldn't go for a driver
review, but this one seems simple enough and as I recall, I owe you
one. So I'll review your code as my time permits, stay tuned.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

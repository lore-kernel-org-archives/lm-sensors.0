From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Aug 2011 18:58:59 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (pmbus/adm1275) Add support
Message-Id: <20110828205859.7d9d0faa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314375545-18335-5-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314375545-18335-5-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Aug 2011 09:19:05 -0700, Guenter Roeck wrote:
> ADM1276 is mostly compatible to ADM1275, with added support for input power
> measurement. Add support for it to the ADM1275 driver.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/adm1275   |   32 ++++++++++++---------
>  drivers/hwmon/pmbus/Kconfig   |    5 ++-
>  drivers/hwmon/pmbus/adm1275.c |   59 +++++++++++++++++++++++++++++++++++-----
>  3 files changed, 72 insertions(+), 24 deletions(-)
> (...)

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

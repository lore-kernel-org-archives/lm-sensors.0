From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Mar 2013 13:30:10 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (tmp401) Add support for TMP431
Message-Id: <20130325143010.45e87154@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364217035-7671-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1364217035-7671-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 25 Mar 2013 06:10:35 -0700, Guenter Roeck wrote:
> TMP431 is compatible to TMP401.
> 
> Also add support for additional I2C addresses supported by TMP411B
> and TMP411C.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Reject invalid address/chip combinations
> 
>  Documentation/hwmon/tmp401 |   16 ++++++++++------
>  drivers/hwmon/Kconfig      |    4 ++--
>  drivers/hwmon/tmp401.c     |   15 ++++++++++++---
>  3 files changed, 24 insertions(+), 11 deletions(-)
> (...)

Looks good, thanks.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

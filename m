From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Feb 2013 10:02:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] hwmon: Update my e-mail address in driver documentation
Message-Id: <20130226110254.109854ca@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361585975-5604-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361585975-5604-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 22 Feb 2013 18:19:29 -0800, Guenter Roeck wrote:
> Most of the hwmon driver documentation still listed my old invalid e-mail
> address. Fix it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/adm1275     |    2 +-
>  Documentation/hwmon/jc42        |    2 +-
>  Documentation/hwmon/lineage-pem |    2 +-
>  Documentation/hwmon/lm25066     |    2 +-
>  Documentation/hwmon/ltc2978     |    2 +-
>  Documentation/hwmon/ltc4261     |    2 +-
>  Documentation/hwmon/max16064    |    2 +-
>  Documentation/hwmon/max16065    |    2 +-
>  Documentation/hwmon/max34440    |    2 +-
>  Documentation/hwmon/max8688     |    2 +-
>  Documentation/hwmon/pmbus       |    2 +-
>  Documentation/hwmon/smm665      |    2 +-
>  Documentation/hwmon/ucd9000     |    2 +-
>  Documentation/hwmon/ucd9200     |    2 +-
>  Documentation/hwmon/zl6100      |    2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

If no already done, please consider fixing these as well:

drivers/i2c/muxes/i2c-mux-pca9541.c: * Author: Guenter Roeck <guenter.roeck@ericsson.com>
Documentation/i2c/busses/i2c-diolan-u2c:Author: Guenter Roeck <guenter.roeck@ericsson.com>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

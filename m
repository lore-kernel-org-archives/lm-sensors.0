From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Oct 2013 08:23:23 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm90) Add support for TI TMP451
Message-Id: <20131009102323.169965ff@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381297248-13375-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1381297248-13375-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Wed, 9 Oct 2013 13:40:48 +0800, Wei Ni wrote:
> TI TMP451 is mostly compatible with ADT7461, except for
> local temperature low byte and max conversion rate.
> Add support to the LM90 driver.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  Documentation/hwmon/lm90 |    6 ++++++
>  drivers/hwmon/lm90.c     |   45 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 43 insertions(+), 8 deletions(-)

If the lm90 driver supports and detects this chip then sensors-detect
should as well. I can do that for you if you provide a register dump of
your TMP451 chip (use the i2c-dev driver and i2cdump from the i2c-tools
package.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

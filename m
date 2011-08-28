From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Aug 2011 18:52:22 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (pmbus/adm1275) Add support
Message-Id: <20110828205222.4ad79c26@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314375545-18335-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314375545-18335-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Aug 2011 09:19:04 -0700, Guenter Roeck wrote:
> ADM1275 supports a second current limit, which can be configured as either lower
> or upper limit. Add support for it and report it as either lower or upper
> critical current limit.
> 
> Also replace error return code EINVAL for unsupported pages with ENXIO as this
> is more appropriate for the observed condition.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/adm1275   |    8 +++
>  drivers/hwmon/pmbus/adm1275.c |   95 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 96 insertions(+), 7 deletions(-)
> (...)

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

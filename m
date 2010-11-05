From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Nov 2010 02:59:33 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: applesmc: Dynamic creation of
Message-Id: <20101105025933.GE28308@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
 <1288511434-5662-7-git-send-email-rydberg@euromail.se>
In-Reply-To: <1288511434-5662-7-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Oct 31, 2010 at 03:50:32AM -0400, Henrik Rydberg wrote:
> With the dynamic temperature group in place, the setup of fans
> can be simplified. This patch sets up the fans dynamically, removing
> a hundred lines of code.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Hi Henrik,

just one minor comment.

> ---
>  drivers/hwmon/applesmc.c |  188 +++++++++++-----------------------------------
>  1 files changed, 43 insertions(+), 145 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index abbff0b..4ba20ec 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
[ ... ]

>  static int applesmc_init_smcreg_try(void)
>  {
>         struct applesmc_registers *s = &smcreg;
> +       u8 tmp[4];

Why tmp[4] if you only read one byte ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

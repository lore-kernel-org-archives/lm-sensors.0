From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 18 Aug 2012 23:23:04 +0000
Subject: Re: [lm-sensors] [PATCH 14/31] sections: Fix section conflicts in drivers/hwmon
Message-Id: <20120818232304.GA19997@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1345311022-26328-1-git-send-email-andi@firstfloor.org>
 <1345311022-26328-15-git-send-email-andi@firstfloor.org>
In-Reply-To: <1345311022-26328-15-git-send-email-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, James.Bottomley@HansenPartnership.com, Andi Kleen <ak@linux.intel.com>, lm-sensors@lm-sensors.org

On Sat, Aug 18, 2012 at 10:30:05AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Applied.

Looks like you did not include maintainers and/or subject mailing lists in your
patch series, so I guess you won't get much feedback.

Guenter

> ---
>  drivers/hwmon/coretemp.c |    2 +-
>  drivers/hwmon/w83627hf.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index faa16f8..0fa356f 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -196,7 +196,7 @@ struct tjmax {
>  	int tjmax;
>  };
>  
> -static struct tjmax __cpuinitconst tjmax_table[] = {
> +static const struct tjmax __cpuinitconst tjmax_table[] = {
>  	{ "CPU D410", 100000 },
>  	{ "CPU D425", 100000 },
>  	{ "CPU D510", 100000 },
> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index ab48252..5b1a6a6 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> @@ -1206,7 +1206,7 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
>  	int err = -ENODEV;
>  	u16 val;
>  
> -	static const __initdata char *names[] = {
> +	static __initconst char *const names[] = {
>  		"W83627HF",
>  		"W83627THF",
>  		"W83697HF",
> -- 
> 1.7.7.6
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

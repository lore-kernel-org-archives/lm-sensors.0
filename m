From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Mar 2010 10:49:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Add missing newline to
Message-Id: <20100323114935.56f548b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100322214821.5352.15587.send-patch@aqua>
In-Reply-To: <20100322214821.5352.15587.send-patch@aqua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 22 Mar 2010 17:48:21 -0400, Dean Nelson wrote:
> Add missing newline to dev_warn() message string. This is more of an issue
> with older kernels that don't automatically add a newline if it was missing
> from the end of the previous line.
> 
> Signed-off-by: Dean Nelson <dnelson@redhat.com>
> Cc: <stable@kernel.org>
> 
> ---
> 
>  drivers/hwmon/coretemp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 2d7bcee..cb4290a 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -228,7 +228,7 @@ static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *
>  		if (err) {
>  			dev_warn(dev,
>  				 "Unable to access MSR 0xEE, for Tjmax, left"
> -				 " at default");
> +				 " at default\n");
>  		} else if (eax & 0x40000000) {
>  			tjmax = tjmax_ee;
>  		}

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

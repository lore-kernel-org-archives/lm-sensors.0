From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Jul 2006 19:05:18 +0000
Subject: [lm-sensors] [PATCH 1/13] [PATCH] i2c: Fix 'ignore' module
Message-Id: <20060725210518.cc28d64f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <11527468454006-git-send-email-greg@kroah.com>
In-Reply-To: <11527468454006-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> From: Mark M. Hoffman <mhoffman at lightlink.com>
> 
> This patch fixes a bug in the handling of 'ignore' module parameters of I2C
> client drivers.
> 
> Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
> Signed-off-by: Jean Delvare <khali at linux-fr.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
> ---
>  drivers/i2c/i2c-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a45155f..9cb277d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -756,9 +756,9 @@ int i2c_probe(struct i2c_adapter *adapte
>  					"parameter for adapter %d, "
>  					"addr 0x%02x\n", adap_id,
>  					address_data->ignore[j + 1]);
> +				ignore = 1;
> +				break;
>  			}
> -			ignore = 1;
> -			break;
>  		}
>  		if (ignore)
>  			continue;

I am wondering, do we want to put this fix in 2.6.17.y (and 2.6.16.y)?
It is a regression, it affects virtually every i2c chip driver and the
fix is straightforward, but OTOH it has been broken since 2.6.14-rc1 (10
months ago) and nobody ever complained. Opinion anyone?

Thanks,
-- 
Jean Delvare


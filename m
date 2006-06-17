From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 17 Jun 2006 20:31:56 +0000
Subject: [lm-sensors] [PATCH 2.6.17-rc5] I2C: fix 'ignore' module
Message-Id: <20060617223156.534ac3fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060617124829.GF27429@jupiter.solarsys.private>
In-Reply-To: <20060617124829.GF27429@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> This patch fixes a bug in the handling of 'ignore' module parameters of I2C
> client drivers.
> 
> Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
> 
> --- linux-2.6.17-rc5-kdb.orig/drivers/i2c/i2c-core.c
> +++ linux-2.6.17-rc5-kdb/drivers/i2c/i2c-core.c
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
> 

Oops, it seems I screwed up when rewriting i2c_probe 10 months ago.
Thanks a lot for catching this, I've applied your patch.

-- 
Jean Delvare


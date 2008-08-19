From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Aug 2008 18:06:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Fix masking of config register
Message-Id: <20080819200619.3ab05861@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080819150156.GH7908@solarflare.com>
In-Reply-To: <20080819150156.GH7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Tue, 19 Aug 2008 16:01:57 +0100, Ben Hutchings wrote:
> lm87_init_client() does:
> 
> 	if ((config & 0x81) != 0x01) {
> 		/* Start monitoring */
> 		lm87_write_value(client, LM87_REG_CONFIG,
> 				 (config & 0xF7) | 0x01);
> 	}
> 
> This means that if the Start bit is clear or the Initialization bit is
> set we set the Start bit and clear the INT#_Clear bit.  I think this
> should actually clear the Initialization bit and that 0xF7 is a typo
> for 0x7F.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  drivers/hwmon/lm87.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> index 21970f0..ddad6fc 100644
> --- a/drivers/hwmon/lm87.c
> +++ b/drivers/hwmon/lm87.c
> @@ -870,7 +870,7 @@ static void lm87_init_client(struct i2c_client *client)
>  	if ((config & 0x81) != 0x01) {
>  		/* Start monitoring */
>  		lm87_write_value(client, LM87_REG_CONFIG,
> -				 (config & 0xF7) | 0x01);
> +				 (config & ~0x80) | 0x01);
>  	}
>  }
>  

I agree that the current code is incorrect, but I disagree with your
analysis (I don't think the 0xF7 is a typo) and the proposed fix.

First of all, checking for bit 7 (Initialization) doesn't make sense.
This bit self-clears, so we're never going to see it set.

Secondly, clearing bit 3 (INT#_Clear) is a good idea. According to the
datasheet, monitoring is stopped while this bit is set, and it is set
by default. So we really want to clear it as part of the
initialization. Meaning that we also want to check if it is set.

So I would change the code as follows:

	if ((config & 0x09) != 0x01) {
		/* Start monitoring */
		lm87_write_value(client, LM87_REG_CONFIG,
				 (config & 0x77) | 0x01);
	}

What do you think?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

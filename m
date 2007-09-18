From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Sep 2007 21:45:56 +0000
Subject: Re: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <20070918234556.5a2a5a73@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Mon, 17 Sep 2007 13:50:24 -0700, David Brownell wrote:
> When "i2cdetect -F" says "SMBus PEC", it's extremely misleading.  The
> issue is whether or not PEC has *HARDWARE* support, not whether PEC
> itself is supported.  (PEC is portably implemented in software.)
> 
> --- lm_sensors-2.10.4.orig/prog/detect/i2cdetect.c
> +++ lm_sensors-2.10.4/prog/detect/i2cdetect.c
> @@ -147,7 +147,7 @@ static const struct func all_func[] = {
>  	{ .value = I2C_FUNC_SMBUS_BLOCK_PROC_CALL,
>  	  .name = "SMBus Block Process Call" },
>  	{ .value = I2C_FUNC_SMBUS_HWPEC_CALC,
> -	  .name = "SMBus PEC" },
> +	  .name = "SMBus PEC in Hardware" },
>  	{ .value = I2C_FUNC_SMBUS_WRITE_I2C_BLOCK,
>  	  .name = "I2C Block Write" },
>  	{ .value = I2C_FUNC_SMBUS_READ_I2C_BLOCK,

I agree that the current situation is confusing, I had noticed this
already when reworking the PEC support in 2.6.15, but postponed fixing
it.

However, I don't think that what you proposed is the proper fix. We
don't care whether PEC is implemented in hardware or software. What
really matters is whether it is implemented at all, or not. So I'd
rather rename I2C_FUNC_SMBUS_HWPEC_CALC to I2C_FUNC_SMBUS_PEC, and have
i2c-algo-bit and other drivers declare that they support it. What do
you think?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

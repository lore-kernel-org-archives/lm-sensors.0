From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 19 Aug 2013 02:44:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) Use devm_regulator_get_optional()
Message-Id: <52118697.5030102@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1376844227-30352-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1376844227-30352-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/18/2013 09:43 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Since the sht15 driver supports operation without an external vref
> regulator the driver should use the new devm_regulator_get_optional() to
> indicate that a stub regulator should not be provided.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> Since devm_regulator_get_optional() is not yet merged either the branch
> adding it would need be be merged into the hwmon tree or I'd need to
> apply this to the regualtor tree.
>

Please take it through the regulator tree; that seems to be easier.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

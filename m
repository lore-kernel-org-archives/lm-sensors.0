From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2013 12:35:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (ntc_thermistor): Fix sparse warnings
Message-Id: <20130219133552.5a7ddd8a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361266654-25960-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1361266654-25960-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Feb 2013 15:07:34 +0530, Sachin Kamat wrote:
> Fixes the following sparse warnings:
> drivers/hwmon/ntc_thermistor.c:46:31: warning:
> symbol 'ncpXXwb473' was not declared. Should it be static?
> drivers/hwmon/ntc_thermistor.c:82:31: warning:
> symbol 'ncpXXwl333' was not declared. Should it be static?
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Jean Delvare <khali@linux-fr.org>

Guenter, it happens that I have exactly 0 patches in my hwmon queue for
kernel 3.9. So I'll skip my turn on this one and let you handle all the
hwmon patches which should go in 3.9.

> ---
>  drivers/hwmon/ntc_thermistor.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index a87eb89..b5f63f9 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -43,7 +43,7 @@ struct ntc_compensation {
>   * The following compensation tables are from the specification of Murata NTC
>   * Thermistors Datasheet
>   */
> -const struct ntc_compensation ncpXXwb473[] = {
> +static const struct ntc_compensation ncpXXwb473[] = {
>  	{ .temp_C	= -40, .ohm	= 1747920 },
>  	{ .temp_C	= -35, .ohm	= 1245428 },
>  	{ .temp_C	= -30, .ohm	= 898485 },
> @@ -79,7 +79,7 @@ const struct ntc_compensation ncpXXwb473[] = {
>  	{ .temp_C	= 120, .ohm	= 1615 },
>  	{ .temp_C	= 125, .ohm	= 1406 },
>  };
> -const struct ntc_compensation ncpXXwl333[] = {
> +static const struct ntc_compensation ncpXXwl333[] = {
>  	{ .temp_C	= -40, .ohm	= 1610154 },
>  	{ .temp_C	= -35, .ohm	= 1130850 },
>  	{ .temp_C	= -30, .ohm	= 802609 },


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

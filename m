From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Aug 2013 15:27:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (asus_atk0110) Fix incorrect placement of __initconst
Message-Id: <20130827152741.GA15030@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1376299240-26943-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376299240-26943-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 12, 2013 at 02:50:40PM +0530, Sachin Kamat wrote:
> __initconst should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Luca Tettamanti <kronos.it@gmail.com>
> ---
>  drivers/hwmon/asus_atk0110.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index b25c643..9ddadb3 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -29,7 +29,7 @@ static bool new_if;
>  module_param(new_if, bool, 0);
>  MODULE_PARM_DESC(new_if, "Override detection heuristic and force the use of the new ATK0110 interface");
>  
> -static const struct dmi_system_id __initconst atk_force_new_if[] = {
> +static const struct dmi_system_id atk_force_new_if[] __initconst = {
>  	{
>  		/* Old interface has broken MCH temp monitoring */
>  		.ident = "Asus Sabertooth X58",

Based on the other discussion we just had, this patch is unnecessary.
I will therefore drop it from my queue.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

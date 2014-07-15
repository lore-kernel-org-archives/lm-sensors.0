From: George Joseph <george.joseph@fairview5.com>
Date: Tue, 15 Jul 2014 14:18:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asc7621) Make map tables const
Message-Id: <CAHKv19BgOwS9m4KQZ08qXQWOXVKP3F9X1XUJzXdfi26M7Ajsgg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405422901.4744.1.camel@phoenix>
In-Reply-To: <1405422901.4744.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 15, 2014 at 5:15 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: George Joseph <george.joseph@fairview5.com>

> ---
>  drivers/hwmon/asc7621.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
> index 7146368..c77644d 100644
> --- a/drivers/hwmon/asc7621.c
> +++ b/drivers/hwmon/asc7621.c
> @@ -300,7 +300,7 @@ static ssize_t store_fan16(struct device *dev,
>   * respectively. That doesn't mean that's what the motherboard provides. :)
>   */
>
> -static int asc7621_in_scaling[] = {
> +static const int asc7621_in_scaling[] = {
>         2500, 2250, 3300, 5000, 12000
>  };
>
> @@ -451,7 +451,7 @@ static ssize_t store_temp62(struct device *dev,
>   * hwmon specs, we synthesize the auto_point_2 from them.
>   */
>
> -static u32 asc7621_range_map[] = {
> +static const u32 asc7621_range_map[] = {
>         2000, 2500, 3330, 4000, 5000, 6670, 8000, 10000,
>         13330, 16000, 20000, 26670, 32000, 40000, 53330, 80000,
>  };
> @@ -512,7 +512,7 @@ static ssize_t show_pwm_ac(struct device *dev,
>  {
>         SETUP_SHOW_DATA_PARAM(dev, attr);
>         u8 config, altbit, regval;
> -       u8 map[] = {
> +       const u8 map[] = {
>                 0x01, 0x02, 0x04, 0x1f, 0x00, 0x06, 0x07, 0x10,
>                 0x08, 0x0f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f
>         };
> @@ -533,7 +533,7 @@ static ssize_t store_pwm_ac(struct device *dev,
>         SETUP_STORE_DATA_PARAM(dev, attr);
>         unsigned long reqval;
>         u8 currval, config, altbit, newval;
> -       u16 map[] = {
> +       const u16 map[] = {
>                 0x04, 0x00, 0x01, 0xff, 0x02, 0xff, 0x05, 0x06,
>                 0x08, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0f,
>                 0x07, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> @@ -651,7 +651,7 @@ static ssize_t store_pwm_enable(struct device *dev,
>         return count;
>  }
>
> -static u32 asc7621_pwm_freq_map[] = {
> +static const u32 asc7621_pwm_freq_map[] = {
>         10, 15, 23, 30, 38, 47, 62, 94,
>         23000, 24000, 25000, 26000, 27000, 28000, 29000, 30000
>  };
> @@ -700,7 +700,7 @@ static ssize_t store_pwm_freq(struct device *dev,
>         return count;
>  }
>
> -static u32 asc7621_pwm_auto_spinup_map[] =  {
> +static const u32 asc7621_pwm_auto_spinup_map[] =  {
>         0, 100, 250, 400, 700, 1000, 2000, 4000
>  };
>
> @@ -749,7 +749,7 @@ static ssize_t store_pwm_ast(struct device *dev,
>         return count;
>  }
>
> -static u32 asc7621_temp_smoothing_time_map[] = {
> +static const u32 asc7621_temp_smoothing_time_map[] = {
>         35000, 17600, 11800, 7000, 4400, 3000, 1600, 800
>  };
>
> --
> 1.9.1
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

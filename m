From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 24 Mar 2011 08:13:35 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (f71882fg) Per-chip
Message-Id: <4D8AFD2F.7040501@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110324033356.GB15395@ericsson.com>
In-Reply-To: <20110324033356.GB15395@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

This one I like too :)

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



On 03/23/2011 09:48 PM, Jean Delvare wrote:
> Use tables to list the count of fan and temperature inputs for all
> supported chips, almost similar to (but more simple than) what is
> already done for voltage inputs. This avoids repeating the same tests
> in different functions, and will make it easier to add support for
> chips with a different count of fan or temperature inputs.
>
> Signed-off-by: Jean Delvare<khali@linux-fr.org>
> Cc: Hans de Goede<hdegoede@redhat.com>
> ---
> Hans, I think this should make adding support for the F81865 easier.
> And it even makes the binary slightly smaller on x86-64. What do you
> think?
>
>   drivers/hwmon/f71882fg.c |   36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
>
> --- linux-2.6.39-rc0.orig/drivers/hwmon/f71882fg.c	2011-03-23 14:53:29.000000000 +0100
> +++ linux-2.6.39-rc0/drivers/hwmon/f71882fg.c	2011-03-23 18:58:55.000000000 +0100
> @@ -152,6 +152,28 @@ static const char f71882fg_has_beep[8] >   	[f8000]		= 0,
>   };
>
> +static const char f71882fg_nr_fans[8] = {
> +	[f71808e]	= 3,
> +	[f71858fg]	= 3,
> +	[f71862fg]	= 3,
> +	[f71869]	= 3,
> +	[f71882fg]	= 4,
> +	[f71889fg]	= 3,
> +	[f71889ed]	= 3,
> +	[f8000]		= 3,
> +};
> +
> +static const char f71882fg_nr_temps[8] = {
> +	[f71808e]	= 2,
> +	[f71858fg]	= 3,
> +	[f71862fg]	= 3,
> +	[f71869]	= 3,
> +	[f71882fg]	= 3,
> +	[f71889fg]	= 3,
> +	[f71889ed]	= 3,
> +	[f8000]		= 3,
> +};
> +
>   static struct platform_device *f71882fg_pdev;
>
>   /* Super-I/O Function prototypes */
> @@ -1071,9 +1093,9 @@ static u16 f71882fg_read_temp(struct f71
>   static struct f71882fg_data *f71882fg_update_device(struct device *dev)
>   {
>   	struct f71882fg_data *data = dev_get_drvdata(dev);
> +	int nr_fans = f71882fg_nr_fans[data->type];
> +	int nr_temps = f71882fg_nr_temps[data->type];
>   	int nr, reg, point;
> -	int nr_fans = (data->type = f71882fg) ? 4 : 3;
> -	int nr_temps = (data->type = f71808e) ? 2 : 3;
>
>   	mutex_lock(&data->update_lock);
>
> @@ -2042,8 +2064,9 @@ static int __devinit f71882fg_probe(stru
>   {
>   	struct f71882fg_data *data;
>   	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
> -	int err, i, nr_fans = (sio_data->type = f71882fg) ? 4 : 3;
> -	int nr_temps = (sio_data->type = f71808e) ? 2 : 3;
> +	int nr_fans = f71882fg_nr_fans[sio_data->type];
> +	int nr_temps = f71882fg_nr_temps[sio_data->type];
> +	int err, i;
>   	u8 start_reg, reg;
>
>   	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
> @@ -2276,8 +2299,9 @@ exit_free:
>   static int f71882fg_remove(struct platform_device *pdev)
>   {
>   	struct f71882fg_data *data = platform_get_drvdata(pdev);
> -	int i, nr_fans = (data->type = f71882fg) ? 4 : 3;
> -	int nr_temps = (data->type = f71808e) ? 2 : 3;
> +	int nr_fans = f71882fg_nr_fans[data->type];
> +	int nr_temps = f71882fg_nr_temps[data->type];
> +	int i;
>   	u8 start_reg = f71882fg_read8(data, F71882FG_REG_START);
>
>   	if (data->hwmon_dev)
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

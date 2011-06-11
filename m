From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jun 2011 10:40:10 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (asus_atk0110) Consolidate sysfs
Message-Id: <20110611124010.77e90b50@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 May 2011 15:36:17 -0700, Guenter Roeck wrote:
> Call sysfs_attr_init() from atk_init_attribute() to handle sysfs attribute
> initialization in a single function.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Luca Tettamanti <kronos.it@gmail.com>
> ---
>  drivers/hwmon/asus_atk0110.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)

Nice clean-up.

Acked-by: Jean Delvare <khali@linux-fr.org>

> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index b5e8920..dcb78a7 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -268,6 +268,7 @@ static struct device_attribute atk_name_attr >  static void atk_init_attribute(struct device_attribute *attr, char *name,
>  		sysfs_show_func show)
>  {
> +	sysfs_attr_init(&attr->attr);
>  	attr->attr.name = name;
>  	attr->attr.mode = 0444;
>  	attr->show = show;
> @@ -1188,19 +1189,15 @@ static int atk_create_files(struct atk_data *data)
>  	int err;
>  
>  	list_for_each_entry(s, &data->sensor_list, list) {
> -		sysfs_attr_init(&s->input_attr.attr);
>  		err = device_create_file(data->hwmon_dev, &s->input_attr);
>  		if (err)
>  			return err;
> -		sysfs_attr_init(&s->label_attr.attr);
>  		err = device_create_file(data->hwmon_dev, &s->label_attr);
>  		if (err)
>  			return err;
> -		sysfs_attr_init(&s->limit1_attr.attr);
>  		err = device_create_file(data->hwmon_dev, &s->limit1_attr);
>  		if (err)
>  			return err;
> -		sysfs_attr_init(&s->limit2_attr.attr);
>  		err = device_create_file(data->hwmon_dev, &s->limit2_attr);
>  		if (err)
>  			return err;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

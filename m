From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Mon, 04 Aug 2014 05:58:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ibmpowernv) Use of_property_read_u32 at appropriate place
Message-Id: <53DF1FF1.9@linux.vnet.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406867927.25393.1.camel@phoenix>
In-Reply-To: <1406867927.25393.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 08/01/2014 10:08 AM, Axel Lin wrote:
> Simplify the code a bit and also improve readability.

Verified the patch in my test environment and it works fine.

Thanks,
- Neelesh

>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/hwmon/ibmpowernv.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index e6b652a..d2bf2c9 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -227,7 +227,7 @@ static int __init create_device_attrs(struct platform_device *pdev)
>   	const struct attribute_group **pgroups = pdata->attr_groups;
>   	struct device_node *opal, *np;
>   	struct sensor_data *sdata;
> -	const __be32 *sensor_id;
> +	u32 sensor_id;
>   	enum sensors type;
>   	u32 count = 0;
>   	int err = 0;
> @@ -252,15 +252,14 @@ static int __init create_device_attrs(struct platform_device *pdev)
>   		if (type = MAX_SENSOR_TYPE)
>   			continue;
>
> -		sensor_id = of_get_property(np, "sensor-id", NULL);
> -		if (!sensor_id) {
> +		if (of_property_read_u32(np, "sensor-id", &sensor_id)) {
>   			dev_info(&pdev->dev,
>   				 "'sensor-id' missing in the node '%s'\n",
>   				 np->name);
>   			continue;
>   		}
>
> -		sdata[count].id = be32_to_cpup(sensor_id);
> +		sdata[count].id = sensor_id;
>   		sdata[count].type = type;
>   		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
>   					     sdata[count].name);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

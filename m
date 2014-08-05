From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Aug 2014 02:49:23 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: (ads1015) Use of_property_read_u32 at appropriate places
Message-Id: <53E04633.2060807@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407204038.20206.1.camel@phoenix>
In-Reply-To: <1407204038.20206.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/04/2014 07:00 PM, Axel Lin wrote:
> Simplify the code a bit and also improve readability.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Hi Axel,

Unfortunately, this patch does not apply for me. Looks like your branch is missing
commit 56de1377 (hwmon: (ads1015) Fix off-by-one for valid channel index checking).
Can you rebase your branch to make sure it is included ? The above patch should
hopefully be in mainline in a day or so, but you should have it already (after all,
it is one of your patches ;-).

Thanks,
Guenter

> ---
>   drivers/hwmon/ads1015.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index 55030bd..b6c9fb4d 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -184,20 +184,18 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>   		return -EINVAL;
>
>   	for_each_child_of_node(client->dev.of_node, node) {
> -		const __be32 *property;
> -		int len;
> +		u32 pval;
>   		unsigned int channel;
>   		unsigned int pga = ADS1015_DEFAULT_PGA;
>   		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
>
> -		property = of_get_property(node, "reg", &len);
> -		if (!property || len != sizeof(int)) {
> +		if (of_property_read_u32(node, "reg", &pval)) {
>   			dev_err(&client->dev, "invalid reg on %s\n",
>   				node->full_name);
>   			continue;
>   		}
>
> -		channel = be32_to_cpup(property);
> +		channel = pval;
>   		if (channel > ADS1015_CHANNELS) {
>   			dev_err(&client->dev,
>   				"invalid channel index %d on %s\n",
> @@ -205,20 +203,17 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>   			continue;
>   		}
>
> -		property = of_get_property(node, "ti,gain", &len);
> -		if (property && len = sizeof(int)) {
> -			pga = be32_to_cpup(property);
> +		if (!of_property_read_u32(node, "ti,gain", &pval)) {
> +			pga = pval;
>   			if (pga > 6) {
> -				dev_err(&client->dev,
> -					"invalid gain on %s\n",
> +				dev_err(&client->dev, "invalid gain on %s\n",
>   					node->full_name);
>   				return -EINVAL;
>   			}
>   		}
>
> -		property = of_get_property(node, "ti,datarate", &len);
> -		if (property && len = sizeof(int)) {
> -			data_rate = be32_to_cpup(property);
> +		if (!of_property_read_u32(node, "ti,datarate", &pval)) {
> +			data_rate = pval;
>   			if (data_rate > 7) {
>   				dev_err(&client->dev,
>   					"invalid data_rate on %s\n",
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

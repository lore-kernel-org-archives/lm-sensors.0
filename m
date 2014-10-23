From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 23 Oct 2014 09:17:37 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (i5500_temp) Convert to use ATTRIBUTE_GROUPS macro
Message-Id: <20141023111737.61ab6923@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141021090917.2692f17b@endymion.delvare>
In-Reply-To: <20141021090917.2692f17b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Oct 2014 16:14:00 +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro to simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/i5500_temp.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/i5500_temp.c b/drivers/hwmon/i5500_temp.c
> index e19d5d7..7946603 100644
> --- a/drivers/hwmon/i5500_temp.c
> +++ b/drivers/hwmon/i5500_temp.c
> @@ -120,7 +120,7 @@ static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_thresh, NULL, 2);
>  static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
>  
> -static struct attribute *i5500_temp_attributes[] = {
> +static struct attribute *i5500_temp_attrs[] = {
>  	&dev_attr_temp1_input.attr,
>  	&sensor_dev_attr_temp1_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> @@ -130,14 +130,7 @@ static struct attribute *i5500_temp_attributes[] = {
>  	NULL
>  };
>  
> -static const struct attribute_group i5500_temp_group = {
> -	.attrs = i5500_temp_attributes,
> -};
> -
> -static const struct attribute_group *i5500_temp_groups[] = {
> -	&i5500_temp_group,
> -	NULL
> -};
> +ATTRIBUTE_GROUPS(i5500_temp);
>  
>  static const struct pci_device_id i5500_temp_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3438) },

Applied, thanks.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

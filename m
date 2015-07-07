From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Jul 2015 20:43:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) Add pwmX_enable attribute
Message-Id: <559C39E0.3030203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436299360-25771-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436299360-25771-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Constantine,

On 07/07/2015 01:02 PM, Constantine Shulyupin wrote:
> Introduced REG_SMARTFAN_EN_BASE, pwmX_enable,
> show_pwm_enable, store_pwm_enable.
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index a0d9010..a53e6e1 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -53,6 +53,7 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
>   #define REG_PECI_ENABLE		0x23
>   #define REG_FAN_ENABLE		0x24
>   #define REG_VMON_ENABLE		0x25
> +#define REG_SMARTFAN_EN_BASE	0x64
>   #define REG_VENDOR_ID		0xfd
>   #define REG_CHIP_ID		0xfe
>   #define REG_VERSION_ID		0xff
> @@ -151,6 +152,43 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
>   	return err ? : count;
>   }
>
> +static ssize_t show_pwm_enable(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct nct7802_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> +	unsigned int reg, enabled, pwm;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, REG_SMARTFAN_EN_BASE + sattr->index / 2,
> +			  &reg);
> +	if (ret < 0)
> +		return ret;
> +	enabled = reg >> (sattr->index % 2 * 4) & 1;

While that works, I think it would be nicer to have something like

#define REG_SMARTFAN_EN(x)	(REG_SMARTFAN_EN_BASE + (x) / 2)
#define SMARTFAN_EN_SHIFT(x)	((x) % 2 * 4)

and then use those defines instead of hard-coding the expressions
multiple times. Actually, since REG_SMARTFAN_BASE is then only used
once, you could just make it

#define REG_SMARTFAN_EN(x)	(0x64 + (x) / 2)

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

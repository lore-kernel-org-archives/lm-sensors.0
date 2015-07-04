From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Jul 2015 18:04:27 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add pwm control
Message-Id: <5598202B.7010000@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436021854-13072-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436021854-13072-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Constantine,

On 07/04/2015 07:57 AM, Constantine Shulyupin wrote:
> Added fan output control registers.
> Modes of operation are PWM (default) and DC.
>
> Introduced show_pwm, store_pwm, nct7802_pwm_attrs, nct7802_pwm_group.
>
> ---
> Change log:
> Fixed in v2:
> - renamed fanX_output to pwmX
> - introduced nct7802_pwm_group and nct7802_pwm_attrs
> - renamed show_dec to show_pwd
> - used kstrtou8 instead kstrtouint
> Fixed in v3:
> - spilt functions declarations to fit 80 columns
> - removed unnecessary initializations
> - rearranged variable declarations
> - shortened return expression
> - renamed store_u8 to store_pwm
>
Looks good at first glance, but ...

> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index afa242d..6382d4d 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -102,6 +102,36 @@ static ssize_t store_temp_type(struct device *dev,
>   	return err ? : count;
>   }
>
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct nct7802_data *data = dev_get_drvdata(dev);
> +	unsigned int;

... it is always a good idea to at least compile test the code
after a change, as trivial as the change may appear to be.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

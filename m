From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 06 Aug 2014 02:33:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (dme1737) Prevent overflow problem when writing large limits
Message-Id: <53E193DD.7080305@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407283364.4924.0.camel@phoenix>
In-Reply-To: <1407283364.4924.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/05/2014 05:02 PM, Axel Lin wrote:
> On platforms with sizeof(int) < sizeof(long), writing a temperature
> limit larger than MAXINT will result in unpredictable limit values
> written to the chip. Avoid auto-conversion from long to int to fix
> the problem.
>
> Voltage limits, fan minimum speed, pwm frequency, pwm ramp rate, and
> other attributes have the same problem, fixes them as well.
>
> vrm is an u8, so the written value needs to be limited to [0, 255].
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

This driver has yet another problem: zone_low and zone_abs are declared
as u8 but written with TEMP_TO_REG, which returns a signed value.
The datasheet (for SCH111X which is supposedly compatible) suggests
that the temperatures should be signed.

No need to resubmit, I fixed it up. Applied.

Guenter

> ---
>   drivers/hwmon/dme1737.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> index 4ae3fff..71dd0f2 100644
> --- a/drivers/hwmon/dme1737.c
> +++ b/drivers/hwmon/dme1737.c
> @@ -277,7 +277,7 @@ static inline int IN_FROM_REG(int reg, int nominal, int res)
>   	return (reg * nominal + (3 << (res - 3))) / (3 << (res - 2));
>   }
>
> -static inline int IN_TO_REG(int val, int nominal)
> +static inline int IN_TO_REG(long val, int nominal)
>   {
>   	return clamp_val((val * 192 + nominal / 2) / nominal, 0, 255);
>   }
> @@ -293,7 +293,7 @@ static inline int TEMP_FROM_REG(int reg, int res)
>   	return (reg * 1000) >> (res - 8);
>   }
>
> -static inline int TEMP_TO_REG(int val)
> +static inline int TEMP_TO_REG(long val)
>   {
>   	return clamp_val((val < 0 ? val - 500 : val + 500) / 1000, -128, 127);
>   }
> @@ -308,7 +308,7 @@ static inline int TEMP_RANGE_FROM_REG(int reg)
>   	return TEMP_RANGE[(reg >> 4) & 0x0f];
>   }
>
> -static int TEMP_RANGE_TO_REG(int val, int reg)
> +static int TEMP_RANGE_TO_REG(long val, int reg)
>   {
>   	int i;
>
> @@ -331,7 +331,7 @@ static inline int TEMP_HYST_FROM_REG(int reg, int ix)
>   	return (((ix = 1) ? reg : reg >> 4) & 0x0f) * 1000;
>   }
>
> -static inline int TEMP_HYST_TO_REG(int val, int ix, int reg)
> +static inline int TEMP_HYST_TO_REG(long val, int ix, int reg)
>   {
>   	int hyst = clamp_val((val + 500) / 1000, 0, 15);
>
> @@ -347,7 +347,7 @@ static inline int FAN_FROM_REG(int reg, int tpc)
>   		return (reg = 0 || reg = 0xffff) ? 0 : 90000 * 60 / reg;
>   }
>
> -static inline int FAN_TO_REG(int val, int tpc)
> +static inline int FAN_TO_REG(long val, int tpc)
>   {
>   	if (tpc) {
>   		return clamp_val(val / tpc, 0, 0xffff);
> @@ -379,7 +379,7 @@ static inline int FAN_TYPE_FROM_REG(int reg)
>   	return (edge > 0) ? 1 << (edge - 1) : 0;
>   }
>
> -static inline int FAN_TYPE_TO_REG(int val, int reg)
> +static inline int FAN_TYPE_TO_REG(long val, int reg)
>   {
>   	int edge = (val = 4) ? 3 : val;
>
> @@ -402,7 +402,7 @@ static int FAN_MAX_FROM_REG(int reg)
>   	return 1000 + i * 500;
>   }
>
> -static int FAN_MAX_TO_REG(int val)
> +static int FAN_MAX_TO_REG(long val)
>   {
>   	int i;
>
> @@ -460,7 +460,7 @@ static inline int PWM_ACZ_FROM_REG(int reg)
>   	return acz[(reg >> 5) & 0x07];
>   }
>
> -static inline int PWM_ACZ_TO_REG(int val, int reg)
> +static inline int PWM_ACZ_TO_REG(long val, int reg)
>   {
>   	int acz = (val = 4) ? 2 : val - 1;
>
> @@ -476,7 +476,7 @@ static inline int PWM_FREQ_FROM_REG(int reg)
>   	return PWM_FREQ[reg & 0x0f];
>   }
>
> -static int PWM_FREQ_TO_REG(int val, int reg)
> +static int PWM_FREQ_TO_REG(long val, int reg)
>   {
>   	int i;
>
> @@ -510,7 +510,7 @@ static inline int PWM_RR_FROM_REG(int reg, int ix)
>   	return (rr & 0x08) ? PWM_RR[rr & 0x07] : 0;
>   }
>
> -static int PWM_RR_TO_REG(int val, int ix, int reg)
> +static int PWM_RR_TO_REG(long val, int ix, int reg)
>   {
>   	int i;
>
> @@ -528,7 +528,7 @@ static inline int PWM_RR_EN_FROM_REG(int reg, int ix)
>   	return PWM_RR_FROM_REG(reg, ix) ? 1 : 0;
>   }
>
> -static inline int PWM_RR_EN_TO_REG(int val, int ix, int reg)
> +static inline int PWM_RR_EN_TO_REG(long val, int ix, int reg)
>   {
>   	int en = (ix = 1) ? 0x80 : 0x08;
>
> @@ -1481,13 +1481,16 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
>   		       const char *buf, size_t count)
>   {
>   	struct dme1737_data *data = dev_get_drvdata(dev);
> -	long val;
> +	unsigned long val;
>   	int err;
>
> -	err = kstrtol(buf, 10, &val);
> +	err = kstrtoul(buf, 10, &val);
>   	if (err)
>   		return err;
>
> +	if (val > 255)
> +		return -EINVAL;
> +
>   	data->vrm = val;
>   	return count;
>   }
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Dec 2006 14:09:35 +0000
Subject: [lm-sensors] [PATCH] ad7418 driver
Message-Id: <20061224150935.a8327a03.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061112153724.3e630d32@inspiron>
In-Reply-To: <20061112153724.3e630d32@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ah, one more thing...

On Sun, 12 Nov 2006 15:37:24 +0100, Alessandro Zummo wrote:
> +#define show_adc(value)	\
> +static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
> +{								\
> +	struct ad7418_data *data = ad7418_update_device(dev);	\
> +	return sprintf(buf, "%d\n", data->value >> 6);		\
> +}

Here you return (almost) the raw register value, while the sysfs
interface standard says you must export the value in mV. According to
the datasheet, the ADC LSB is VREF/1024 with VREF = 2.5V, so you'd need
to return:
  ((data->value >> 6) * 2500 + 512) / 1024

-- 
Jean Delvare


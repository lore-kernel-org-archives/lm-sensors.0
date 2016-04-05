From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Apr 2016 16:02:31 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (max31722) Add threshold alarm support
Message-Id: <20160405160231.GA27196@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1459860813-25435-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1459860813-25435-1-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 05, 2016 at 03:53:33PM +0300, Tiberiu Breana wrote:
> Add threshold alarm support for the max31722 temperature sensor driver.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> ---
[ ... ]
> +
> +	/*
> +	 * Do a quick temperature reading and compare it with TLOW/THIGH
> +	 * so we can tell which threshold has been met.
> +	 */
> +	ret = spi_w8r16(data->spi_device, MAX31722_REG_TEMP_LSB);
> +	if (ret < 0)
> +		goto exit_err;
> +	temp = (s16)(le16_to_cpu(ret) * 125 / 32);

Another comment: No need to convert values to milli-degrees here.
Just use raw register values.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

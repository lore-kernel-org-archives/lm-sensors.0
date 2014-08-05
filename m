From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Aug 2014 02:42:01 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (ads1015) Fix out-of-bounds array access
Message-Id: <53E04479.40102@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407203989.20206.0.camel@phoenix>
In-Reply-To: <1407203989.20206.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/04/2014 06:59 PM, Axel Lin wrote:
> Current code uses data_rate as array index in ads1015_read_adc() and uses pga
> as array index in ads1015_reg_to_mv, so we must make sure both data_rate and
> pga settings are in valid value range.
> Return -EINVAL if the setting is out-of-range.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

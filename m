From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 May 2015 22:47:35 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: ntc: use iio_read_channel_processed if possible
Message-Id: <5568EC87.3020104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432821471-17373-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1432821471-17373-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/28/2015 06:57 AM, Chris Lesiak wrote:
> The function ntc_adc_iio_read (now ntc_adc_iio_read_raw) assumes
> both a 12 bit ADC and that pullup_uv is the same as the ADC reference
> voltage.  If either assumption is false, then the result is incorrect.
>
> For iio channels supporting either IIO_CHAN_INFO_PROCESSED or
> IIO_CHAN_INFO_SCALE, the new ntc_adc_iio_read will be used.  It gets
> microvolts directly with a call to iio_read_channel_processed.
>
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>

Looks ok to me. Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

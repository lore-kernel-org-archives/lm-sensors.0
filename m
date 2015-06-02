From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Jun 2015 13:54:22 +0000
Subject: Re: [lm-sensors] [v3] hwmon: ntc: fix iio raw to microvolts conversion
Message-Id: <20150602135422.GA15547@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 01, 2015 at 11:27:37AM -0500, Chris Lesiak wrote:
> The function ntc_adc_iio_read was assuming both a 12 bit ADC and that
> pullup_uv is the same as the ADC reference voltage.  If either
> assumption is false, then the result is incorrect.
> 
> Attempt to use iio_convert_raw_to_processed to convert the raw value to
> microvolts.  It will fail for iio channels that don't support support
> IIO_CHAN_INFO_SCALE; in that case fall back to the assumptions.
> 
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

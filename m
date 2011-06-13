From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Jun 2011 17:06:15 +0000
Subject: Re: [lm-sensors] [PATCH v6] drivers/hwmon NTC Thermistor Initial
Message-Id: <20110613170615.GB2629@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307949359-27587-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1307949359-27587-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 13, 2011 at 03:15:59AM -0400, Donggeun Kim wrote:
> This patch adds support for NTC Thermistor series. In this release, the
> following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
> and NCP15WL333. This driver is based on the datasheet of MURATA.
> 
> The driver in the patch does conversion from the raw ADC value
> (either voltage or resistence) to temperature. In order to use
> voltage values as input, the circuit schematics should be provided
> with the platform data. A compensation table for each type of thermistor
> is provided for the conversion.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.kim@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
> 
Hi folks,

Almost there.

[ ... ]

>  include/linux/ntc.h     |   53 ++++++

Please move this file to include/linux/platform_data/ntc.h.

One question, though: ntc.[ch] is quite high level and suggests a wider scope than just thermistors.
Would it make sense to use ntc_thermistor.[ch] instead ?

[ ... ]
> +       if ((data->mintemp != INT_MAX) || (data->maxtemp != INT_MIN)) {

The inner ( ) are unnecessary. Please remove.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

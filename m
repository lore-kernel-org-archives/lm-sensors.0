From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Jun 2011 18:39:17 +0000
Subject: Re: [lm-sensors] [PATCH v7] drivers/hwmon NTC Thermistor Initial
Message-Id: <20110614183917.GA7613@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308029766-3254-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308029766-3254-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 14, 2011 at 01:36:06AM -0400, Donggeun Kim wrote:
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
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
> 
Hi,

Test compile resulted in:

drivers/hwmon/ntc_thermistor.c: In function ‘get_temp_mC’:
drivers/hwmon/ntc_thermistor.c:174: warning: ‘mid’ may be used uninitialized in this function
drivers/hwmon/ntc_thermistor.c:174: note: ‘mid’ was declared here

Please fix.

Also, please make the following changes:

- In Documentation/hwmon/ntc-thermistor, please list correct prefix values.
- Please add EXPERIMENTAL Kconfig dependency.
- Please change MODULE_ALIAS to "platform:ntc-thermistor".

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

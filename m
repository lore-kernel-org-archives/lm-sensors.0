From: "Poddar, Sourav" <sourav.poddar@ti.com>
Date: Mon, 06 Aug 2012 07:47:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: tmp102: Add device tree support
Message-Id: <CAKdam54Zshr-d502E_AS+vw5+vLQnTBrAGRPTy-9-hZy1QEFbA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1343997350-676-1-git-send-email-sourav.poddar@ti.com>
	<501BE6B1.9000100@ti.com>
In-Reply-To: <501BE6B1.9000100@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benoit Cousson <b-cousson@ti.com>
Cc: khali@linux-fr.org, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Benoit,

On Fri, Aug 3, 2012 at 8:26 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Hi Sourav,
>
> On 08/03/2012 02:35 PM, Sourav Poddar wrote:
>> update tmp102 temperature sensor to also use device tree.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>>  drivers/hwmon/tmp102.c |   14 +++++++++++++-
>>  1 files changed, 13 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
>> index 0d466b9..a8a9060 100644
>> --- a/drivers/hwmon/tmp102.c
>> +++ b/drivers/hwmon/tmp102.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/err.h>
>>  #include <linux/mutex.h>
>>  #include <linux/device.h>
>> +#include <linux/of.h>
>>
>>  #define      DRIVER_NAME "tmp102"
>>
>> @@ -284,8 +285,19 @@ static const struct i2c_device_id tmp102_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(i2c, tmp102_id);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id temperature_dt_match[] = {
>> +     { .compatible = "ti,tmp102" },
>
> Are you sure this is needed for this device?
>
> There is an automatic binding done for I2C devices in the of_i2c core
> code. So in theory, DT will be able to bind to any I2C device using the
> already existing table: MODULE_DEVICE_TABLE(i2c, tmp102_id).
>
> So I think this patch should not be needed.
>
Indeed. Checked it just now, this patch is not required and the already
existing table is enough for the device to work fine.

Thanks for the information.

This patch is abandoned.
~Sourav
> Regards,
> Benoit
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

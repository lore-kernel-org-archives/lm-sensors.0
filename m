From: Chris <silverchris@gmail.com>
Date: Mon, 20 Feb 2012 21:59:24 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <CAO7tRnhKoRuYg73TbtA=FORstg44Ej0-SGE9=1VS-oWrBETQ2g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Patch to fix FAN_FROM_REG calculations
Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>
---

diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/max6639.c
b/drivers/hwmon/max6639.c
--- a/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
+++ b/drivers/hwmon/max6639.c	2012-02-20 16:36:02.553668023 -0500
@@ -72,8 +72,8 @@ static unsigned short normal_i2c[] = { 0

 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };

-#define FAN_FROM_REG(val, div, rpm_range)	((val) = 0 ? -1 : \
-	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / ((div + 1) * (val)))
+#define FAN_FROM_REG(val, rpm_range)	((val) = 0 ? -1 : \
+	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / val)
 #define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)

 /*
@@ -333,7 +333,7 @@ static ssize_t show_fan_input(struct dev
 		return PTR_ERR(data);

 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->ppr, data->rpm_range));
+		       data->rpm_range));
 }

 static ssize_t show_alarm(struct device *dev,


On Mon, Feb 20, 2012 at 1:58 PM, Roland Stigge <stigge@antcom.de> wrote:
> Hi!
>
> On 02/20/2012 06:39 PM, Guenter Roeck wrote:
>>> Please resubmit a (-p1) patch fixing the issue your originally spotted
>>> instead.
>>>
>> We really need input from Roland on the initialization problem.
>> Might make sense to kwwp him copied on this exchange.
>
> Thanks for your notification and sorry for the delay!
>
> Unfortunately, when I ported the driver from the other original author,
> I kept the initialization procedure which is obviously wrong, doing
> initialization only for one channel. (I adjusted the driver locally
> platform-dependent, so didn't find a chance for mainline integration and
> this way, the obvious problems in the mainline driver slipped.)
>
> Therefore, a fix for doing this for both channels, possibly in a loop,
> would be good, IMO.
>
> Jean's note about the broken variable initialization is correct. Should
> have done this differently.
>
> The other note about initialization only with platform_data is also a
> good idea.
>
> I'm using the chip on a custom ARM board without BIOS initialization,
> but providing platform_data in this case should be the correct way, anyway.
>
> So Chris, if you are already at it, do it this way. Otherwise please
> notify me and I can prepare patches.
>
> Thanks for your work!
>
> Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Fri, 24 Dec 2010 01:36:04 +0000
Subject: Re: [lm-sensors] [PATCH v3] drivers/hwmon NTC Thermistor Initial
Message-Id: <AANLkTini8wch++56r74PJ3MJ3iaBSm99KqCo3J+PSQv5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292842122-3992-1-git-send-email-myungjoo.ham@samsung.com>
In-Reply-To: <1292842122-3992-1-git-send-email-myungjoo.ham@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 24, 2010 at 5:34 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>

(snip)

>> +config SENSORS_NTC_THERMISTOR
>
> Should be in alphabetic order, ie before SENSORS_PC87360.
>

(snip)

>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Text does not provide value. Please remove.
>

(snip)

>
> Please add text showing module name if built as module.
>

(sinp)

> Please put in alphabetic order (before PC87360).
>

(snip)

>
> Still not returning an error.
>

(snip)

>
> Still not returning an error.
>

Those will be done at the next patch. Thanks.

>> +       return INT_MIN;
>> +}
>> +
>> +int ntc_thermistor_read(struct device *dev)
>> +{
>> +       return _ntc_thermistor_read(dev_get_drvdata(dev));
>> +}
>
> Function should be removed since it is no longer exported.
>

I have been considering to use this function at the board file in the
kernel space.
However, if it is removed, the driver may have a weird callback (a) or
the board file
may need to access sysfs filesystem and depends on sysfs (b).

(a): add "int (*read_thermistor)(struct platform_device *pdev)" at
struct ntc_thermistor_platform_data (in include/linux/ntc.h) and let
ntc_thermistor_probe provide callback thru pdata back to the caller of
platform_device_register().

(b): read "/sysfs/devices/platform/blahblah/temp1_input"
and keep /sysfs mounted always.

Are these approaches fine?

(snip)

>> +
>> +       /*
>> +        * The compensation table is sorted by ohm value. Although it is
>> +        * normally assumed that the temperature value monotonically
>> +        * increases or decreases with the ohm value, but there could be
>> +        * different thermistors. However, if we can assume so, we only need
>> +        * to look up the first and the last values.
>
> The last sentence isn't really valuable. Either only look up first and last values
> only, and explain why you do it and if and when the code might have to change,
> or just explain why you loop through the table even if you don't need to right now.

Got it.

>
>> +        */
>> +       for (i = 0; i < data->n_comp; i++) {
>> +               if (data->comp[i].temp_C > data->maxtemp)
>> +                       data->maxtemp = data->comp[i].temp_C;
>> +               if (data->comp[i].temp_C < data->mintemp)
>> +                       data->mintemp = data->comp[i].temp_C;
>> +       }
>> +
>> +       if (data->mintemp != INT_MAX)
>> +               data->mintemp *= 1000;
>> +       if (data->maxtemp != INT_MIN)
>> +               data->maxtemp *= 1000;
>> +
> Doesn't this indicate a logical error in the compensation tables ? If so, you might
> want to do something better than just report INT_MAX for the minimum temperature
> and INT_MIN for the maximum temperature (which doesn't really make sense).
> Maybe have the probe function return an error and fail to install.

Ok, I'll let it report an error for these instances as well.

>
(snip)
>

Thank you so much.



Happy Holidays!

- MyungJoo

-- 
MyungJoo Ham (함명주), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

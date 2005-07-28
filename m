From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 28 Jul 2005 10:16:26 +0000
Subject: [lm-sensors] Re: [patch] pc87360 de-macro and code shrink
Message-Id: <X6qrS8Rp.1122538033.9156210.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E87A0F.8060709@divsol.com>
In-Reply-To: <42E87A0F.8060709@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jim,

On 2005-07-28, Jim Cromie wrote:
> attached is a patch which:
>
> 1. adds an __ATTR_N macro to device.h,
> which takes an extra _index arg, and initializes device_attibute's new
> .index member.

This seems to be duplicating the SENSOR_DEVICE_ATTR macro as defined in
include/linux/hwmon-sysfs.h.

I like the cleanup you are proposing, but I'd like you to do it using
the mechanism that was introduced recently by Yani Ioannou rather than
reimplementing your own. Only a few drivers have been ported to use it
at the moment: adm1026, it87, lm63, lm83, lm90. See how that was done,
and do the same for pc87360.

> 2. replaces lots of nested-macro-uses of these:
>
> static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
>     show_temp##offset##_input, NULL); \
>
> with array initializers. like these:
>
> static struct device_attribute dev_attr_temp_input[] >   {
>     __ATTR_N(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
>     __ATTR_N(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
>     __ATTR_N(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
>     __ATTR_N(temp4_input, S_IRUGO, show_temp_input, NULL, 3),
>     __ATTR_N(temp5_input, S_IRUGO, show_temp_input, NULL, 4),
>     __ATTR_N(temp6_input, S_IRUGO, show_temp_input, NULL, 5),
>   };

This is a different cleanup. Getting rid of macros is one thing, using
arrays of attributes is another. As I said before, I'd like a separate
patch (or even several) for each step. This makes reviewing much easier.
Macro killing should be easy and unquestionable, while attribute arrays
is something that still needs discussing.

> this is an interim version, and has ifdefs to support back and forth
> debugging:
>
> grep define pc87360.c |grep ATTR_LOOP
> #define FAN_ATTR_LOOP 0
> #define PWM_ATTR_LOOP 0
> #define VOLT_ATTR_LOOP 1
> #define TEMP_ATTR_LOOP 0

This might be convenient for debugging but it's not so for reviewing. A
reviewer needs to be able to compare the code you remove with the code
you add, both in terms of contents and size, just by looking at the
patch.

You may consider using tools like quilt [1] to divide your work into
individual patches. This will still give you the ability to test your
changes individually, while also making it easy to review.

[1] http://savannah.nongnu.org/projects/quilt/

> using loops results in a large savings in obj code.
>
> baseline:           (...) 168326  (...) drivers/hwmon/pc87360.ko
> +VOLT_ATTR_LOOP     (...) 135940  (...) drivers/hwmon/pc87360.ko
> +TEMP_ATTR_LOOP     (...) 127441  (...) drivers/hwmon/pc87360.ko
> +FAN/PWM_ATTR_LOOP  (...) 121062  (...) drivers/hwmon/pc87360.ko

Sure it does, it won't be hard to convince me the idea has some value.
However, you should disable debugging before doing binary size
comparisons. The size of the drivers in debug mode is not exactly
meaningful. Also, some of the gain is due to the macro killing, not the
loops. Having separate patches for this would let you evaluate what
change exactly produces what gain.

> line 887 starts the show_and_set_temp(offset)  macro,
> which looks to be a duplicate of
> #define show_and_set_therm(offset) on line 651,

They are not duplicate. _temp is for diode-based temperature measurements
of the TMS logical device. _therm is for thermistor-based temperature
measurements of the VLM logical device. I remember there are a few
differences between them (let alone the fact that they point to
different data arrays, and are expressed in different units), such as
the limits being swapped or the critical limit being useless for certain
types of thermistors.

> or if theyre not duplicates (I havent looked carefully), its an
> unfortunate naming,
> creating functions which are disambiguated only by the offset.

Blame it to the complex design of the chip, the driver mostly follows it
both in construct and namings.

> OTOH, they could be different cuz the physical units on the chip have
> different capabilities.

Yup, that's it.

> ATM code has some unused data, but probly not another 10k

Probably way less than that and at the cost of some maintainability. I
wouldn't even try. _therm is certainly more similar to _in than _temp
(but I wouldn't try merging these either).

> Using loops to call device_create_file also simplifies some of the logic
> wrt data->innr, tempnr, fannr;
> the if-variations are hidden/abstracted by 0..configd_max.   Of course,
> I could have oversimplified.

I'm not sure I get what you mean. Again, this would probably be a
separate patch so that these changes are not hidden in much bigger
changes, and we can evaluate them properly.

> I have no fans on this board, and have never gotten temp readings I trust.
> But the voltages look right :-)

Known problem. Only temp3, which is internal, seems to report anything
valueable on the net4801, and even this value is usually too high to be
likely. But at least you should get the same value for temp3 before and
after your patches, and you should be able to change the limits as well.

Thanks,
--
Jean Delvare

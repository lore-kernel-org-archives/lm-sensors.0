From: Jordan Crouse <jordan.crouse@amd.com>
Date: Mon, 29 Sep 2008 20:13:50 +0000
Subject: Re: [lm-sensors] Add a driver for the ADT7475 thermal sensor
Message-Id: <20080929201350.GB15928@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080926232036.GH22230@cosmic.amd.com>
In-Reply-To: <20080926232036.GH22230@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 27/09/08 16:04 +0200, Hans de Goede wrote:
> Hi Jordan,
> 
> This time I've done a more thorough review, here is a quite long list of 
> remarks I would like you to take care of in one last revision, then this can go 
> upstream (through Jean or Andrew, Jean ?).

Thanks for your time.

> 1) As Andrew Morten already noted as comment to some other patch, its better to
>     make complex macros like this one:
> +#define TEMP2REG(val) ((val) <= -128000 ? -128 : \
> +       (val) >= 127000 ? 127 : \
> +       (val) < 0 ? ((val) - 500) / 1000 : \
> +       ((val) + 500) / 1000)
> 
>     static functions rather then macros all the ? constructions will lead to
>     interesting code and if you make it a function the compiler will usually
>     create significant smaller code

I have turned all the macros into function.  Am I right in saying that
the current kernel policy is to not mark them as inline and let
the compiler decide?

>     And you may want to split the macro's in 2 blocks with comments that the
>     first ones are used as array indices for various arrays, and the second ones
>     are for special cases (and must be higher then the max array index).

Yeah - the problem is that the indexes are serving double duty - their most
important function is to be unique identifiers for the sysfs files - its
just happy that they can also serve as indexes in the array.  I have made
the comments.

> +static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)
> +{
> +       i2c_smbus_write_byte_data(client, reg + 1, val >> 8);
> +       i2c_smbus_write_byte_data(client, reg, val & 0xFF);
> +}
> 
>     The datasheet mandates the order as done in read, and says nothing about
>     write, so I would like to suggest to use the read order for write too.

I'm following what Jean said here.  Typically, it is safer to write
the upper byte first, since that will at least write the upper level
bits to the hardware.

> Please clamp val here using SENSORS_LIMIT, note you must use SENSORS_LIMIT 
> return value, example:
> v = SENSORS_LIMIT(v, -128, 127);

I have used SENSORS_LIMIT everywhere it makes sense.

> 
> 8) Please check that you are using the same basic unit everywhere, for example 
> Where out is the register value.
> But in the temp hysteresis store you do:
> +               val = CONV2TEMP(data->temp[THERM][sattr->index]) - val;
> +
> +               if (sattr->index != 1) {
> +                       data->temp[HYSTERSIS][sattr->index] &= 0xF0;
> +                       data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4
> +               } else {
> 
> So here the value written by the user has to be the current THERM setting in 
> millidegrees minus the hysteresis he wants in normal celciuses so lets say 
> THERM is 75 degrees so 75000, and he wants to set a hysteris of 5 degrees he 
> should pass in 74995, which should of course be 70000.

No - the hystersis number is expected to be 5000 to the user.
However this function was wrong in that it wasn't converting the
hystersis back to the value needed by the register.

> 11) set_pwm_ctrl set_pwm_chan need better error checking. They should check the
>      value they get passed is not negative, and set_pwm_chan should check for
>      unsupported combos. I guess the best would be to do no checking and just
>      pass the old chan and the new ctrl or vica versa to hw_set_pwm()
>      and then return -EINVAL from hw_set_pwm on not valid combo's (and do
>      storing of the values in the data struct also in hw_set_pwm when
>      things are ok).

I did the bounds checking in the individual functions - it just makes
things easier then trying to make hw_set_pwm do bounds checking as well
as calculating the value.

I'll send out a new driver at some point - this one changed enough that
I'll have to put it through some heavy testing.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

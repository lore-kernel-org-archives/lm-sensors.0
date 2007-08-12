From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 11:01:49 +0000
Subject: Re: [lm-sensors] Proposal: howto handle sysfs attribute writes with
Message-Id: <20070812130149.7c7444cd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F7CFC.4040306@hhs.nl>
In-Reply-To: <469F7CFC.4040306@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 29 Jul 2007 09:13:03 +0200, Hans de Goede wrote:
> Howto check the validity of user written values to sysfs attributes:
> 
> hwmon sysfs attributes always contain numbers, so the first thing to do is to
> convert the input to a number, there are 2 ways todo this depending whether
> the number can be negative or not:
> unsigned long u = simple_strtoul(buf, NULL, 10);
> long s = simple_strtol(buf, NULL, 10);
> 
> With buf being the buffer with the user input being passed by the kernel.
> Notice that we do not use the second argument of strto[u]l, and thus cannot
> tell when 0 is returned, if this was really 0 or is caused by invalid input.
> This is done deliberately as checking this everywhere would add a lot of
> code to the kernel. We do need to document clearly that writing a non-number
> will be seen as writing 0.

This last sentence obviously can't be left verbatim in the final text.

> Notice that it is important to always store the converted value in an unsigned
> long or long, so that no wrap around can happen before any further checking.
> 
> After conversion and storing the converted value in the right type, the value

"After converting and storing"?

> should be checked if its acceptable. Be carefull with further conversions on the

Spelling: careful.

> value before checking it for validity, as these conversions could still cause a
> wrap around before the check. For example do not multiply the result, and only add
> / substract if it has been divided before the add / substract.

Spelling: subtract (I had to double-check this one, I would have had it
wrong myself.)

> What to do if a value is found to be invalid, depends on the type of the sysfs 
> attribute that is being set. If its a continuous setting like a tempX_max or 

Spelling: it's.

> inX_max attribute, then the value should be clamped to its limits using 
> SENSORS_LIMIT(value, min_limit, max_limit). If its not continuous like for 

Ditto.

> example a tempX_type, then when an invalid value is written, -EINVAL should be 
> returned.
> 
> Example1, temp1_max, register presents -128 - 127 degrees as 0 - 255:
> long v = simple_strtol(buf, NULL, 10) / 1000;
> SENSORS_LIMIT(v, -128, 127);
> v += 128;
> /* write v to register */

This example is confusing IMHO, as most chips present -128 - 127
degrees as 0 - 255, but using a signed (2's complement) value, not
using an offset.

> Example2, fan divider setting, valid values 2, 4 and 8
> unsigned long v = simple_strtoul(buf, NULL, 10);
> 
> switch (v) {
>         case 2: v = 1; break;
>         case 4: v = 2; break;
>         case 8: v = 3; break;
>         default:
>                 return -EINVAL;
> }
> /* write v to register */
> 
> ---
> 
> So, let me know what you think of the new version above and if its acceptable 
> I'll do a patch adding this to the sysfs interface doc, or should it be in 
> another doc?

sysfs-interface seems to be the right place.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 07 Oct 2007 11:37:53 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <4708C511.6010508@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 24 Sep 2007 16:28:16 +0200, Jean Delvare wrote:
>> Hi Hans,
>>
>> On Fri, 21 Sep 2007 17:03:32 +0200, Hans de Goede wrote:
>>> Here is a patch adding some text to the sysfs interface documentation on how
>>> settings written to sysfs attributes should be handled, focussing mainly on
>>> error handling. This version incorperates Jean's latest comments.
>>>
>>> signed-off-by: j.w.r.degoede@hhs.nl
>> Thanks for doing this.
>>
>> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> While reviewing your new fschmd driver, I found some mistakes which
> also appear in the code examples of this documentation update:
> 
>> +--- begin code ---
>> +long v = simple_strtol(buf, NULL, 10) / 1000;
>> +SENSORS_LIMIT(v, -128, 127);
> 
> This is a no-op, should be v = ...
> 

Yes, I already noticed myself, but you beat me to writing a patch, thanks!
Notice that this is what happens when you make a function look like a macro by 
giving it all caps names. Note: I'm not trying to talk my mistake right, just 
trying to explain how I came to the mistake. Maybe we should rename SENSORS_LIMIT?

>> +/* write v to register */
>> +--- end code ---
> 
>> +--- begin code ---
>> +unsigned long v = simple_strtoul(buf, NULL, 10);
>> +
>> +switch (v) {
>> +       case 2: v = 1; break;
>> +       case 4: v = 2; break;
>> +       case 8: v = 3; break;
>> +       default:
>> +               return -EINVAL;
>> +}
> 
> Indentation doesn't comply with CodingStyle.
> 
>> +/* write v to register */
>> +--- end code ---
> 
> Additionally, I think that the examples are a bit difficult to read,
> one level of indentation would probably be better than the begin/end
> code markers. Thus, I propose the following incremental patch:
> 
>  Documentation/hwmon/sysfs-interface |   30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> --- linux-2.6.23-rc9.orig/Documentation/hwmon/sysfs-interface	2007-10-07 10:12:33.000000000 +0200
> +++ linux-2.6.23-rc9/Documentation/hwmon/sysfs-interface	2007-10-07 10:13:43.000000000 +0200
> @@ -450,22 +450,20 @@ continuous like for example a tempX_type
>  written, -EINVAL should be returned.
>  
>  Example1, temp1_max, register is a signed 8 bit value (-128 - 127 degrees):
> ---- begin code ---
> -long v = simple_strtol(buf, NULL, 10) / 1000;
> -SENSORS_LIMIT(v, -128, 127);
> -/* write v to register */
> ---- end code ---
> +
> +	long v = simple_strtol(buf, NULL, 10) / 1000;
> +	v = SENSORS_LIMIT(v, -128, 127);
> +	/* write v to register */
>  
>  Example2, fan divider setting, valid values 2, 4 and 8:
> ---- begin code ---
> -unsigned long v = simple_strtoul(buf, NULL, 10);
>  
> -switch (v) {
> -       case 2: v = 1; break;
> -       case 4: v = 2; break;
> -       case 8: v = 3; break;
> -       default:
> -               return -EINVAL;
> -}
> -/* write v to register */
> ---- end code ---
> +	unsigned long v = simple_strtoul(buf, NULL, 10);
> +
> +	switch (v) {
> +	case 2: v = 1; break;
> +	case 4: v = 2; break;
> +	case 8: v = 3; break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* write v to register */
> 
> 


I agree with all changes, Mark pleaee apply:

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

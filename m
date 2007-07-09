From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jul 2007 15:55:00 +0000
Subject: Re: [lm-sensors] [ patch ]  de-macro-fy w83627hf.c
Message-Id: <20070709175500.34c366d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46903707.4000300@gmail.com>
In-Reply-To: <46903707.4000300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Sat, 07 Jul 2007 18:59:51 -0600, Jim Cromie wrote:
> w83627hf.c has lots of macros which generate repetetive sysfs callback 
> functions.
> 
> Attached patch replaces most of them, and upgrades several DEVICE_ATTR
> declarations with SENSOR_DEVICE_ATTRs as needed to determine which
> the callbacks need to determine which sensor-number is being accessed.
> 
> Patched driver works on my W83627HF equipped AMD-Barton MOBO.

Great, thanks for working on this, this is very needed.

> If you have one of the other parts supported by this board, please test 
> this patch
> and let me know.  (ie Ack/Nack this and subsequent revisions)

I have a W83627THF and will be testing your patch (but see below.)

> WRT Submission:
> 
> 1 - the patch is getting big, so Id like to hear whether its acceptable 
> in one big lump.
> 
>  diffstat diff.hwmon-w83627hf-demacro-sysfs-callbacks
>  w83627hf.c |  516 
> ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 254 insertions(+), 262 deletions(-)
> 
> If I should break it up, Id probably do it on VIN, FAN, PWM, TEMP 
> boundaries, unless you have other thoughts.

The patch is big but it does only one thing, so it's perfectly OK.
Please don't waste your time splitting it up.

OTOH, I have a problem applying your patch, because it's based on
Linus' tree rather than Mark M. Hoffman's hwmon testing branch. Mark's
branch has 3 additional patches affecting the w83627hf driver, and at
least one of them conflicts with your patch. You can see these patches
here:

http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=history;f=drivers/hwmon/w83627hf.c;hb=testing

So I would like you to rebase your patch on this branch, otherwise Mark
won't be able to apply it anyway.

> 2 - checkpatch complains about a few things - and fixing them would 
> enlarge the patch,
> and thus may qualify for separation (or ignoring)
> 
> line over 80 characters
> #27: FILE: drivers/hwmon/w83627hf.c:422:
> +static ssize_t show_in_input(struct device *dev, struct 
> device_attribute *devattr, char *buf)
> 
> IIUC, Linus thinks this check is somewhat nazi-ish (his word), and I 
> recall that some people
> prefer to have the entire function-signature on a single line (grep 
> friendly)

Documentation/CodingStyle says: "The limit on the length of lines is 80
columns and this is a hard limit." It could hardly be clearer, and if
Linus wasn't happy with this, I guess that this would have been updated
by now. So, yes, such long lines need to be folded. The line you quote
above is not in the original driver, BTW, it's added by your patch so
you should fix it in your patch. If there are other occurrences that are
not introduced by your patch, then they can be fixed in a later patch,
if you care.

> Macros with multiple statements should be enclosed in a do - while loop
> #76: FILE: drivers/hwmon/w83627hf.c:471:
> +#define vin_decl(offset)       \
> +static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,                 \
> 
> Ive stuffed repetetive declarations and initializations into macros,
> and this warning is unavoidable for those uses.

This isn't really a problem as long as these macros are only used in
the source file where they are defined. So I'd say leave them as is,
it's OK.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

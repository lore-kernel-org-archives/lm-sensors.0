From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Apr 2011 15:37:48 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: Add SubmittingHwmonPatches to
Message-Id: <20110403173748.2daec2ce@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1301760379-13038-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1301760379-13038-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 2 Apr 2011 09:06:19 -0700, Guenter Roeck wrote:
> When writing hardware monitoring drivers, there are some common pitfalls which
> keep coming up in code reviews. This patch provides a document describing all
> those pitfalls and how to avoid them.

FWIW, for the i2c subsystem I decided to publish my recommendations on
a wiki, rather than in the kernel tree:
  https://i2c.wiki.kernel.org/index.php/Linux_2.6_I2C_development_FAQ

We could have a similar wiki for the hwmon subsystem if you think this
would be useful. It would also be possible to create a page in the
lm-sensors.org wiki, as both projects are tightly related anyway.

> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/SubmittingHwmonPatches |   58 ++++++++++++++++++++++++++++
>  1 files changed, 58 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/SubmittingHwmonPatches

I object to this file name. None of the other files in this directory
follows this naming/case convention. Use
Documentation/hwmon/submitting-patches please.

> 
> diff --git a/Documentation/hwmon/SubmittingHwmonPatches b/Documentation/hwmon/SubmittingHwmonPatches
> new file mode 100644
> index 0000000..867f383
> --- /dev/null
> +++ b/Documentation/hwmon/SubmittingHwmonPatches
> @@ -0,0 +1,58 @@
> +* It should be unnecessary to mention, but please read and follow 
> +    Documentation/SubmitChecklist
> +    Documentation/SubmittingDrivers
> +    Documentation/SubmittingPatches
> +    Documentation/CodingStyle
> +
> +* Running your patch through checkpatch does not mean its formatting is clean.
> +  If unsure about indentation in your new driver, run it through Lindent.
> +  Lindent is not perfect, and you may have to do some minor cleanup, but it is a
> +  good start.
> +
> +* If you do have checkpatch warnings, please refrain from explanations such as
> +  "I don't like that coding style". Keep in mind that each unnecessary warning
> +  helps hiding a real problem. If you don't like the kernel coding style, don't
> +  write kernel drivers.
> +
> +* If you add a new driver, consider adding yourself to MAINTAINERS.
> +
> +* Document new drivers in Documentation/hwmon/<Driver_Name>. If you add
> +  functionality to an existing driver, make sure the documentation is up to date.
> +
> +* When updating an existing driver, make sure the information in Kconfig is up
> +  to date.
> +
> +* When adding a new driver, add it to Kconfig and Makefile in alphabetical
> +  order.
> +
> +* Make sure there are no race conditions in the probe function. Specifically,
> +  initialize your chip first, then create sysfs entries, then register with the
> +  hwmon subsystem.

What really matters is fully initializing the device before creating
the sysfs attributes. The order between sysfs attributes creation and
hwmon subsystem registration can't be enforced, as not all hwmon
devices are backed up by a physical device, so you sometimes _have_ to
create the hwmon device first, and attributes second.

> +
> +* If your driver has a detect function, make sure it is silent. Specifically, it

"Silent" is a little too restrictive. Debug messages are fine, and
messages printed after a successful detection are relatively common
amongst hwmon drivers.

> +  should not create messages such as "Chip XXX not found/supported". Keep in

"print messages" or "log messages" would be more appropriate than
"create messages".

> +  mind that the detect function will run on all detected chips. Unnecessary
> +  messages will just pollute the kernel log and not provide any value.
> +
> +* Do not write to chip registers in the _detect function. Keep in mind that the
> +  chip might not be what your driver believes it is, and writing to it might
> +  cause a bad misconfiguration.

To be complete: you shouldn't write to the chip before you have already
gathered enough data to be certain that the detection is successful.
See w83795_detect() in drivers/hwmon/w83795.c for a case where I had to
write to the chip to determine the exact chip type.

Not sure if you want to mention this though, it might confuse more than
help the reader.

> +
> +* Avoid forward declarations if you can. Rearrange the code if necessary.
> +
> +* Avoid function macros. While it may save a line or so in the source, it
> +  obfuscates the code and makes code review more difficult. It may also result
> +  in code which is more complicated than necessary.

See my review of your max16065 driver ;)

> +
> +* When writing a new driver, do not provide deprecated sysfs attributes.
> +
> +* Do not create non-ABI attributes unless really needed. If you have to use

I'd use "non-standard" rather than "non-ABI".

> +  non-ABI attributes, or you believe you do, discuss it on the mailing list
> +  first. Either case, provide a detailed explanation why you need the non-ABI
> +  attribute(s).
> +  For reference, the ABI is in specified in Documentation/hwmon/sysfs-interface.
> +
> +* If you add functionality to an existing driver, and the addition requires some
> +  cleanup or structural changes, split your patch into a cleanup part and the
> +  actual addition. This makes it easier to review your changes, and to bisect
> +  any resulting problems.

As a general comment, you may want to group the items in 3 sections:
items which apply to new drivers, items which apply to driver changes
and items which apply to both. This will add some structure to the
document, making it less boring to read than a long flat list.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

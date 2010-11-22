From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Nov 2010 21:49:56 +0000
Subject: Re: [lm-sensors] Further documentation for w83627hf module
Message-Id: <20101122224956.22fb1f12@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
In-Reply-To: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Julian,

On Sun, 14 Nov 2010 22:40:13 +0100, Julian Brunner wrote:
> I'm trying to write an lm-sensors configuration for the mainboard
> "Kontron 986LCD-M/mITX", which uses the "Winbond W83627THF" sensor
> chip.
> 
> I contacted the manufacturer to request information about how the
> sensors/fans/voltages are connected to the chip and how to convert the
> raw values to sensible information. They sent me a table listing which
> sensor/fan/voltage is connected to which pin on the chip, together
> with the used resistors and conversion formulas. They table also has a
> column saying on which lm-sensors output the sensor/fan/voltage should
> appear (inX, fanX, tempX).

This is very nice to them. Most manufacturers don't bother providing
that kind of technical details.

> Unfortunately, the values that are reported don't match up (for
> example, +5V is supposed to appear on in2, although values near 3.26V
> are reported).

Are you sure you declared the proper compute formula based on the
resistor values they provided? +3.26V looks like an unscaled value.

> Now, I guess it's possible that they used a different
> module or a different version of the same module (to drive the sensor
> chip) when they created the table.

"module"? Do you mean kernel driver? There has only ever been one Linux
driver supporting the W83627THF device, and that driver is the w83627hf
driver. This driver has been mostly unchanged for the past several
years, so I doubt that even an older version of that driver could
explain the difference.

> So I started looking for information on the "w83627hf" module that I'm
> running, to find out which input pins of the sensor chip are mapped to
> which lm-sensors outputs. Unfortunately, the documentation I found for
> this module (for example, the one at
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/w83627hf?rev222
> (I also checked the one of "w83781d" mentioned there)) doesn't seem to
> contain any information on how the sensor chip inputs translate to
> lm-sensor outputs.

The document above is outdated. It refers to the legacy version of the
driver, that was aimed at Linux kernel 2.4. For an up-to-date document,
please check the 2.6 kernel source tree:
  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/hwmon/w83627hf

But anyway, none of our driver documentation files lists the pin
mapping of sysfs attribute files. It would be redundant with the
datasheets. These datasheets were public, so even though I don't think
they are available on the manufacturer's site any longer, you should
have no difficulties getting your hands on the W83627THF datasheet.

> So, I'd be very thankful for any advice on where to look for
> information regarding this mapping from sensor chip inputs to
> lm-sensor outputs.

Google for "W83627THF datasheet". On the datasheet, there's one page
with the chip drawn and pin numbers with functions.

That being said, the information provided by Kontron should be
sufficient to write a libsensors configuration file. If you could share
the information with us, together with the configuration file you came
up with, we should be able to help you fix it.

Please also include the raw output of sensors (sensors -c /dev/null),
we will use it as a basis to validate the compute statements.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

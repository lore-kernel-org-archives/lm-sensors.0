From: Julian Brunner <julianbrunner@googlemail.com>
Date: Tue, 23 Nov 2010 20:25:48 +0000
Subject: Re: [lm-sensors] Further documentation for w83627hf module
Message-Id: <AANLkTinYWo_zxt_WUsHr-dvty_jopy6tenb=quw0yqJ2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
In-Reply-To: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello Jean,

On Mon, Nov 22, 2010 at 10:49 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Julian,
>
> On Sun, 14 Nov 2010 22:40:13 +0100, Julian Brunner wrote:
>> I'm trying to write an lm-sensors configuration for the mainboard
>> "Kontron 986LCD-M/mITX", which uses the "Winbond W83627THF" sensor
>> chip.
>>
>> I contacted the manufacturer to request information about how the
>> sensors/fans/voltages are connected to the chip and how to convert the
>> raw values to sensible information. They sent me a table listing which
>> sensor/fan/voltage is connected to which pin on the chip, together
>> with the used resistors and conversion formulas. They table also has a
>> column saying on which lm-sensors output the sensor/fan/voltage should
>> appear (inX, fanX, tempX).
>
> This is very nice to them. Most manufacturers don't bother providing
> that kind of technical details.

Yes, I've done (or rather, tried doing) the configuration for two
mainboards from other manufacturers and had to learn the hard way that
the sensors conversion formulas are some of the best kept business
secrets, so I'm really grateful for this one.

>> Unfortunately, the values that are reported don't match up (for
>> example, +5V is supposed to appear on in2, although values near 3.26V
>> are reported).
>
> Are you sure you declared the proper compute formula based on the
> resistor values they provided? +3.26V looks like an unscaled value.

Well, the document doesn't say anything about resistors for that
particular pin (AVCC, Pin 114), and the "Multiply factor" is supposed
to be 1.

>> Now, I guess it's possible that they used a different
>> module or a different version of the same module (to drive the sensor
>> chip) when they created the table.
>
> "module"? Do you mean kernel driver? There has only ever been one Linux
> driver supporting the W83627THF device, and that driver is the w83627hf
> driver. This driver has been mostly unchanged for the past several
> years, so I doubt that even an older version of that driver could
> explain the difference.
>
>> So I started looking for information on the "w83627hf" module that I'm
>> running, to find out which input pins of the sensor chip are mapped to
>> which lm-sensors outputs. Unfortunately, the documentation I found for
>> this module (for example, the one at
>> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/w83627hf?rev222
>> (I also checked the one of "w83781d" mentioned there)) doesn't seem to
>> contain any information on how the sensor chip inputs translate to
>> lm-sensor outputs.
>
> The document above is outdated. It refers to the legacy version of the
> driver, that was aimed at Linux kernel 2.4. For an up-to-date document,
> please check the 2.6 kernel source tree:
>  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/hwmon/w83627hf
>
> But anyway, none of our driver documentation files lists the pin
> mapping of sysfs attribute files. It would be redundant with the
> datasheets. These datasheets were public, so even though I don't think
> they are available on the manufacturer's site any longer, you should
> have no difficulties getting your hands on the W83627THF datasheet.
>
>> So, I'd be very thankful for any advice on where to look for
>> information regarding this mapping from sensor chip inputs to
>> lm-sensor outputs.
>
> Google for "W83627THF datasheet". On the datasheet, there's one page
> with the chip drawn and pin numbers with functions.

I've had had a look at this datasheet a few weeks ago already, I've
also seen the page with the pin layout and description. Still, I can't
figure out how this tells me on which sysfs file a particular pin's
value would appear (for example, the description of VIN0 only says "0V
to 4.096V FSR Analog Inputs"). And how would the authors of the
datasheet know about this mapping in the first place? I feel like I'm
getting something completely wrong here, it'd be great if you could
clarify how I would get the information I need out of this document.

> That being said, the information provided by Kontron should be
> sufficient to write a libsensors configuration file. If you could share
> the information with us, together with the configuration file you came
> up with, we should be able to help you fix it.
>
> Please also include the raw output of sensors (sensors -c /dev/null),
> we will use it as a basis to validate the compute statements.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

I've uploaded the document Kontron sent me at
http://multiserver.ath.cx/LM%20Sensor%20correction%20tables.pdf
(unfortunately, the connection is somewhat unstable, if it doesn't
work, try a few hours later or the next day, I think I can't attach
pdf files when sending stuff to the mailing list).

The configuration for lm-sensors I'm currently using is this:

chip "w83627thf-*"

    label in0 "VCore A"
    label in1 "+12 V"
    label in2 "+5 V"
    label in3 "+3 V"
    label in4 "+3.3 V"
    label in5 "VCore B"
    label in7 "+5 VSB"
    label in8 "V Battery"

    label temp1 "System Temperature"
    label temp2 "CPU Temperature"
    label temp3 "External Temperature"

    label fan1 "System Fan"
    label fan2 "CPU Fan"
    label fan3 "External Fan"

    compute in0 1.000 * @, @ / 1.000
    compute in1 3.801 * @, @ / 3.801
    compute in2 1.000 * @, @ / 1.000
    compute in3 1.000 * @, @ / 1.000
    compute in4 1.000 * @, @ / 1.000
    compute in5 1.000 * @, @ / 1.000
    compute in7 1.000 * @, @ / 1.000
    compute in8 1.000 * @, @ / 1.000

The output from sensors -c /dev/null is:

w83627thf-isa-0a00
Adapter: ISA adapter
in0:         +0.97 V  (min =  +0.70 V, max =  +1.87 V)
in1:         +3.17 V  (min =  +2.77 V, max =  +0.27 V)   ALARM
in2:         +3.26 V  (min =  +1.54 V, max =  +0.54 V)   ALARM
in3:         +2.96 V  (min =  +3.07 V, max =  +0.29 V)   ALARM
in4:         +1.52 V  (min =  +0.10 V, max =  +1.18 V)   ALARM
in7:         +2.96 V  (min =  +0.00 V, max =  +2.05 V)   ALARM
in8:         +3.12 V  (min =  +1.02 V, max =  +0.05 V)   ALARM
fan1:          0 RPM  (min = 15340 RPM, div = 2)  ALARM
fan2:       2789 RPM  (min = 84375 RPM, div = 2)  ALARM
fan3:          0 RPM  (min = 5075 RPM, div = 2)  ALARM
temp1:       +77.0°C  (high =  +0.0°C, hyst =  +4.0°C)  ALARM  sensor
= thermistor
temp2:       +67.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
temp3:       +60.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor

So 12 V seems to be alright, VCore, too, I'll have to check with the
BIOS values later to confirm. 3 V could be right too, but seeing how
almost everything else is messed up, I'm not too sure that's not just
a coincidence, too. The temperatures are kinda off, too, seeing how
coretemp reports 47 ºC.

I'm not really sure what to do at this point, and whether I got
something backwards or the information from Kontron is incorrect. So
any pointers on what might be going on here are greatly appreciated.

Thanks in advance,
 Julian Brunner

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

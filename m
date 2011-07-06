From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 06 Jul 2011 11:19:26 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <CAKPcRGppkzhv4bjuQYWNHAkJJW6xfTp4GRst04uve6hnj0q9XQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

n Wed, Jul 6, 2011 at 11:04 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> It was an ugly hack :) I modified the driver to access the hwmon chip
>> using the methods exposed by the firmware instead of letting the
>> driver touch the chip directly. Unfortunately the hack is very board
>> specific...
>
> I still have to test this approach on a Jetway board of mine with a
> Fintek F71805F chip.
>
> Why do you say this is ugly?

As it is it's poorly engineered. Ideally there should be an
independent IO layer (that uses the IO ports, the Jetway methods, the
MSI methods, etc) shared by all the drivers. At the very least the
fintek driver should be modified to support the differrent IO methods.

> Of course it is vendor specific (or even
> board specific) but so is the asus_atk0110 driver. Wouldn't it be a
> proper way to deal with the ACPI resource conflict at least on the
> Jetway boards, and maybe others?

Two problems: 16 bits access are still not atomic (i.e. the two ACPI
calls may be interleaved with something else touching the chip), so
it's not 100% race free.
The second one is deciding when to use the ACPI methods: I don't see a
well defined interface with a proper HID like ATK0110, what I see are
utility method used by the rest of the code. It wouldn't be possible
to auto-detect such boards, we would need to resort to a DMI
whitelist.

That said, since Dave has a different board with different ACPI
methods for the same Fintek chip I'll try to code something to
accommodate this situation soon(ish).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

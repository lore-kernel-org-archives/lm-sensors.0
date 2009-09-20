From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 20 Sep 2009 12:20:34 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
In-Reply-To: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wixor <wixorpeek@gmail.com>
Cc: lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Sep 20, 2009 at 10:20 AM, wixor <wixorpeek@gmail.com> wrote:
> Hello,
> with recent upgrade to 2.6.31 I get
>
> it87: Found IT8712F chip at 0x290, revision 7
> it87: in3 is VCC (+5V)
> it87: in7 is VCCH (+5V Stand-By)
> ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region IP__
> [0x295-0x296]
> ACPI: Device needs an ACPI driver
> FATAL: Error inserting it87
> (/lib/modules/2.6.31/kernel/drivers/hwmon/it87.ko): Device or resource
> busy
[...]
> I have also discovered that dsdt contains description of what is
> connected to each it87 input. Maybe it has also some code to access
> the chip? In /proc/acpi I can read only one temperature, while the
> chip measures three temperatures, fan speeds and voltages. This is
> desktop pc with ASUS A8N1-E maniboard, athlon64 and nforce4 chipset.

Try the asus_atk0110 driver, it handles the ACPI hwmon interface on
Asus motherboards. If it does not work then please send a dump of your
DSDT (/sys/firmware/acpi/tables/DSDT).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

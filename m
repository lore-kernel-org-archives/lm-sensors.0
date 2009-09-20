From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 20 Sep 2009 21:31:56 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <68676e00909201431j43402470g70df5519a963097b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
	 <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
	 <200909201637.52514.gene.heskett@verizon.net>
In-Reply-To: <200909201637.52514.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gene Heskett <gene.heskett@verizon.net>
Cc: wixor <wixorpeek@gmail.com>, lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Sep 20, 2009 at 10:37 PM, Gene Heskett <gene.heskett@verizon.net> w=
rote:
> On Sunday 20 September 2009, Luca Tettamanti wrote:
>>On Sun, Sep 20, 2009 at 10:20 AM, wixor <wixorpeek@gmail.com> wrote:
>>> Hello,
>>> with recent upgrade to 2.6.31 I get
>>>
>>> it87: Found IT8712F chip at 0x290, revision 7
>>> it87: in3 is VCC (+5V)
>>> it87: in7 is VCCH (+5V Stand-By)
>>> ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region IP__
>>> [0x295-0x296]
>>> ACPI: Device needs an ACPI driver
>>> FATAL: Error inserting it87
>>> (/lib/modules/2.6.31/kernel/drivers/hwmon/it87.ko): Device or resource
>>> busy
>>
>>[...]
>>
>>> I have also discovered that dsdt contains description of what is
>>> connected to each it87 input. Maybe it has also some code to access
>>> the chip? In /proc/acpi I can read only one temperature, while the
>>> chip measures three temperatures, fan speeds and voltages. This is
>>> desktop pc with ASUS A8N1-E maniboard, athlon64 and nforce4 chipset.
>>
>>Try the asus_atk0110 driver, it handles the ACPI hwmon interface on
>>Asus motherboards. If it does not work then please send a dump of your
>>DSDT (/sys/firmware/acpi/tables/DSDT).
>>
> Jumping in the middle of this, I am another that it87 doesn't work very w=
ell
> for, =C2=A0ASUS M2N SLI Deluxe board.

Please define "doesn't work well". asus_atk0110 should handle that
board. In case of troubles enable CONFIG_HWMON_DEBUG_CHIP, load
asus_atk0110 and post the content of the kernel log.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

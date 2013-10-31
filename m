From: Igor Popik <igor.popik@gmail.com>
Date: Thu, 31 Oct 2013 18:46:47 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <CAK0txek_nqZDACnuk8_yDfHgE1yH9R4XpgmR+6vP8+8=eEwV=A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, Guenter,

2013/10/30 Guenter Roeck <linux@roeck-us.net>:
> On Wed, Oct 30, 2013 at 08:29:45AM +0100, Jean Delvare wrote:
>>
>> I see the following:
>>
>>                 Scope (\_SB.PCI0.LPCB)
>>                 {
>>                     Device (H_EC)
>>                     {
>>                         Name (_HID, EisaId ("PNP0C09"))  // _HID: Hardware ID
>>                         Name (_UID, One)  // _UID: Unique ID
>>                         (...)
>>                         OperationRegion (ECF2, EmbeddedControl, Zero, 0xFF)
>>                         Field (ECF2, ByteAcc, Lock, Preserve)
>>                         {
>>                             (...)
>>                             Offset (0xEE),
>>                             BHFW,   16,
>>                             F1PW,   8,
>>                             F2PW,   8,
>>                             F1RM,   8,
>>                             F2RM,   8,
>>                             FAMO,   8,
>>                             F1SP,   16,
>>                             F2SP,   16,
>>                             FAN1,   8,
>>                             FAN2,   8,
>>                             BCG1,   16,
>>                             BCG2,   16
>>
>> This seems to imply there is an EC which knows something about fans.
>> However there is no reference to these fields in the rest of the DSDT.
>> There could be references in other ACPI tables though. Also note that
>> PNP0C09 is referenced in driver thinkpad_acpi so maybe that driver can
>> help. That being said, it seems that newer laptop models from Lenovo
>> aren't supported by this driver as good as older models were.
>>
> Given the "flexibility" in ACPI permitting vendors to change bindings
> and underlying functionality at their leisure, that is hardly surprising.
>
> Looking through the driver, there is lots of magic in there anyway.
> I think the best shot would be to load the driver and hope that it works.
> However, the following note on thinkwiki.org, related to Lenovo 3000, suggests
> that it may not work: "The ACPI and EC firmware are completely incompatible
> with ThinkPads, and thinkpad-acpi will not support it. The Lenovo 3000 are not
> ThinkPads". Since the Yoga isn't even a laptop, that doesn't sound very
> encouraging.
>
>> Also interesting is the SBUS device which defines a complete ACPI
>> interface to the SMBus controller. Unfortunately it doesn't follow the
>> SMBus CMI standard. Writing an ACPI driver for it would allow working
>> around the i2c-i801 resource conflict. However this doesn't seem
>> terribly useful as there's only the memory module SPD EEPROM visible on
>> the SMBus.
>>
> Also, the interface may change with the next laptop model, so a driver
> would only have limited value.
>
>> If it was me, I think I'd just leave the whole thing alone unless you
>> have a real problem that needs to be solved.
>>
> +1

My life does not depend on that :-)

Yoga is working pretty quiet and much longer on battery than on
windows (and it is a _laptop_ :-P).

Thank You for Your time & help provided.

Thanks,
Igor

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

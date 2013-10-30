From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 Oct 2013 07:29:45 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <20131030082945.77cceb0f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Oct 2013 07:52:51 +0100, Igor Popik wrote:
> 2013/10/30 Guenter Roeck <linux@roeck-us.net>:
> > As Jean mentioned, there may be another i2c bus, a hidden i2c multiplexer,
> > or the chip may be connected to the IDT EC. The DSDT might give us
> > some hints. You already know from the ACPI overlap that ACPI talks with the
> > SMBus adapter; it might also talk with the EC. Can you extract the DSDT
> > and provide it to us ?
> >
> >         sudo cat /sys/firmware/acpi/tables/DSDT > dsdt.aml
> >
> > Then, in case you want to learn things you never really wanted to know:
> >
> >         iasl -d dsdt.aml
> 
> Here it is. Hope You find something interesting there.

I see the following:

                Scope (\_SB.PCI0.LPCB)
                {
                    Device (H_EC)
                    {
                        Name (_HID, EisaId ("PNP0C09"))  // _HID: Hardware ID
                        Name (_UID, One)  // _UID: Unique ID
                        (...)
                        OperationRegion (ECF2, EmbeddedControl, Zero, 0xFF)
                        Field (ECF2, ByteAcc, Lock, Preserve)
                        {
                            (...)
                            Offset (0xEE), 
                            BHFW,   16, 
                            F1PW,   8, 
                            F2PW,   8, 
                            F1RM,   8, 
                            F2RM,   8, 
                            FAMO,   8, 
                            F1SP,   16, 
                            F2SP,   16, 
                            FAN1,   8, 
                            FAN2,   8, 
                            BCG1,   16, 
                            BCG2,   16

This seems to imply there is an EC which knows something about fans.
However there is no reference to these fields in the rest of the DSDT.
There could be references in other ACPI tables though. Also note that
PNP0C09 is referenced in driver thinkpad_acpi so maybe that driver can
help. That being said, it seems that newer laptop models from Lenovo
aren't supported by this driver as good as older models were.

Also interesting is the SBUS device which defines a complete ACPI
interface to the SMBus controller. Unfortunately it doesn't follow the
SMBus CMI standard. Writing an ACPI driver for it would allow working
around the i2c-i801 resource conflict. However this doesn't seem
terribly useful as there's only the memory module SPD EEPROM visible on
the SMBus.

If it was me, I think I'd just leave the whole thing alone unless you
have a real problem that needs to be solved.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

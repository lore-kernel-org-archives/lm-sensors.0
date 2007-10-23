From: Rudolf Marek <r.marek@sh.cvut.cz>
Date: Tue, 23 Oct 2007 21:54:24 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <471E6D90.9050009@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> etc etc. This appears to be the half-standard ATK0110 implementation
> for which a driver was posted to the lm-sensors list a few months ago.
> Maybe for this motherboard you should use this driver rather than the
> dme1737 driver. Adding Rudolf in Cc, I think he knows more about this
> driver's status.

Hmm dont know more it seems. Perhaps contact original author? Those ACPI 
routines are not called unless the TMP method for thermal stuff is called. So If 
there will be no readings from the acpi thermal sysfs/proc file the method will 
not run (in theory if the code is write like here)

> The DSDT also includes references to the nforce2's SMBus:
> 
>             Device (SMB0)
>             {
>                 Name (_ADR, 0x000A0001)
>                 OperationRegion (SMCF, PCI_Config, 0x48, 0x10)
>                 Field (SMCF, DWordAcc, NoLock, Preserve)
>                 {
>                     SMPM,   4, 
>                     SMT1,   28, 
>                     SMT2,   32
>                 }
> 
>                 OperationRegion (SMCA, PCI_Config, 0x20, 0x08)
>                 Field (SMCA, DWordAcc, NoLock, Preserve)
>                 {
>                     SB1,    32, 
>                     SB2,    32
>                 }
> 
>                 OperationRegion (PDEV, PCI_Config, 0xE8, 0x04)
>                 Scope (\)
>                 {
>                     Field (\_SB.PCI0.SMB0.PDEV, AnyAcc, NoLock, Preserve)
>                     {
>                             ,   12, 
>                         ACIE,   1
>                     }
>                 }
> 
>                 Method (SMBB, 0, NotSerialized)
>                 {
>                     If (PCIA)
>                     {
>                         And (SB1, 0xFFFE, Local0)
>                     }
>                     Else
>                     {
>                         Store (0x4C00, Local0)
>                     }
> 
>                     Return (Local0)
>                 }
>             }
> 
> So at the very least I'd say it's not safe to use the i2c-nforce2 and
> dme1737 drivers when the fan and thermal ACPI drivers are in use. But
> it may even not be safe when these ACPI drivers aren't loaded, I don't
> know.

It depends what methods are called. Imho if you remove the "thermal" support 
from the ACPI it should be ok. If someone gives me the table, I can take a look.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

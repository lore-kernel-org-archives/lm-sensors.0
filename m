From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 22 Feb 2011 07:50:58 +0000
Subject: Re: [lm-sensors] Using dme1737 to read sensor data when an
Message-Id: <4D636AE2.5090106@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
In-Reply-To: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

James Mills wrote:
> ACPI: resource dme1737 [io  0x0a70-0x0a71] conflicts with ACPI region RNTR [??? 0x00000a00-0x00000a7f flags 0x52]
> ACPI: This conflict may cause random problems and system instability
> 
> Can anyone tell me what the real risk is of using this module in
> conjunction with "lax" ACPI?

The BIOS has created an ACPI resource to prevent the OS from accessing
this I/O region.  Whether this is to prevent the OS from putting some
other device there, or to prevent the OS from accessing the SMBus, is
not known.

If the BIOS has any hardware monitoring function that would make it
access this chip while the computer is running, then there is danger
that the BIOS and the OS try to use it at the same time.  (This usually
happens only with laptops; the DME1737 has an automatic fan control
function that needs to be configured only once when the system is
booted.)

There are other device on the SMBus, such as the clock controller and
the RAM SPD EEPROMs, but those aren't usually accessed by the BIOS
at runtime either.

> Is there a way to put this module in "read-only" mode or some other
> mode that minimizes the potential for system instability?

No; reading data registers requires writing the index register, and
the SMBus controller cannot be shared.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

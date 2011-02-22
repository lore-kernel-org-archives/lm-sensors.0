From: James Mills <jameswmills@gmail.com>
Date: Tue, 22 Feb 2011 16:08:52 +0000
Subject: Re: [lm-sensors] Using dme1737 to read sensor data when an ACPI
Message-Id: <AANLkTim0doQmGFLgd3E6UhcgGNM6zrEfSeaWmypqAQn_@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
In-Reply-To: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Feb 22, 2011 at 1:50 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> James Mills wrote:
>> ACPI: resource dme1737 [io =A00x0a70-0x0a71] conflicts with ACPI region =
RNTR [??? 0x00000a00-0x00000a7f flags 0x52]
>> ACPI: This conflict may cause random problems and system instability
>>
>> Can anyone tell me what the real risk is of using this module in
>> conjunction with "lax" ACPI?
>
> The BIOS has created an ACPI resource to prevent the OS from accessing
> this I/O region. =A0Whether this is to prevent the OS from putting some
> other device there, or to prevent the OS from accessing the SMBus, is
> not known.
>
> If the BIOS has any hardware monitoring function that would make it
> access this chip while the computer is running, then there is danger
> that the BIOS and the OS try to use it at the same time. =A0(This usually
> happens only with laptops; the DME1737 has an automatic fan control
> function that needs to be configured only once when the system is
> booted.)
>
> There are other device on the SMBus, such as the clock controller and
> the RAM SPD EEPROMs, but those aren't usually accessed by the BIOS
> at runtime either.
>
>> Is there a way to put this module in "read-only" mode or some other
>> mode that minimizes the potential for system instability?
>
> No; reading data registers requires writing the index register, and
> the SMBus controller cannot be shared.
>
>
> Regards,
> Clemens
>

Clemens, thanks so much for the helpful answer.

~james

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

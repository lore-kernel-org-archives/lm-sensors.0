From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 May 2014 13:35:00 +0000
Subject: Re: [lm-sensors] info about  driver for chip EMC1402
Message-Id: <5385E604.4050404@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
In-Reply-To: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 05/28/2014 02:24 AM, Kenny Lake wrote:
> Thanks Guenter, I think that my problem is related to this bug because I =
have observed the same behavior. Now I'm using 3.14.4-1-ARCH.
>
>
If you can, cherry-pick commit 9801284 (ACPI: Revert "ACPI / AC: convert AC=
PI ac driver
to platform bus") from the upstram kernel. That should help.

Guenter

> Il Mercoled=EC 28 Maggio 2014 0:26, Guenter Roeck <linux@roeck-us.net> ha=
 scritto:
>
>
> On Tue, May 27, 2014 at 10:13:17PM +0100, Kenny Lake wrote:
>  > Jean
>  > I know that I have a EMC1402 chip because this is what the "sensors-de=
tect" command report:
>  > Driver `to-be-written':
>  >   * Bus `SMBus PIIX4 adapter at 0b00'
>  >     Busdriver `i2c_piix4', I2C address 0x4c
>  >     Chip `SMSC EMC1402' (confidence: 6)
>  > Driver `adm1021':
>  >   * Bus `SMBus PIIX4 adapter at 0b00'
>  >     Busdriver `i2c_piix4', I2C address 0x4e
>  >     Chip `Maxim MAX1617' (confidence: 3)
>  > Driver `k10temp' (autoloaded):
>  >   * Chip `AMD Family 11h thermal sensors' (confidence: 9)
>  > Note: there is no driver for SMSC EMC1402 yet.
>  >
>  >
>  > I searched around but I haven't found a specific vendor's driver for m=
y laptop (HP 6735s) and ACPI has a strange behavior: rarelly, when I turn o=
n my laptop, the fan works, but 90% it doesn't start except when temp is ar=
ound 85 celsius. I have already tried all boot options (acpi=3Dforce, acpi=
=3Doff, acpi=3Dosi_Linux, acpi_enforce_resources=3Dlax) but without succes.
>  >
> What kernel version do you use ? acpi thermal code has a bug
> since 3.13 which causes that kind of behavior.
> See https://bugzilla.kernel.org/show_bug.cgi?id=3D71711.
> This was only fixed last week.
>
> The emc driver won't help you to get this fixed, unfortunately.
> It only reports the temperature ... but you already know that
> it is too high.
>
>
> Guenter
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

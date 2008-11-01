From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 01 Nov 2008 09:39:04 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081101103904.7ea43d94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Peter, Markus,

On Fri, 31 Oct 2008 23:20:58 +0100, Peter Mahlknecht wrote:
> Markus Rechberger schrieb:
> > On Fri, Oct 31, 2008 at 11:08 PM, Peter Mahlknecht <mali100@gmx.net> wr=
ote:
> >> I have here a strange problem:
> >> after loading the em28xx_cx25843 module in
> >> /proc/acpi/thermal_zone/THRM/temperature a wrong temperature (65535 C)=
 which
> >> forces a shutdown on my notebook ("Critical temperature reached (65535=
 C).
> >> Shutting down."). Same thing happens if I load the lm90 module (hwmon =
driver
> >> for the temperaturesensor used by lm-sensors). Both modules depend on
> >> i2c_core, so maybe its an I=B2C bug. Any suggestions?
> >
> > I think the lmsensors mailinglist might be better for this! Jean
> > Delvare might now more about it.
> > added the lm-sensors ML.
> >
> > also provide which kernel version you use.
>
> Thanks for the fast reply,
> I am using Debian Lenny (2.6.26-1-686) on my notebook (Samsung P40 with=20
> the latest Bios 09HK), but had the same problem also with the=20
> 2.6.18-6-686 (Lenny) and with Ubuntu Hardy Heron (think the kernel was=20
> 2.6.24).

It would help if I could see the source code of module em28xx_cx25843,
but unfortunately I have no idea where that driver lives. Markus?

Peter, most probably you have an LM90-compatible sensor chip on the
SMBus and ACPI uses it for thermal regulation and doesn't enjoy another
driver (e.g. lm90) accessing the same chip. That the lm90 driver causes
trouble in that case is more or less expected. That the em28xx_cx25843
driver does is more surprising, but without reading the code I can't
tell why.

Please try the following workaround: blacklist the i2c-i801 driver (or
rmmod it before loading em28xx_cx25843.)

It would also be great if you could give a try to kernel 2.6.27 and
report if you see the following message in the kernel logs:

ACPI: * resource * [0x*-0x*] conflicts with ACPI region * [0x*-0x*]
ACPI: Device needs an ACPI driver

For reference, please also attach the output of dmidecode on this
laptop.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
